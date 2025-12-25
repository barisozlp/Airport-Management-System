# Airport-Management-System
PostgreSQL tabanlı kapsamlı Havalimanı Yönetim Sistemi. Otomatik sadakat puanı artırma ve kapı durumu güncelleme Trigger'ları, detaylı raporlama View'leri ve normalize edilmiş ilişkisel veritabanı mimarisini içerir.

## 📊 Veritabanı Tasarımı (ER Diyagramı)
Projenin veritabanı mimarisi ve tablolar arası ilişkiler aşağıdaki gibidir.

![Havalimanı ER Diyagramı](Airport_Management_System_ER.jpg)

[📄 Detaylı PDF Diyagramını İndir](Airport_Management_System_ER.pdf)

# ✈️ Airport Database Management System

PostgreSQL tabanlı kapsamlı Havalimanı Yönetim Sistemi. Otomatik sadakat puanı artırma ve kapı durumu güncelleme Trigger'ları, detaylı raporlama View'leri ve normalize edilmiş ilişkisel veritabanı mimarisini içerir.

---

## ⚙️ Kurulum (Installation)
Projeyi çalıştırmak için SQL dosyalarını aşağıdaki sırayla çalıştırınız:
1.  **`01_Tablolar_ve_Veriler.sql`**: Tabloları oluşturur ve 4 temel veri setini (Havalimanı, Ulaşım, Yolcu, Havayolu) yükler.
2.  **`02_Trigger_ve_Fonksiyonlar.sql`**: Otomasyonları devreye alır.
3.  **`03_Views.sql`**: Raporları hazırlar.

---

## 🚀 Veritabanı Yaşam Döngüsü ve Kanıtlar
Projenin veritabanı inşası, gerçek hayat senaryosuna uygun olarak 4 aşamada veri oluşturma işlemi random gerçekleştirilmiştir. Her aşamanın PostgreSQL üzerindeki **gerçek işlem çıktıları** aşağıda sunulmuştur.

### 📍 Aşama 1: Havalimanı Verileri Ekleme İşlemi
Sistemin ilk adımı, uçuşların gerçekleşeceği lokasyonların sisteme tanıtılmasıdır. İstanbul, Londra, Dubai gibi merkezler `Havalimanı` tablosuna benzersiz ID'ler ile kaydedilmiştir.

![Havalimanı Veri Çıktısı](01_Havalimani_Ciktisi.png)

<br>

### 🚌 Aşama 2: Ulaşım Verileri Ekleme
Her havalimanının şehir merkeziyle bağlantısını sağlayan Taksi, Otobüs ve Metro seçenekleri, ilgili havalimanının ID'si ile ilişkilendirilerek `Ulaşım` tablosuna işlenmiştir. Bu sayede hangi havalimanında hangi ulaşım aracının olduğu sorgulanabilir.

![Ulaşım Veri Çıktısı](02_Ulasim_Ciktisi.png)

<br>

### 👥 Aşama 3: Yolcu Verileri Ekleme
Sistemi kullanacak yolcuların kimlik, iletişim ve pasaport bilgileri `Yolcu` tablosuna girilmiştir.
* **Önemli Detay:** Sistem, yolcuların hukuki durumunu (Aktif / Kara Liste) takip etmektedir. Çıktıda görüleceği üzere "Kara Liste"deki yolcular veritabanında özel olarak işaretlenmiştir.

![Yolcu Veri Çıktısı](03_Yolcu_Ciktisi.png)

<br>

### ✈️ Aşama 4: Havayolu Şirketi Verileri Ekleme
Uçuşları gerçekleştirecek olan Türk Hava Yolları, Lufthansa, Emirates gibi şirketler `HavayoluSirketi` tablosuna iletişim bilgileriyle birlikte kaydedilmiştir.

![Havayolu Veri Çıktısı](04_Havayolu_Ciktisi.png)

---

