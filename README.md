# Airport-Management-System

## 🎯 Projenin Amacı ve Çözüm Yaklaşımı
[cite_start]Modern havalimanlarında birbirinden bağımsız çalışan sistemler veri kopukluğuna ve operasyonel gecikmelere neden olmaktadır[cite: 441]. Bu proje, **PostgreSQL** altyapısını kullanarak şu gerçek hayat problemlerine çözüm üretmiştir:

PostgreSQL tabanlı kapsamlı Havalimanı Yönetim Sistemi. Otomatik sadakat puanı artırma ve kapı durumu güncelleme Trigger'ları, detaylı raporlama View'leri ve normalize edilmiş ilişkisel veritabanı mimarisini içerir.
---

## 🎯 Projenin Amacı ve Çözüm Yaklaşımı
[cite_start]Modern havalimanlarında birbirinden bağımsız çalışan sistemler veri kopukluğuna ve operasyonel gecikmelere neden olmaktadır[cite: 441]. Bu proje, **PostgreSQL** altyapısını kullanarak şu gerçek hayat problemlerine çözüm üretmiştir:

### 1. 🌍 Merkezi Veri Entegrasyonu
[cite_start]Tüm operasyonel birimlerin (Yer hizmetleri, Güvenlik, Yönetim) verilerini tek bir merkezde toplayarak veri güvenilirliğini sağlamış ve bilgi kopukluğunu önlemiştir[cite: 443].

### 2. 🛡️ Güvenlik ve Risk Analizi
[cite_start]Yolcu profilleme sistemi sayesinde, yolcuların geçmiş seyahat verileri ve güvenlik durumları (Örn: Kara Liste kontrolü) anlık olarak sorgulanabilir hale getirilmiştir[cite: 435, 436].

### 3. ⏱️ Operasyonel Verimlilik ve Esneklik
Sefer ekleme, iptal veya rötar durumları anlık yönetilebilir. [cite_start]Hangi uçuşu hangi pilotun ve kabin ekibinin gerçekleştirdiği takip edilerek kaynak planlaması optimize edilmiştir[cite: 423, 424].

### 4. 🧳 Bagaj ve Lojistik Takibi
[cite_start]Yolcu bilet ID'si ile entegre bagaj takip sistemi sayesinde, kayıp bagaj vakaları ve yanlış yönlendirmeler minimize edilmiştir[cite: 426, 450].

---
## 🏗️ Sistem Mimarisi ve Kullanıcı Modülleri
[cite_start]Sistem, farklı kullanıcı gruplarının ihtiyaçlarına göre özelleştirilmiş modüller içerir:

* **👮 Operasyon & Güvenlik:** Uçuş koordinasyonu, kapı atamaları, gümrük ve kimlik doğrulama süreçleri.
* [cite_start]**✈️ Yolcu Hizmetleri:** Biletleme, check-in, bagaj durumu sorgulama ve uçuş süresi takibi[cite: 437].
* [cite_start]**📊 Yönetim (Admin):** Yolcu yoğunluk analizleri, performans raporları ve stratejik karar destek verileri[cite: 454].

---

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

![Havalimanı Veri Çıktısı](Havalimanı_veri_ekleme_çıktısı.png)

<br>

### 🚌 Aşama 2: Ulaşım Verileri Ekleme
Her havalimanının şehir merkeziyle bağlantısını sağlayan Taksi, Otobüs ve Metro seçenekleri, ilgili havalimanının ID'si ile ilişkilendirilerek `Ulaşım` tablosuna işlenmiştir. Bu sayede hangi havalimanında hangi ulaşım aracının olduğu sorgulanabilir.

![Ulaşım Veri Çıktısı](Ulaşım_veri_ekleme_çıktısı.png)

<br>

### 👥 Aşama 3: Yolcu Verileri Ekleme
Sistemi kullanacak yolcuların kimlik, iletişim ve pasaport bilgileri `Yolcu` tablosuna girilmiştir.
* **Önemli Detay:** Sistem, yolcuların hukuki durumunu (Aktif / Kara Liste) takip etmektedir. Çıktıda görüleceği üzere "Kara Liste"deki yolcular veritabanında özel olarak işaretlenmiştir.

![Yolcu Veri Çıktısı](Yolcu_veri_ekleme_çıktısı.png)

<br>

### ✈️ Aşama 4: Havayolu Şirketi Verileri Ekleme
Uçuşları gerçekleştirecek olan Türk Hava Yolları, Lufthansa, Emirates gibi şirketler `HavayoluSirketi` tablosuna iletişim bilgileriyle birlikte kaydedilmiştir.

![Havayolu Veri Çıktısı](Havayolu_sirketi_veri_ekleme_çıktısı.png)

---

