DROP DATABASE IF EXISTS BD2;
CREATE DATABASE BD2;
USE BD2;

CREATE TABLE Personne (
    nump INT PRIMARY KEY,
    nomp VARCHAR(50),
    prenomp VARCHAR(50),
    age INT
);

CREATE TABLE Voiture (
    matricule VARCHAR(20) PRIMARY KEY,
    modele VARCHAR(50),
    annee INT,
    nump INT,
    FOREIGN KEY (nump) REFERENCES Personne(nump)
);

CREATE TABLE Voyage (
    nump INT,
    matricule VARCHAR(20),
    ville VARCHAR(50),
    datev DATE,
    PRIMARY KEY(nump, matricule, datev),
    FOREIGN KEY (nump) REFERENCES Personne(nump),
    FOREIGN KEY (matricule) REFERENCES Voiture(matricule)
);

-- Insertion initiale
INSERT INTO Personne VALUES
(1,'saad','nasi',25),
(2,'Sara','lamlih',19);

INSERT INTO Voiture VALUES
('V001','Toyota',2020,1),
('V002','Peugeot',2019,2);

INSERT INTO Voyage VALUES
(1,'V001','Paris','2026-01-10'),
(2,'V002','Marseille','2026-01-12');

DELIMITER $$

CREATE FUNCTION TesterTable() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE nb INT;
    SELECT COUNT(*) INTO nb FROM Personne;
    IF nb < 10 THEN
        RETURN 0;
    ELSE
        RETURN 1;
    END IF;
END$$

CREATE PROCEDURE AjouterPersonne(
    IN p_nump INT,
    IN p_nomp VARCHAR(50),
    IN p_prenomp VARCHAR(50),
    IN p_age INT
)
BEGIN
    IF TesterTable() = 0 THEN
        INSERT INTO Personne(nump, nomp, prenomp, age)
        VALUES (p_nump, p_nomp, p_prenomp, p_age);
    ELSE
        SELECT 'Table pleine' AS Message;
    END IF;
END$$

CREATE PROCEDURE AjouterVoiture(
    IN p_matricule VARCHAR(20),
    IN p_modele VARCHAR(50),
    IN p_annee INT,
    IN p_nump INT
)
BEGIN
    DECLARE age_personne INT DEFAULT 0;
    SELECT age INTO age_personne FROM Personne WHERE nump = p_nump;

    IF age_personne >= 18 THEN
        INSERT INTO Voiture(matricule, modele, annee, nump)
        VALUES (p_matricule, p_modele, p_annee, p_nump);
    ELSE
        SELECT CONCAT('La personne ', p_nump, ' est mineure. Ajout annulé.') AS Message;
    END IF;
END$$

DELIMITER ;

-- Affichage du statut des voyages par personne
SELECT 
    p.nump,
    p.nomp,
    p.prenomp,
    CASE 
        WHEN COUNT(v.matricule) = 0 THEN 'Pas de voyage'
        WHEN COUNT(v.matricule) < 4 THEN 'Nombre de voyages inférieur à 4'
        ELSE 'Cinq voyages ou plus'
    END AS StatutVoyage
FROM Personne p
LEFT JOIN Voyage v ON p.nump = v.nump
GROUP BY p.nump, p.nomp, p.prenomp;

-- Tests des procédures
CALL AjouterPersonne(3,'Khalid','Youssef',30);
CALL AjouterPersonne(4,'Mouna','Samir',28);

CALL AjouterVoiture('V003','Honda',2021,3);
CALL AjouterVoiture('V004','BMW',2022,2); -- cette insertion sera refusée car Sara est mineure
