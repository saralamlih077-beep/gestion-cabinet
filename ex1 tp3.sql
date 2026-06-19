DROP DATABASE IF EXISTS CentreFormation;
CREATE DATABASE CentreFormation;
USE CentreFormation;

CREATE TABLE Etudiant (
    numCINEtu VARCHAR(10) PRIMARY KEY,
    nomEtu VARCHAR(50),
    prenomEtu VARCHAR(50)
);

CREATE TABLE Specialite (
    codeSpec INT PRIMARY KEY,
    nomSpec VARCHAR(50),
    etat ENUM('active','inactive') DEFAULT 'active'
);

CREATE TABLE Session (
    codeSess INT PRIMARY KEY,
    nomSess VARCHAR(50),
    codeSpec INT,
    dateDebut DATE,
    dateFin DATE,
    FOREIGN KEY (codeSpec) REFERENCES Specialite(codeSpec)
);

CREATE TABLE Inscription (
    codeSess INT,
    numCINEtu VARCHAR(10),
    typeCours VARCHAR(45) DEFAULT 'Présentiel',
    PRIMARY KEY (codeSess, numCINEtu),
    FOREIGN KEY (codeSess) REFERENCES Session(codeSess),
    FOREIGN KEY (numCINEtu) REFERENCES Etudiant(numCINEtu)
);

CREATE TABLE LogInscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numCINEtu VARCHAR(10),
    codeSess INT,
    dateLog TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    message VARCHAR(255)
);

-- 1️⃣ Procédure pour inscrire un étudiant
DELIMITER $$
CREATE PROCEDURE inscrire_etudiant(
    IN p_codeSess INT,
    IN p_CIN VARCHAR(10),
    IN p_typeCours VARCHAR(45)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Etudiant WHERE numCINEtu = p_CIN)
       AND EXISTS (SELECT 1 FROM Session WHERE codeSess = p_codeSess AND dateFin > dateDebut) THEN
        INSERT INTO Inscription(codeSess, numCINEtu, typeCours)
        VALUES(p_codeSess, p_CIN, p_typeCours);
    END IF;
END$$
DELIMITER ;

-- 2️⃣ Procédure pour vérifier l'état d'une spécialité
DELIMITER $$
CREATE PROCEDURE verifier_specialite(IN p_codeSpec INT)
BEGIN
    DECLARE etatSpec ENUM('active','inactive');

    SELECT etat INTO etatSpec
    FROM Specialite
    WHERE codeSpec = p_codeSpe
    IF etatSpec IS NOT NULL THEN
        SELECT CONCAT('Spécialité ', p_codeSpec, ' est ', etatSpec) AS Message;
    ELSE
        SELECT CONCAT('Spécialité ', p_codeSpec, ' n''existe pas') AS Message;
    END IF;
END$$
DELIMITER ;

call verifier_specialite(1);


-- 3️⃣ Fonction qui retourne le nombre d'étudiants inscrits dans une session
DELIMITER $$
CREATE FUNCTION nb_etudiants_session(p_codeSess INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Inscription
    WHERE codeSess = p_codeSess;
    RETURN total;
END$$
DELIMITER ;

-- 4️⃣ Trigger pour empêcher insertion si dateFin <= dateDebut
DROP TRIGGER IF EXISTS trg_check_dates;

DELIMITER $$

CREATE TRIGGER trg_check_dates
BEFORE INSERT ON Session
FOR EACH ROW
BEGIN
    IF NEW.dateFin <= NEW.dateDebut THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'dateFin doit être supérieure à dateDebut';
    END IF;
END$$

DELIMITER ;


-- 5️⃣ Trigger après inscription pour enregistrer un message
DROP TRIGGER IF EXISTS trg_after_inscription;
DELIMITER $$
CREATE TRIGGER trg_after_inscription
AFTER INSERT ON Inscription
FOR EACH ROW
BEGIN
    INSERT INTO LogInscriptions(numCINEtu, codeSess, message)
    VALUES(NEW.numCINEtu, NEW.codeSess, CONCAT('Inscription réussie pour l''étudiant ', NEW.numCINEtu));
END$$
DELIMITER ;

-- 🔹 Données de test
INSERT INTO Etudiant VALUES
('E1234','saad','nasi'),
('E1242','Sara','LAMLIH');

INSERT INTO Specialite VALUES
(1,'Informatique','active'),
(2,'Mathématiques','inactive');

-- Session valides
INSERT INTO Session(codeSess, nomSess, codeSpec, dateDebut, dateFin)
SELECT 101,'Session Info',1,'2026-02-01','2026-03-01'
WHERE '2026-03-01' > '2026-02-01';

INSERT INTO Session(codeSess, nomSess, codeSpec, dateDebut, dateFin)
SELECT 102,'Session Math',2,'2026-02-15','2026-02-28'
WHERE '2026-02-28' > '2026-02-15';

-- Tentative insertion d'une session invalide (sera ignorée)
INSERT INTO Session(codeSess, nomSess, codeSpec, dateDebut, dateFin)
SELECT 103,'Session Test',1,'2026-03-01','2026-02-01'
WHERE '2026-02-01' > '2026-03-01';

-- Inscription des étudiants
INSERT INTO Inscription(codeSess, numCINEtu, typeCours) VALUES (101,'E1234','Présentiel');
INSERT INTO Inscription(codeSess, numCINEtu, typeCours) VALUES (101,'E1242','En ligne');

-- Vérification spécialité
CALL verifier_specialite(1);
CALL verifier_specialite(2);

-- Nombre d'étudiants inscrits
SELECT nb_etudiants_session(101) AS NbEtudiants;

-- Logs d'inscription
SELECT * FROM LogInscriptions;





