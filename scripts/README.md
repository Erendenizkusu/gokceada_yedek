# Gökçeada — Puan & Yorum Yenileme (refresh_ratings.js)

Mekan **puanları** ve **yorum sayıları** artık elle girilmiyor. Google Places
API'den çekilip **Firestore'a cache**leniyor. Uygulama Places API'yi hiç
çağırmaz — sadece Firestore'dan okur (anlık, bedava, offline). Bu scripti
**3-6 ayda bir** çalıştırman yeterli.

## Tek seferlik kurulum

1. **Google Cloud Console** (proje: `gokceada-688c7`)
   - "APIs & Services" → **Places API**'yi **Enable** et.
   - Faturalandırmayı aç (Places API faturalandırma ister; birkaç düzine mekan
     için maliyet cüzi kalır, aylık ücretsiz kota çoğu zaman yeter).
   - "Credentials" → **Create credentials → API key**. Bu anahtar **sadece bu
     makinede** kalır, uygulamaya konmaz. (İstersen anahtarı API kısıtı olarak
     yalnız "Places API"ye kısıtla.)
2. **Firebase Console** → ⚙️ Project settings → **Service accounts** →
   **Generate new private key** → inen JSON'u bu klasöre
   `serviceAccountKey.json` adıyla koy.
3. Bağımlılıklar:
   ```
   cd scripts
   npm install
   ```

## Çalıştırma (PowerShell)

```powershell
$env:PLACES_API_KEY="AIza...senin_anahtarın..."
node refresh_ratings.js
```

Faydalı bayraklar:

- `--dry` : Firestore'a **yazmadan** ne olacağını gösterir (kuru prova).
- `--only=hotelList` : sadece tek koleksiyonu işler.
- `--refresh-ids` : mevcut `placeId`'leri yok sayıp yeniden çözümler.

## Nasıl çalışır

Her mekan için:
1. Belgede `placeId` yoksa → mekan adı + "Gökçeada" ile Places **Find Place**
   araması yapıp `place_id`'yi bulur ve Firestore'a yazar.
2. Places **Place Details** ile `rating` + `user_ratings_total` çeker.
3. Belgeye `rating` (sayı), `reviewCount` (sayı), `placeId` alanlarını yazar.

Yanlış eşleşen bir mekan olursa: Firestore'da o belgenin `placeId` alanını
doğru değerle elle düzelt, sonra scripti tekrar çalıştır (o belge artık arama
yapmadan doğrudan o place_id'yi kullanır).

## Güvenlik

- `serviceAccountKey.json` ve API anahtarı **gizli**dir — repoya commit etme.
  (`.gitignore`'a eklendi.) Uygulama derlemesine de girmezler.
