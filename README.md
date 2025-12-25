# Airport-Management-System
PostgreSQL tabanlı kapsamlı Havalimanı Yönetim Sistemi. Otomatik sadakat puanı artırma ve kapı durumu güncelleme Trigger'ları, detaylı raporlama View'leri ve normalize edilmiş ilişkisel veritabanı mimarisini içerir.

## 📊 Veritabanı Tasarımı (ER Diyagramı)
Projenin veritabanı mimarisi ve tablolar arası ilişkiler aşağıdaki gibidir.

![Havalimanı ER Diyagramı](Airport_Management_System_ER.jpg)

[📄 Detaylı PDF Diyagramını İndir](Airport_Management_System_ER.pdf)

## ⚙️ Kurulum ve Kullanım (Installation)
Projeyi kendi bilgisayarınızda çalıştırmak için PostgreSQL veritabanında aşağıdaki SQL dosyalarını **sırasıyla** çalıştırınız:

1.  **`01_Tablolar_ve_Veriler.sql`**: Tablo iskeletini oluşturur ve örnek verileri yükler.
### ✈️ Senaryo 1: Sisteme Havalimanı Verisi Girişi
Bu aşamada, boş olan veritabanı sistemine ilk tanımlamalar yapılır. Bir uçuş yönetim sisteminin çalışabilmesi için öncelikle uçuşların gerçekleşeceği lokasyonların (Havalimanlarının) sisteme tanıtılması gerekir.

**Yapılan İşlem:**
SQL dilindeki `INSERT INTO` komutu kullanılarak; İstanbul, Ankara, Paris ve Dubai gibi global merkezlerin adı, şehir bilgisi ve yıllık yolcu kapasiteleri veritabanına işlenmiştir.

**Sistem Çıktısı:**
Aşağıdaki ekran görüntüsü, veriler eklendikten sonra PostgreSQL veritabanından alınan **gerçek anlık görüntüdür**. Görüldüğü üzere sistem, her havalimanına benzersiz bir kimlik (ID) atamış ve kayıtları başarıyla saklamıştır.

![PostgreSQL Havalimanı Veri Çıktısı](Havalimanı_Veri_Ciktisi.png)
3.  **`02_Trigger_ve_Fonksiyonlar.sql`**: Otomasyon sistemlerini (Puan artırma, Kapı güncelleme vb.) devreye alır.
4.  **`03_Views.sql`**: Raporlama ekranlarını oluşturur.
