-- VIEW 1: Uçuşlar ve Yolcu Sadakat Puanları Raporu
CREATE OR REPLACE VIEW public.uçuş_yolcu_sadakat AS
SELECT
    u.UçuşID,
    u.Durum AS UçuşDurumu,
    y.AdSoyad AS YolcuAdı,
    s.Puan AS SadakatPuanı,
    s.ÜyelikSeviyesi AS ÜyelikSeviyesi
FROM Uçuş u
JOIN Bilet b ON u.UçuşID = b.UçuşID
JOIN Yolcu y ON b.YolcuID = y.YolcuID
LEFT JOIN SadakatProgramı s ON y.YolcuID = s.YolcuID
ORDER BY u.UçuşID, s.Puan DESC;

-- VIEW 2: Yolcu Seyahat Geçmişi
CREATE OR REPLACE VIEW public.yolcu_seyahat_geçmişi AS
SELECT
    y.AdSoyad AS YolcuAdı,
    u.UçuşID,
    u.Durum AS UçuşDurumu,
    u.KalkışTarihi,
    u.VarışTarihi,
    s.Puan AS SadakatPuanı
FROM Yolcu y
LEFT JOIN Bilet b ON y.YolcuID = b.YolcuID
LEFT JOIN Uçuş u ON b.UçuşID = u.UçuşID
LEFT JOIN SadakatProgramı s ON y.YolcuID = s.YolcuID
ORDER BY y.AdSoyad, u.KalkışTarihi;