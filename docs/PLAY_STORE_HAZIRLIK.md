# Gokceada Cepte — Play Store Yükleme Rehberi

Uygulama: **Gokceada Cepte** · Paket: `com.gokceada.cepte` · versionCode **12** / versionName **1.2.0**
İletişim e-postası: denizkusueren61@gmail.com

> Not: Play Console arayüzü Türkçe olduğu için aşağıda menü adları Türkçe verildi (parantez içinde İngilizceleri var, dil farklıysa diye).

---

## 0. DURUM ÖZETİ (2026-08-03)

- ✅ **Yeni yükleme anahtarı üretildi:** `C:\keystore\gokceada-upload.jks` (alias `myAlias`, şifre `Oo11qq22ww+`). Eski keystore'un şifresi kayıptı; eski uygulama kapalı hesapta olduğu için sorun değil — bu yeni bir uygulama girişi.
  - **Upload SHA-1:** `12:7E:49:50:36:BE:66:B4:E4:43:96:4F:5E:4E:9F:2C:F9:5D:4E:4A`
  - **Upload SHA-256:** `1C:DA:4D:59:21:24:EA:A8:79:8C:FA:D8:53:03:20:58:85:68:E6:5F:C0:5E:66:8D:B1:18:EF:A7:B0:48:4F:42`
  - ⚠️ Bu dosyayı + şifreyi **yedekle**. Kaybedersen aynı sorun tekrarlar.
- ✅ **Paket adı:** `com.gokceada.gokceadarehber` (Play'de rezerve) → **`com.gokceada.cepte`**. Android kodu ve Firebase güncellendi.
- ✅ **İmzalı .aab hazır:** `build\app\outputs\bundle\release\app-release.aab` (111 MB). Yüklenecek dosya bu.

---

## 1. Gizlilik Politikası URL'si (zorunlu)

Hazır sayfa: `docs/index.html` (bu klasörde). İki barındırma seçeneğinden birini seç:

**Seçenek A — GitHub Pages (ücretsiz, önerilen):**
1. GitHub'da **herkese açık (public)** bir repo aç (ör. `gokceada-privacy`).
2. `docs/index.html` dosyasını repoya at.
3. Repo → **Settings → Pages** → Source: `main` / `/root` (veya dosyayı `/docs`'a koyduysan `/docs`) → Save.
4. Birkaç dakika sonra URL hazır: `https://<kullanıcı-adın>.github.io/gokceada-privacy/`
5. Bu URL'yi Play Console'da **Uygulama içeriği (App content) → Gizlilik politikası (Privacy policy)** alanına yapıştır.

**Seçenek B — Elinde site/host varsa:** `index.html`'i oraya koy, çıkan URL'yi kullan.

---

## 2. Uygulama Erişimi / "Oturum açma bilgileri" (App access)

**Seçilen cevap → "Hayır" (kısıtlanmış bölüm yok).** ✅ (2026-08-03)

Gerekçe: Uygulamanın asıl içeriği (mekanlar, plajlar, harita, otobüs/feribot saatleri, haberler) giriş yapmadan tamamen erişilebilir. Giriş yalnızca opsiyonel yorum/fotoğraf paylaşımı için gerekli; incelemeci uygulamanın neredeyse tamamını girişsiz görebiliyor.

**Küçük risk:** İncelemeci özellikle yorum/paylaşım özelliğini test etmek isterse giriş yapamayabilir (Google ile Giriş kullandığından kendi hesabıyla girebilir de). Reddedilirse bu ekran **düzenlenebilir** → "Evet"e çevirip aşağıdaki test hesabını verirsin:
- **Kullanıcı adı:** ayrı açılmış bir **test Gmail hesabı** (2 Adımlı Doğrulaması KAPALI; asıl hesabını verme)
- **Şifre:** o test hesabının şifresi
- **Ek talimatlar:**
```
Uygulamaya giriş menüden "Google ile Oturum Aç" ile yapılır. Rehber içeriği
giriş yapmadan da tamamen erişilebilir; giriş yalnızca yorum ve fotoğraf
paylaşımı için gereklidir.
```

---

## 3. Veri Güvenliği Formu (Uygulama içeriği → Veri güvenliği / Data safety)

Aşağıdaki cevapları **birebir** işaretle. Uygulamanın gerçekte topladığı veriye göre doğrulandı.

**Genel sorular:**
- Uygulamanız kullanıcı verisi topluyor mu / paylaşıyor mu? → **Evet**
- Tüm kullanıcı verileri aktarım sırasında şifreleniyor mu? → **Evet** (Firebase HTTPS)
- Kullanıcılara verilerini silme yolu sunuyor musunuz? → **Evet** (uygulama içi "Hesabı Sil" + e-posta)

**Toplanan veri türleri** (her biri için: Toplandı = Evet):

| Veri türü (Console'daki Türkçe adı) | Toplandı | Paylaşıldı | Amaç | Zorunlu mu? |
|---|---|---|---|---|
| **Konum → Yaklaşık konum** | Evet | Hayır | Uygulama işlevi | İsteğe bağlı (izne bağlı) |
| **Konum → Kesin konum** | Evet | Hayır | Uygulama işlevi | İsteğe bağlı (izne bağlı) |
| **Kişisel bilgiler → E-posta adresi** | Evet | Hayır | Uygulama işlevi, Hesap yönetimi | İsteğe bağlı (giriş yaparsa) |
| **Kişisel bilgiler → Ad** (Google profil adı) | Evet | Hayır | Uygulama işlevi, Hesap yönetimi | İsteğe bağlı |
| **Fotoğraflar ve videolar → Fotoğraflar** | Evet | Hayır | Uygulama işlevi | İsteğe bağlı (paylaşırsa) |
| **Uygulama etkinliği → Diğer kullanıcı tarafından oluşturulan içerik** (yorum/puan) | Evet | Hayır | Uygulama işlevi | İsteğe bağlı |
| **Cihaz veya diğer kimlikler** (Reklam kimliği / Advertising ID) | Evet | **Evet** | **Reklam veya pazarlama** | — |

> Önemli: "Reklam kimliği" AdMob için Google ile **paylaşılır** → o satırda Paylaşıldı = **Evet**, amaç **Reklam veya pazarlama**. Diğer tüm satırlarda Paylaşıldı = Hayır.
> Konum "İsteğe bağlı" çünkü kullanıcı izin vermezse de uygulama çalışıyor. E-posta/fotoğraf da isteğe bağlı (giriş/paylaşım seçime bağlı).

**Hesap oluşturma yöntemi (bu formda sorulur):**
- Sadece **OAuth** işaretle. Uygulama Google ile Oturum Aç kullanıyor (e-posta/şifre ile kayıt YOK).
- ❌ "Kullanıcı adı ve şifre" ve "Kullanıcı adı, şifre ve diğer kimlik doğrulama bilgileri" → **işaretleme**.

**Hesap silme URL'si (bu formda istenir):**
- Hazır sayfa: `docs/hesap-silme.html`. Gizlilik politikasıyla aynı repoya (`gokceada-privacy`) koy.
- URL: `https://denizkusueren17.github.io/gokceada-privacy/hesap-silme.html`
- Uygulama içi silme (Menü → Hesabı Sil) zaten var; bu URL, uygulaması olmayanlar için gereken web yolu.

**Gizlilik politikası URL'si (yayında):** `https://denizkusueren17.github.io/gokceada-privacy/`

---

## 4. Reklamlar & İçerik Derecelendirmesi

- **Uygulama içeriği → Reklamlar (Ads):** "Uygulamanız reklam içeriyor mu?" → **Evet** (AdMob).
- **İçerik derecelendirmesi (IARC anketi):** Uygulama şiddet/cinsellik/kumar içermiyor.
  - Şiddet: Hayır · Cinsellik: Hayır · Kaba dil: Hayır · Kontrollü madde: Hayır · Kumar: Hayır
  - "Kullanıcılar içerik paylaşabiliyor mu / iletişim kurabiliyor mu?" sorusuna: yorum & fotoğraf paylaşımı olduğu için **Evet** (dürüst beyan).
  - Sonuç genelde **PEGI 3 / Herkes** civarı çıkar.
- **Hedef kitle (Target audience):** 13+ (çocuklara yönelik değil → "Hayır, öncelikli olarak çocuklara yönelik değil").
- **Haber uygulaması mı?** Hayır (haber karoseli var ama uygulama bir turizm rehberi).

---

## 5. Mağaza Girişi Metinleri (Ana mağaza girişi / Store listing)

**Uygulama adı (30 karakter):**
```
Gokceada Cepte
```

**Kısa açıklama (80 karakter):**
```
Gökçeada'yı keşfet: gezilecek yerler, yeme-içme, plajlar, konaklama ve ulaşım.
```

**Tam açıklama (uzun):**
```
Gokceada Cepte, Türkiye'nin en büyük adası ve bir Cittaslow (Sakin Şehir) olan
Gökçeada'yı keşfetmenin en kolay yolu.

Adayı ziyaret ederken ihtiyacın olan her şey tek uygulamada:

🏝️ Gezilecek Yerler — Adanın saklı koyları, plajları ve görülmeye değer noktaları
🍽️ Nerede Yenir — Restoranlar, kafeler, kahvaltı mekânları ve barlar
🏨 Konaklama — Oteller, pansiyonlar ve kamp alanları
🏖️ Plajlar — Aydıncık, Kefalos, Laz Koyu ve adanın en güzel plajları
🚌 Ulaşım — Otobüs ve feribot saatleri
🗺️ Harita & Yol Tarifi — Mekânlara tek dokunuşla ulaş
💬 Yorumlar & Puanlar — Diğer gezginlerin deneyimlerini gör, kendi yorumunu paylaş
📰 Güncel Haberler — Ada ile ilgili güncel gelişmeler
📸 Sizin Gözünüzden Ada — Kendi fotoğraflarını toplulukla paylaş

Uygulama 6 dilde kullanılabilir: Türkçe, İngilizce, Yunanca, Bulgarca ve Rumence.

Gökçeada'nın tadını çıkar!
```

**Kategori:** Seyahat ve Yerel (Travel & Local)
**Etiketler/anahtar kelimeler:** gökçeada, imroz, ada, tatil, gezi, rehber, plaj, cittaslow

---

## 6. Görsel Varlıklar (HAZIR ✅)

Hepsi hazırlandı → `C:\Users\User\OneDrive\Masaüstü\gokceada_cepte_ss\play_hazir\`

| Play Console alanı | Dosya | Boyut |
|---|---|---|
| Uygulama simgesi | `UYGULAMA_IKONU_512.png` | 512×512 (yakın kıyı — lagün+plaj) |
| Öne çıkan grafik | `OZELLIK_GRAFIGI_1024x500.png` | 1024×500 (gün batımı + başlık) |
| Telefon ekran görüntüleri | `01.png` … `05.png` | 1080×2160 ×5 |

> Not: Ekran görüntüleri 385px kaynaktan büyütüldüğü için hafif yumuşak; keskinlik istersen gerçek telefon çözünürlüğünde (1080×2400) yeniden çekip aynı klasöre at, tekrar işlerim.

---

## 7. Yükleme Sonrası: Google ile Giriş için SHA-1 (çok önemli)

`.aab`'yi yükleyince **Play App Signing (Play uygulama imzalama)** otomatik açılır — gerçek kullanıcılara giden imzayı Google üretir, senin upload anahtarından farklıdır. O yüzden Google ile Giriş'in production'da çalışması için:

1. Play Console → **Yayın (Release) → Kurulum (Setup) → Uygulama bütünlüğü (App integrity)** → **App signing key certificate** altındaki **SHA-1**'i kopyala.
2. [Firebase Console](https://console.firebase.google.com) → proje **gokceada-688c7** → ⚙️ Proje ayarları → `com.gokceada.cepte` uygulaması → **Parmak izi ekle** → o Play SHA-1'ini ekle.
3. (Upload SHA-1'i `12:7E:49:...:4A` zaten ekledin — ikisi de dursun.)

Bunu yapmazsan uygulama açılır ama giriş ekranında hata verir.

---

## 8. Güvenlik: Google Maps API anahtarlarını kısıtla

Maps API anahtarı kod içinde (manifest). Sızarsa başkası kullanıp sana fatura çıkarabilir. **Google Cloud Console → API'ler ve Hizmetler → Kimlik bilgileri (Credentials):**
- Anahtar için **Uygulama kısıtlamaları → Android uygulamaları** → paket adı `com.gokceada.cepte` + SHA-1 (`12:7E:49:50:36:BE:66:B4:E4:43:96:4F:5E:4E:9F:2C:F9:5D:4E:4A`) ekle. Play App Signing SHA-1'ini de ekle.
- **API kısıtlamaları** → sadece kullandığın API'lara (Maps SDK for Android vb.) kısıtla.
- SHA-1'i tekrar almak için: `keytool -list -v -keystore C:\keystore\gokceada-upload.jks -alias myAlias`

---

## 9. Yükleme Sırası (özet kontrol listesi)

1. [x] İmzalı `.aab` üretildi → `build\app\outputs\bundle\release\app-release.aab`
2. [ ] Gizlilik politikasını barındır, URL'yi al (Bölüm 1)
3. [ ] Play Console → uygulama oluştur (paket `com.gokceada.cepte`)
4. [ ] **Üretim (Production) → Yeni sürüm oluştur** → `.aab`'yi yükle, sürüm notu yaz
5. [ ] **Uygulama erişimi:** test hesabı + talimat (Bölüm 2)
6. [ ] **Uygulama içeriği:** Gizlilik politikası · Veri güvenliği · Reklamlar · İçerik derecelendirmesi · Hedef kitle (Bölüm 3-4)
7. [ ] **Mağaza girişi:** ad, açıklamalar, simge, öne çıkan grafik, ekran görüntüleri (Bölüm 5-6)
8. [ ] Play App Signing SHA-1'ini Firebase'e ekle (Bölüm 7)
9. [ ] Maps anahtarını kısıtla (Bölüm 8)
10. [ ] İncelemeye gönder

---

## 9.5 ÜRETİME ÇIKMADAN YAPILACAKLAR (bekleyen)

- [ ] **A — Fotoğraf izni temizliği (READ_MEDIA_IMAGES kaldır):** Kapalı testte "Fotoğraf ve video izinleri" ekranı gerekçe metniyle geçildi (B yolu). Üretimden ÖNCE: `AndroidManifest.xml`'den `READ_MEDIA_IMAGES` iznini kaldır, `users_console.dart`'taki `Permission.photos` kapısını çıkar (file_picker sistem seçicisiyle izinsiz çalışır), versionCode'u 13 yap, yeniden derle, yükle. Böylece bu politika ekranı tamamen kalkar. Kod değişikliği küçük.
- [x] **Hedef API düzeyi (targetSdk 35→36):** Play uyarısı — 31 Ağustos 2026'dan itibaren güncellemeler API 36 (Android 16) hedeflemeli. `build.gradle`'da `targetSdk = 36` yapıldı (compileSdk zaten 36'ydı). Yükleme gerekmez; **path A rebuild'iyle aynı .aab'de** (versionCode 13) çıkacak. Kapalı test sürümünü etkilemez.
- [ ] **API anahtarı kısıtlaması (Bölüm 8):** güvenlik; zorunlu değil ama üretim öncesi yapılması iyi.
- [ ] **Play App Signing SHA-1'ini Firebase'e ekle (Bölüm 7):** production'da Google ile Giriş için şart.

---

## 10. App Store (sonraya — Apple hesabı alınca)

Kodda önceden hazırladıklarım hazır (ATT metni, plist temizliği).

### Sign in with Apple — KOD TARAFI BİTTİ (2026, Windows)
- ✅ `pubspec.yaml`: `sign_in_with_apple: ^6.1.0` (çözülen 6.1.4) + `crypto: ^3.0.3`, `pub get` tamam.
- ✅ `lib/services/auth_service.dart`: `signInWithApple()` — güvenli nonce (SHA-256) + `OAuthProvider('apple.com')` + Firebase `signInWithCredential`; Apple ilk girişte verdiği ad/soyadı `updateDisplayName` ile kaydeder.
- ✅ `lib/pages/login_register_page.dart`: `loginWithApple()` + `LoginScreenBottomSide`'da **sadece iOS'ta** görünen resmi `SignInWithAppleButton` (kullanıcı iptali sessiz geçilir).
- ✅ `ios/Runner/Runner.entitlements` oluşturuldu (`com.apple.developer.applesignin = Default`).
- `flutter analyze` → yeni hata/uyarı yok.
- **Mac'te kalan (Xcode):** (1) Signing & Capabilities → **+ Sign in with Apple** (App ID + entitlement'ı bağlar), (2) **Firebase Console → Authentication → Apple provider'ı etkinleştir**, (3) `cd ios && pod install`.

### Kalan iOS işleri
- ATT runtime izin istemi (`app_tracking_transparency` paketi)
- Gizlilik "nutrition labels" (Veri güvenliği'nin App Store karşılığı)

### iOS Bundle ID — DEĞİŞTİRME (2026 güncelleme)
- iOS Bundle ID her yerde `com.gokceada.gokceadarehber` (project.pbxproj x3 config + GoogleService-Info.plist + Firebase iOS app proje `gokceada-688c7`). **Aynı bırak.** Apple hesabı satın alınınca mevcut Gökçeada uygulaması bu Bundle ID ile hesapta geri geldi → App Store Connect'te aynı uygulamanın altına **"+ Sürüm veya Platform"** ile yeni versiyon oluşturup üstüne yayınlanır (sıfırdan uygulama açmaya gerek YOK). Bundle ID değişirse Apple bunu yeni uygulama sayar ve üstüne yazamazsın — o yüzden eski plandaki "`.cepte`'ye çevir" notu İPTAL.
- **Keystore App Store'u ilgilendirmez** (Android'e özel); iOS imzası Apple sertifikası + provisioning profile ile Xcode'da yapılır.
- **Build için Mac şart:** Kullanıcı Windows'ta. iOS archive+upload için macOS+Xcode gerekir (fiziksel Mac veya Codemagic/bulut Mac). Bu, iOS yayınının önündeki ana pratik engel.
