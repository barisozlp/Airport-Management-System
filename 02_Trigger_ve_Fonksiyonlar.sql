-- ==========================================
-- BÖLÜM 1: FONKSİYONLAR
-- ==========================================

-- FONKSİYON-1) Uçuş Bilet Geliri Hesaplama
-- Aşağıdaki fonksiyon, bir uçuşun ID’sini alır ve o uçuşta satılan 
biletlerden elde edilen toplam geliri yazar. .
CREATE OR REPLACE FUNCTION UçuşBiletGeliri(p_UçuşID INT)
RETURNS FLOAT
LANGUAGE PLPGSQL
AS $$
DECLARE
    ToplamGelir FLOAT;
BEGIN
    SELECT COALESCE(SUM(Fiyat), 0)
    INTO ToplamGelir
    FROM Bilet
    WHERE Bilet.UçuşID = p_UçuşID;
    
    RETURN ToplamGelir;
END;
$$;
SELECT UçuşBiletGeliri(5) AS ToplamGelir; 
SELECT UçuşBiletGeliri(7) AS ToplamGelir;

-- FONKSİYON-2) Kapı Durumlarını Listeleme
-- Bir havalimanındaki kapıların durumunu raporlar.
CREATE OR REPLACE FUNCTION KapıDurumları(p_HavalimanıID INT)
RETURNS TABLE(KapıNumarası VARCHAR(10), Durum VARCHAR(20))
LANGUAGE PLPGSQL
AS $$
BEGIN
    RETURN QUERY
    SELECT k.KapıNumarası, k.Durum
    FROM Kapı k
    INNER JOIN Terminal t ON k.TerminalID = t.TerminalID
    WHERE t.HavalimanıID = p_HavalimanıID;
END;
$$;
SELECT * FROM KapıDurumları(1);  
SELECT * FROM KapıDurumları(2);

-- ==========================================
-- BÖLÜM 2: TRIGGERLAR
-- ==========================================

-- TRIGGER-1) : Otomatik Kapı Durum Güncellemesi
-- Senaryo: Uçuş iptal edilirse, o uçuşun kapısı otomatik 'AÇIK' (Boş) durumuna gelir. Uçuş durumu "İptal Edildi" olarak güncellendiğinde kalkış kapısının 
durumunu otomatik olarak "AÇIK" yapacak şekilde trigger 
oluşturulmuştur.

--Fonksiyon oluşturulması: 
CREATE OR REPLACE FUNCTION kapı_durum_guncelle()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
    -- Eğer uçuş durumu 'İptal Edildi' olarak değişirse
    IF NEW.Durum = 'İptal Edildi' THEN
        UPDATE Kapı
        SET Durum = 'AÇIK'
        WHERE KapıID = OLD.KapıID;
    END IF;
    RETURN NEW;
END;
$$;

--Trigger Oluşturulması: 
CREATE TRIGGER trigger_kapı_durum
BEFORE UPDATE ON Uçuş
FOR EACH ROW
EXECUTE FUNCTION kapı_durum_guncelle();

--Test Durumu: 
UPDATE Uçuş
SET Durum = 'iptal edildi'
Where UçuşID = 5;
SELECT * FROM Kapı WHERE KapıID = (SELECT KapıID FROM Uçuş WHERE UçuşID = 5);

UPDATE Uçuş
SET Durum = 'iptal edildi'
Where UçuşID = 8;
SELECT * FROM Kapı WHERE KapıID = (SELECT KapıID FROM Uçuş WHERE UçuşID = 8);

-- TRIGGER-2) : Yolcu Sadakat Puanı Artırma
-- Senaryo: Bu trigger, bir uçuş "Gerçekleşti" olarak güncellendiğinde, o uçuşta yer 
alan yolcuların sadakat puanlarını otomatik olarak 100 puan artırır.

--Fonksiyon oluşturulması:

CREATE OR REPLACE FUNCTION yolcu_sadakat_puan()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
    -- Sadece durum 'Gerçekleşti' olduğunda puan ver
    IF NEW.Durum = 'Gerçekleşti' THEN
        UPDATE SadakatProgramı
        SET Puan = Puan + 100
        WHERE YolcuID IN (
            SELECT YolcuID FROM Bilet WHERE UçuşID = NEW.UçuşID
        );
    END IF;
    RETURN NEW;
END;
$$;

--Trigger Oluşturulması:

CREATE TRIGGER trigger_yolcu_sadakat_puan
AFTER UPDATE ON Uçuş
FOR EACH ROW
EXECUTE FUNCTION yolcu_sadakat_puan();

--Test Durumu: 
UPDATE Uçuş
SET Durum = 'Gerçekleşti'
Where UçuşID = 4;

-- ==========================================
-- BÖLÜM 3: VERİ BÜTÜNLÜĞÜ (CASCADE)
-- ==========================================

-- Personel silindiğinde görev kayıtlarının da silinmesi
ALTER TABLE UçuşPersonel DROP CONSTRAINT IF EXISTS UçuşPersonel_PersonelID_fkey;

ALTER TABLE UçuşPersonel
ADD CONSTRAINT UçuşPersonel_PersonelID_fkey
FOREIGN KEY (PersonelID) REFERENCES Personel (PersonelID) ON DELETE CASCADE;