-- FONKSİYON 1: Uçuş Bilet Geliri Hesaplama
-- Bir uçuşun ID'sini alır ve toplam geliri döner.

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

-- FONKSİYON 2: Kapı Durumları Listeleme
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

-- TRIGGER 1: Otomatik Kapı Durum Güncellemesi
-- Uçuş iptal edilirse kapıyı 'AÇIK' yapar.
CREATE OR REPLACE FUNCTION kapı_durum_guncelle()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
    IF NEW.Durum = 'İptal Edildi' THEN
        UPDATE Kapı
        SET Durum = 'AÇIK'
        WHERE KapıID = OLD.KapıID;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_kapı_durum
BEFORE UPDATE ON Uçuş
FOR EACH ROW
EXECUTE FUNCTION kapı_durum_guncelle();

-- TRIGGER 2: Yolcu Sadakat Puanı Artırma
-- Uçuş gerçekleşirse yolcuya 100 puan ekler.
CREATE OR REPLACE FUNCTION yolcu_sadakat_puan()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN
    UPDATE SadakatProgramı
    SET Puan = Puan + 100
    WHERE YolcuID IN (
        SELECT YolcuID FROM Bilet WHERE UçuşID = NEW.UçuşID
    );
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_yolcu_sadakat_puan
AFTER UPDATE ON Uçuş
FOR EACH ROW
EXECUTE FUNCTION yolcu_sadakat_puan();