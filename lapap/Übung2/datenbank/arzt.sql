CREATE DATABASE arztpraxis;

USE arztpraxis;

-- Tabelle für Ärzte
CREATE TABLE aerzte (
    arzt_id INT AUTO_INCREMENT PRIMARY KEY,
    vorname VARCHAR(50) NOT NULL,
    nachname VARCHAR(50) NOT NULL,
    spezialisierung VARCHAR(100)
);

-- Tabelle für Länder
CREATE TABLE laender (
    land_id INT AUTO_INCREMENT PRIMARY KEY,
    land VARCHAR(50) NOT NULL
);

-- Tabelle für Städte
CREATE TABLE staedte (
    stadt_id INT AUTO_INCREMENT PRIMARY KEY,
    stadt VARCHAR(50) NOT NULL,
    plz VARCHAR(20) NOT NULL,
    land_id INT,
    FOREIGN KEY (land_id) REFERENCES laender(land_id)
);

-- Tabelle für Patienten
CREATE TABLE patienten (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    vorname VARCHAR(50) NOT NULL,
    nachname VARCHAR(50) NOT NULL,
    geburtsdatum DATE NOT NULL,
    strasse VARCHAR(100) NOT NULL,
    hausnummer VARCHAR(10) NOT NULL,
    stadt_id INT NOT NULL,
    telefon VARCHAR(20),
    FOREIGN KEY (stadt_id) REFERENCES staedte(stadt_id)
);

-- Tabelle für Medikamente
CREATE TABLE medikamente (
    medikament_id INT AUTO_INCREMENT PRIMARY KEY,
    medname VARCHAR(100) NOT NULL,
    wirkstoff VARCHAR(100),
    dosierung VARCHAR(50),
    einheit VARCHAR(20)
);

-- Tabelle für Termine
CREATE TABLE termine (
    termin_id INT AUTO_INCREMENT PRIMARY KEY,
    arzt_id INT,
    patient_id INT,
    termin_datum DATE NOT NULL,
    termin_zeit TIME NOT NULL,
    notizen TEXT,
    FOREIGN KEY (arzt_id) REFERENCES aerzte(arzt_id),
    FOREIGN KEY (patient_id) REFERENCES patienten(patient_id)
);

-- Verknüpfungstabelle für Termine und Medikamente (Viele-zu-Viele Beziehung)
CREATE TABLE termin_medikamente (
    termin_id INT,
    medikament_id INT,
    PRIMARY KEY (termin_id, medikament_id),
    FOREIGN KEY (termin_id) REFERENCES termine(termin_id),
    FOREIGN KEY (medikament_id) REFERENCES medikamente(medikament_id)
);
