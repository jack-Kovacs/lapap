-- anzahl der PAtienten pro Praxis
SELECT a.name AS Arztpraxis, COUNT(p.idPatient) AS Anzahl_Patienten
FROM Arztpraxis a
LEFT JOIN Patient p ON a.idArztpraxis = p.Arztpraxis_idArztpraxis
GROUP BY a.idArztpraxis;
-- Anzahl der Befunde pro Patient mindestens ein Befund
SELECT p.vorname, p.nachname, COUNT(b.befID) AS Anzahl_Befunde, t.datum AS Datum_Befund
FROM Patient p
LEFT JOIN Befund b ON p.idPatient = b.Patient_id
LEFT JOIN Termin t ON b.Termin_terID = t.terID
GROUP BY p.idPatient, t.datum
HAVING Anzahl_Befunde > 0;
