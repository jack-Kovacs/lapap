START TRANSACTION;

-- Sozialversicherung
INSERT INTO Sozialversicherung (sozname) VALUES 
('AOK'),
('TK'),
('BARMER'),
('DAK-Gesundheit'),
('Techniker Krankenkasse'),
('IKK classic'),
('hkk Krankenkasse'),
('Kaufmännische Krankenkasse - KKH'),
('Novitas BKK'),
('BKK VBU');

-- Arztpraxis
INSERT INTO Arztpraxis (name) VALUES 
('Praxis Dr. Müller'),
('Praxis Dr. Schmidt'),
('Praxis Dr. Wagner'),
('Praxis Dr. Becker'),
('Praxis Dr. Hoffmann'),
('Praxis Dr. Schulz'),
('Praxis Dr. Weber'),
('Praxis Dr. Richter'),
('Praxis Dr. Klein'),
('Praxis Dr. Fischer');

-- Patient
INSERT INTO Patient (vorname, nachname, geburtstag, Sozialversicherung_sozID, Arztpraxis_idArztpraxis, svnr) VALUES 
('Max', 'Mustermann', '1990-01-01', 1, 1, '1234567890'),
('Anna', 'Musterfrau', '1985-05-15', 2, 2, '2345678901'),
('Peter', 'Schmidt', '1978-11-30', 3, 3, '3456789012'),
('Maria', 'Meier', '1995-07-20', 4, 4, '4567890123'),
('Thomas', 'Müller', '1980-03-10', 5, 5, '5678901234'),
('Sarah', 'Schulz', '1982-08-25', 6, 6, '6789012345'),
('Andreas', 'Koch', '1976-09-05', 7, 7, '7890123456'),
('Julia', 'Bauer', '1993-02-12', 8, 8, '8901234567'),
('Michael', 'Wagner', '1972-04-18', 9, 9, '9012345678'),
('Laura', 'Hofmann', '1988-06-22', 10, 10, '0123456789');

-- Termin
INSERT INTO Termin (datum) VALUES 
('2024-06-10 10:00:00'),
('2024-06-11 11:00:00'),
('2024-06-12 12:00:00'),
('2024-06-13 13:00:00'),
('2024-06-14 14:00:00'),
('2024-06-15 15:00:00'),
('2024-06-16 16:00:00'),
('2024-06-17 17:00:00'),
('2024-06-18 18:00:00'),
('2024-06-19 19:00:00');

-- Befund
INSERT INTO Befund (beschreibung, Termin_terID, Patient_id) VALUES 
('Fieber', 1, 1),
('Halsschmerzen', 2, 2),
('Bauchschmerzen', 3, 3),
('Kopfschmerzen', 4, 4),
('Rückenschmerzen', 5, 5),
('Erkältung', 6, 6),
('Verstauchung', 7, 7),
('Allergie', 8, 8),
('Bluthochdruck', 9, 9),
('Diabetes', 10, 10);

-- Medikament
INSERT INTO Medikament (medname) VALUES 
('Ibuprofen'),
('Paracetamol'),
('Aspirin'),
('Ciprofloxacin'),
('Amoxicillin'),
('Lorazepam'),
('Omeprazole'),
('Simvastatin'),
('Metformin'),
('Albuterol');

-- Befund_has_Medikament
INSERT INTO Befund_has_Medikament (Befund_befID, Medikament_medID, dosierung) VALUES 
(1, 1, '1-1-1'),
(2, 2, '1-1-1'),
(3, 3, '1-1-1'),
(4, 4, '1-1-1'),
(5, 5, '1-1-1'),
(6, 6, '1-1-1'),
(7, 7, '1-1-1'),
(8, 8, '1-1-1'),
(9, 9, '1-1-1'),
(10, 10, '1-1-1');

COMMIT;
