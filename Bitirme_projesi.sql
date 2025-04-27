--1. Üyeler (Members) Tablosu
CREATE TABLE Members (
    uye_id BIGSERIAL PRIMARY KEY,
    kullanici_adi VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    sifre VARCHAR(255) NOT NULL,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Kategoriler (Categories) Tablosu
CREATE TABLE Categories (
    kategori_id SMALLSERIAL PRIMARY KEY,
    kategori_adi VARCHAR(100) UNIQUE NOT NULL
);

-- 3. Eğitimler (Courses) Tablosu
CREATE TABLE Courses (
    kurs_id BIGSERIAL PRIMARY KEY,
    kurs_adi VARCHAR(200) NOT NULL,
    aciklama TEXT,
    baslangic_tarihi DATE,
    bitis_tarihi DATE,
    egitmen VARCHAR(100),
    kategori_id SMALLINT,
    CONSTRAINT fk_for_courses
        FOREIGN KEY (kategori_id)
        REFERENCES Categories(kategori_id)
        ON DELETE SET NULL
);

-- 4. Katılımlar (Enrollments) Tablosu
CREATE TABLE Enrollments (
    katilim_id BIGSERIAL PRIMARY KEY,
    uye_id BIGINT NOT NULL,
    kurs_id BIGINT NOT NULL,
    katilim_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_for_enrollments
        FOREIGN KEY (uye_id)
        REFERENCES Members(uye_id)
        ON DELETE CASCADE,
    CONSTRAINT fk2_for_enrollments
        FOREIGN KEY (kurs_id)
        REFERENCES Courses(kurs_id)
        ON DELETE CASCADE,
    CONSTRAINT unique_enrollments UNIQUE (uye_id, kurs_id)
);

-- 5. Sertifikalar (Certificates) Tablosu
CREATE TABLE Certificates (
    sertifika_id BIGSERIAL PRIMARY KEY,
    serifika_kod VARCHAR(100) UNIQUE NOT NULL,
    verilis_tarihi DATE NOT NULL
);

-- 6. Sertifika Atamaları (CertificateAssignments) Tablosu
CREATE TABLE CertificateAssignments (
    atama_id BIGSERIAL PRIMARY KEY,
    uye_id BIGINT NOT NULL,
    sertifika_id BIGINT NOT NULL,
    atama_tarihi DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_for_CertificateAssignments
        FOREIGN KEY (uye_id)
        REFERENCES Members(uye_id)
        ON DELETE CASCADE,
    CONSTRAINT fk2_for_CertificateAssignments
        FOREIGN KEY (sertifika_id)
        REFERENCES Certificates(sertifika_id)
        ON DELETE CASCADE,
    CONSTRAINT unique_CertificateAssignments UNIQUE (uye_id, sertifika_id)
);

-- 7. Blog Gönderileri (BlogPosts) Tablosu
CREATE TABLE BlogPosts (
    post_id BIGSERIAL PRIMARY KEY,
    baslik VARCHAR(255) NOT NULL,
    icerik TEXT NOT NULL,
    yayinlanma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    yazar_id BIGINT NOT NULL,
    CONSTRAINT fk_for_BlogPosts
        FOREIGN KEY (yazar_id)
        REFERENCES Members(uye_id)
        ON DELETE CASCADE
);