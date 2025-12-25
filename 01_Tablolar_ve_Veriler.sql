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

INSERT INTO Havalimanı (HavalimanıID, Ad, Şehir, Ülke, Kapasite) VALUES
(1, 'İstanbul Havalimanı', 'İstanbul', 'Türkiye', 90000000),
(2, 'Sabiha Gökçen Havalimanı', 'İstanbul', 'Türkiye', 40000000),
(3, 'Esenboğa Havalimanı', 'Ankara', 'Türkiye', 15000000);

INSERT INTO HavayoluSirketi (HavaYoluID, Ad, Telefon) VALUES
(1, 'Türk Hava Yolları', '212-123-4567'),
(2, 'Pegasus', '212-234-5678');

INSERT INTO Yolcu (YolcuID, AdSoyad, Telefon, PasaportNo, Durum) VALUES
(1, 'Ahmet Yılmaz', '555-123-0001', 'TR1234567', 'Aktif'),
(2, 'Ayşe Kaya', '555-123-0002', 'TR2345678', 'Aktif'),
(3, 'Mehmet Demir', '555-123-0003', 'TR3456789', 'Aktif');

-- (Diğer INSERT verilerini de buraya ekleyebilirsin, temel örnekler bunlar)