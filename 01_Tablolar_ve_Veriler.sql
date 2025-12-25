-- 1. Tabloların Oluşturulması

CREATE TABLE Havalimanı (
    HavalimanıID SERIAL PRIMARY KEY,
    Ad VARCHAR(100) NOT NULL,
    Şehir VARCHAR(50) NOT NULL,
    Ülke VARCHAR(50) NOT NULL,
    Kapasite INT NOT NULL
);

CREATE TABLE HavayoluSirketi (
    HavaYoluID SERIAL PRIMARY KEY,
    Ad VARCHAR(100) NOT NULL,
    Telefon VARCHAR(20)
);

CREATE TABLE Uçak (
    UçakID SERIAL PRIMARY KEY,
    Model VARCHAR(50),
    Kapasite INT,
    HavaYoluID INT REFERENCES HavayoluSirketi(HavaYoluID)
);

CREATE TABLE Terminal (
    TerminalID SERIAL PRIMARY KEY,
    TerminalAdı VARCHAR(50),
    HavalimanıID INT REFERENCES Havalimanı(HavalimanıID)
);

CREATE TABLE Kapı (
    KapıID SERIAL PRIMARY KEY,
    KapıNumarası VARCHAR(10),
    Durum VARCHAR(20),
    TerminalID INT REFERENCES Terminal(TerminalID)
);

CREATE TABLE Uçuş (
    UçuşID SERIAL PRIMARY KEY,
    KalkışTarihi DATE NOT NULL,
    VarışTarihi DATE NOT NULL,
    KalkışSaati TIME NOT NULL,
    VarışSaati TIME NOT NULL,
    KalkışHavalimanıID INT REFERENCES Havalimanı(HavalimanıID),
    VarışHavalimanıID INT REFERENCES Havalimanı(HavalimanıID),
    HavaYoluID INT REFERENCES HavayoluSirketi(HavaYoluID),
    UçakID INT REFERENCES Uçak(UçakID),
    KapıID INT REFERENCES Kapı(KapıID),
    Durum VARCHAR(20) DEFAULT 'Planlandı'
);

CREATE TABLE Yolcu (
    YolcuID SERIAL PRIMARY KEY,
    AdSoyad VARCHAR(100) NOT NULL,
    Telefon VARCHAR(15),
    PasaportNo VARCHAR(20),
    Durum VARCHAR(20) DEFAULT 'Aktif'
);

CREATE TABLE Bilet (
    BiletID SERIAL PRIMARY KEY,
    UçuşID INT REFERENCES Uçuş(UçuşID) ON DELETE CASCADE,
    YolcuID INT REFERENCES Yolcu(YolcuID) ON DELETE CASCADE,
    KoltukNo VARCHAR(5) NOT NULL,
    Sınıf VARCHAR(20) NOT NULL,
    Fiyat DECIMAL(10, 2) NOT NULL,
    SatınAlmaTarihi DATE NOT NULL
);

CREATE TABLE Ulaşım (
    UlaşımID SERIAL PRIMARY KEY,
    AraçTipi VARCHAR(50) NOT NULL,
    Saatler VARCHAR(100) NOT NULL,
    Ücret DECIMAL(10, 2) NOT NULL,
    HavalimanıID INT REFERENCES Havalimanı(HavalimanıID) ON DELETE CASCADE
);

CREATE TABLE SadakatProgramı (
    ProgramID SERIAL PRIMARY KEY,
    YolcuID INT REFERENCES Yolcu(YolcuID),
    Puan INT DEFAULT 0,
    ÜyelikSeviyesi VARCHAR(20) DEFAULT 'Bronz'
);

CREATE TABLE Personel (
    PersonelID INT PRIMARY KEY,
    AdSoyad TEXT NOT NULL,
    Görev TEXT NOT NULL
);

CREATE TABLE UçuşPersonel (
    UçuşID INT REFERENCES Uçuş(UçuşID),
    PersonelID INT REFERENCES Personel(PersonelID) ON DELETE CASCADE,
    GörevSüresi INT,
    PRIMARY KEY (UçuşID, PersonelID)
);

-- 2. Örnek Verilerin Eklenmesi

-- 1) Havalimanı Verileri
INSERT INTO Havalimanı (HavalimanıID, Ad, Şehir, Ülke, Kapasite) VALUES
(1, 'İstanbul Havalimanı', 'İstanbul', 'Türkiye', 90000000),
(2, 'Sabiha Gökçen Havalimanı', 'İstanbul', 'Türkiye', 40000000),
(3, 'Esenboğa Havalimanı', 'Ankara', 'Türkiye', 15000000),
(4, 'Antalya Havalimanı', 'Antalya', 'Türkiye', 35000000),
(5, 'Adnan Menderes Havalimanı', 'İzmir', 'Türkiye', 20000000),
(6, 'Atatürk Havalimanı', 'İstanbul', 'Türkiye', 70000000),
(7, 'Frankfurt Havalimanı', 'Frankfurt', 'Almanya', 65000000),
(8, 'Charles de Gaulle Havalimanı', 'Paris', 'Fransa', 72000000),
(9, 'Heathrow Havalimanı', 'Londra', 'Birleşik Krallık', 80000000),
(10, 'Dubai Uluslararası Havalimanı', 'Dubai', 'BAE', 88000000);

-- 2) Havayolu Şirketi Verileri
INSERT INTO HavayoluSirketi (HavaYoluID, Ad, Telefon) VALUES
(1, 'Türk Hava Yolları', '212-123-4567'),
(2, 'Pegasus', '212-234-5678'),
(3, 'SunExpress', '212-345-6789'),
(4, 'AtlasGlobal', '212-456-7890'),
(5, 'Lufthansa', '49-123-4567'),
(6, 'Air France', '33-123-4567'),
(7, 'British Airways', '44-123-4567'),
(8, 'Emirates', '971-123-4567'),
(9, 'Qatar Airways', '974-123-4567'),
(10, 'Singapore Airlines', '65-123-4567');

-- 3) Yolcu Verileri
INSERT INTO Yolcu (YolcuID, AdSoyad, Telefon, PasaportNo, Durum) VALUES
(1, 'Ahmet Yılmaz', '555-123-0001', 'TR1234567', 'Aktif'),
(2, 'Ayşe Kaya', '555-123-0002', 'TR2345678', 'Aktif'),
(3, 'Mehmet Demir', '555-123-0003', 'TR3456789', 'Aktif'),
(4, 'Fatma Çelik', '555-123-0004', 'TR4567890', 'Aktif'),
(5, 'Ali Şahin', '555-123-0005', 'TR5678901', 'Kara Liste'),
(6, 'Zehra Aksoy', '555-123-0006', 'TR6789012', 'Aktif'),
(7, 'Burak Taş', '555-123-0007', 'TR7890123', 'Aktif'),
(8, 'Elif Aydın', '555-123-0008', 'TR8901234', 'Kara Liste'),
(9, 'Hüseyin Uzun', '555-123-0009', 'TR9012345', 'Aktif'),
(10, 'Emine Bulut', '555-123-0010', 'TR0123456', 'Aktif');


SELECT setval(pg_get_serial_sequence('Havalimanı', 'havalimanıid'), 10);
SELECT setval(pg_get_serial_sequence('HavayoluSirketi', 'havayoluid'), 10);
SELECT setval(pg_get_serial_sequence('Yolcu', 'yolcuid'), 10);