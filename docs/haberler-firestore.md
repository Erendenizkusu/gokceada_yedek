# Haber Koroseli — Firestore Kurulumu

Ana ekrandaki haber koroseli, Firestore'daki **`news`** koleksiyonundan beslenir.
Haberleri Firebase Console'dan elle eklersin; uygulama tarafında ekstra bir şey
gerekmez.

## Koleksiyon: `news`

Her haber bir dokümandır. Alanlar:

| Alan          | Tip       | Zorunlu | Açıklama                                                        |
|---------------|-----------|---------|-----------------------------------------------------------------|
| `title`       | string    | Evet    | Kartın üzerinde görünen başlık.                                  |
| `subtitle`    | string    | Hayır   | Başlığın altındaki ikinci satır (isteğe bağlı).                 |
| `imageUrl`    | string    | Evet    | Kartta gösterilecek görselin internet adresi (dış URL).         |
| `linkUrl`     | string    | Evet    | Karta tıklanınca uygulama içi WebView'da açılacak haber linki.   |
| `isActive`    | boolean   | Evet    | `true` ise koroselde görünür, `false` ise gizlenir.             |
| `publishedAt` | timestamp | Evet    | Sıralama için. En yeni tarih en başta gösterilir.               |

> Not: Koleksiyon boşsa veya hiç `isActive: true` haber yoksa, ana ekrandaki
> haber bölümü tamamen gizlenir.

## Örnek doküman

```json
{
  "title": "Gökçeada'da Zeytin Hasadı Başladı",
  "subtitle": "Bu yıl rekolte geçen seneye göre yüksek",
  "imageUrl": "https://ornek-site.com/gorseller/zeytin-hasadi.jpg",
  "linkUrl": "https://gokceada.bel.tr/haber/zeytin-hasadi",
  "isActive": true,
  "publishedAt": "2026-07-16T09:00:00Z"
}
```

Console'da `publishedAt` alanını eklerken tipini **timestamp** seç ve tarihi
takvimden gir.

## Firestore güvenlik kuralı (önerilen)

Haberler herkese açık okunabilir, ama yalnızca yetkili biri
(admin) yazabilmelidir. Örnek kural:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Haberleri herkes okuyabilir
    match /news/{doc} {
      allow read: if true;
      allow write: if false; // yazma sadece Firebase Console'dan yapılır
    }

    // ... mevcut diğer kurallar ...
  }
}
```

`allow write: if false;` olduğunda uygulamadan yazma engellenir; sen yine de
Console'dan doküman ekleyip düzenleyebilirsin.

## Gerekli dizin (index)

Sorgu `isActive == true` filtresi ve `publishedAt` sıralamasını birlikte
kullanır. Firebase ilk çalıştırmada gerekli bileşik index'i (composite index)
isteyebilir; Console'daki hata mesajındaki linke tıklayıp "Create index"
demen yeterli.
