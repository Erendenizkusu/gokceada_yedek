#!/usr/bin/env node
/**
 * refresh_ratings.js — Gökçeada Cepte
 * ------------------------------------------------------------------
 * Puanları ve yorum sayılarını Google Places API'den çeker ve
 * Firestore'a CACHE'ler. Uygulama artık Places API'yi hiç çağırmaz;
 * sadece Firestore'dan okur (anlık, bedava, offline). Bu scripti
 * 3-6 ayda bir sen elle çalıştırırsın — Gökçeada küçük bir yer,
 * puanlar sık değişmez.
 *
 * Ne yapar (her mekan için):
 *   1) placeId yoksa → Places "Find Place from Text" ile mekan adı +
 *      "Gökçeada" araması yapıp place_id'yi bulur ve Firestore'a yazar.
 *   2) Places "Place Details" ile rating + user_ratings_total çeker.
 *   3) Firestore belgesine rating (sayı) + reviewCount (sayı) + placeId
 *      alanlarını geri yazar.
 *
 * Kurulum (bir kez):
 *   1) Google Cloud Console → "Places API"yi etkinleştir + faturalandırmayı aç.
 *   2) Bir API anahtarı oluştur (SADECE bu makinede kalır, uygulamaya KONMAZ).
 *   3) Firebase Console → Project settings → Service accounts →
 *      "Generate new private key" → indirilen dosyayı bu klasöre
 *      `serviceAccountKey.json` adıyla koy.
 *   4) `cd scripts && npm install`
 *
 * Çalıştırma:
 *   PowerShell:  $env:PLACES_API_KEY="AIza..."; node refresh_ratings.js
 *   (kuru prova, yazma yapmadan görmek için):  node refresh_ratings.js --dry
 *   (tek koleksiyon):  node refresh_ratings.js --only=hotelList
 *   (placeId'leri tazele, yeniden çözümle):  node refresh_ratings.js --refresh-ids
 */

const admin = require("firebase-admin");
const path = require("path");

// --- Ayarlar ---------------------------------------------------------------

// Puan/yorum çekilecek mekan koleksiyonları. gezilecekList & activitiesList
// (görülecek yerler / plajlar) puan göstermediği için burada YOK.
const COLLECTIONS = [
  { name: "hotelList", nameKey: "hotel_name" },
  { name: "pansionList", nameKey: "pansion_name" },
  { name: "restaurantList", nameKey: "restaurant_name" },
  { name: "campingList", nameKey: "camping_name" },
  { name: "barList", nameKey: "barName" },
  { name: "cafeList", nameKey: "cafeName" },
  { name: "breakfastList", nameKey: "breakfast_name" },
  { name: "hediyelikList", nameKey: "hediyelikName" },
  { name: "surfingList", nameKey: "restaurant_name" },
];

// Find Place aramasına eklenen bağlam — doğru mekanı bulma şansını artırır.
const SEARCH_SUFFIX = " Gökçeada";
const LANGUAGE = "tr";

// --- CLI bayrakları ---------------------------------------------------------

const args = process.argv.slice(2);
const DRY_RUN = args.includes("--dry");
const REFRESH_IDS = args.includes("--refresh-ids");
const onlyArg = args.find((a) => a.startsWith("--only="));
const ONLY = onlyArg ? onlyArg.split("=")[1] : null;

const API_KEY = process.env.PLACES_API_KEY;
if (!API_KEY) {
  console.error(
    "HATA: PLACES_API_KEY ortam değişkeni tanımlı değil.\n" +
      'PowerShell: $env:PLACES_API_KEY="AIza..."; node refresh_ratings.js'
  );
  process.exit(1);
}

// --- Firebase Admin ---------------------------------------------------------

try {
  const serviceAccount = require(path.join(__dirname, "serviceAccountKey.json"));
  admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
} catch (e) {
  console.error(
    "HATA: serviceAccountKey.json bulunamadı/okunamadı. Firebase Console → " +
      "Project settings → Service accounts → Generate new private key ile " +
      "indirip bu klasöre koy.\n" +
      e.message
  );
  process.exit(1);
}

const db = admin.firestore();

// --- Yardımcılar ------------------------------------------------------------

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

// Places API (New) — Text Search. Returns placeId + rating + review count in a
// single call. Docs: https://developers.google.com/maps/documentation/places/web-service/text-search
async function searchPlace(name) {
  const res = await fetch("https://places.googleapis.com/v1/places:searchText", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-Goog-Api-Key": API_KEY,
      "X-Goog-FieldMask":
        "places.id,places.displayName,places.rating,places.userRatingCount",
    },
    body: JSON.stringify({
      textQuery: name + SEARCH_SUFFIX,
      languageCode: LANGUAGE,
      regionCode: "TR",
    }),
  });
  const json = await res.json();
  if (json.error) {
    return { ok: false, status: json.error.status, error: json.error.message };
  }
  if (!json.places || json.places.length === 0) {
    return { ok: false, status: "ZERO_RESULTS" };
  }
  const p = json.places[0];
  return {
    ok: true,
    placeId: p.id,
    rating: p.rating ?? null,
    reviewCount: p.userRatingCount ?? 0,
  };
}

// Places API (New) — Place Details for a known place id (used when a placeId is
// already cached on the document).
async function fetchDetailsById(placeId) {
  const res = await fetch(
    `https://places.googleapis.com/v1/places/${encodeURIComponent(placeId)}` +
      `?languageCode=${LANGUAGE}`,
    {
      headers: {
        "X-Goog-Api-Key": API_KEY,
        "X-Goog-FieldMask": "id,rating,userRatingCount",
      },
    }
  );
  const json = await res.json();
  if (json.error) {
    return { ok: false, status: json.error.status, error: json.error.message };
  }
  return {
    ok: true,
    rating: json.rating ?? null,
    reviewCount: json.userRatingCount ?? 0,
  };
}

// --- Ana akış ---------------------------------------------------------------

async function processCollection({ name, nameKey }) {
  const snap = await db.collection(name).get();
  console.log(`\n=== ${name} (${snap.size} mekan) ===`);
  let ok = 0;
  let skipped = 0;
  let failed = 0;

  for (const doc of snap.docs) {
    const data = doc.data();
    const placeName = (data[nameKey] || "").toString().trim();
    if (!placeName) {
      console.log(`  · [atlandı] isim boş (${doc.id})`);
      skipped++;
      continue;
    }

    let placeId = (data.placeId || "").toString().trim();
    let rating;
    let reviewCount;

    if (placeId && !REFRESH_IDS) {
      // placeId zaten var → doğrudan detay çek.
      const d = await fetchDetailsById(placeId);
      await sleep(150);
      if (!d.ok) {
        console.log(
          `  ✗ ${placeName}: detay alınamadı (${d.status})` +
            (d.error ? ` — ${d.error}` : "")
        );
        failed++;
        continue;
      }
      rating = d.rating;
      reviewCount = d.reviewCount;
    } else {
      // placeId yok (ya da --refresh-ids) → arama tek çağrıda hepsini verir.
      const s = await searchPlace(placeName);
      await sleep(150);
      if (!s.ok) {
        console.log(
          `  ✗ ${placeName}: bulunamadı (${s.status})` +
            (s.error ? ` — ${s.error}` : "")
        );
        failed++;
        continue;
      }
      placeId = s.placeId;
      rating = s.rating;
      reviewCount = s.reviewCount;
    }

    const update = {
      placeId,
      rating: rating != null ? rating : data.rating || "",
      reviewCount: reviewCount,
    };

    console.log(
      `  ✓ ${placeName}: ${update.rating} ★ (${update.reviewCount} yorum)` +
        (DRY_RUN ? "  [dry]" : "")
    );

    if (!DRY_RUN) {
      await doc.ref.set(update, { merge: true });
    }
    ok++;
  }

  console.log(`--- ${name}: ${ok} güncellendi, ${skipped} atlandı, ${failed} hata`);
  return { ok, skipped, failed };
}

(async () => {
  const targets = ONLY
    ? COLLECTIONS.filter((c) => c.name === ONLY)
    : COLLECTIONS;

  if (targets.length === 0) {
    console.error(`--only=${ONLY} bilinen bir koleksiyon değil.`);
    process.exit(1);
  }

  console.log(
    `Gökçeada puan/yorum yenileme ${DRY_RUN ? "(KURU PROVA)" : ""}` +
      `${REFRESH_IDS ? " [placeId'ler yeniden çözümlenecek]" : ""}`
  );

  const totals = { ok: 0, skipped: 0, failed: 0 };
  for (const c of targets) {
    const r = await processCollection(c);
    totals.ok += r.ok;
    totals.skipped += r.skipped;
    totals.failed += r.failed;
  }

  console.log(
    `\nBİTTİ. Toplam: ${totals.ok} güncellendi, ${totals.skipped} atlandı, ` +
      `${totals.failed} hata.`
  );
  if (totals.failed > 0) {
    console.log(
      "Not: place_id bulunamayan mekanlar için Firestore'da ilgili belgeye " +
        "elle 'placeId' alanı ekleyip scripti tekrar çalıştırabilirsin."
    );
  }
  process.exit(0);
})().catch((e) => {
  console.error("Beklenmeyen hata:", e);
  process.exit(1);
});
