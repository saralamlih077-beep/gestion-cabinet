

DROP FUNCTION IF EXISTS get_nom_etudiant;
DROP FUNCTION IF EXISTS nb_etudiants_session;

DROP PROCEDURE IF EXISTS nb_etudiants;
DROP PROCEDURE IF EXISTS verifier_duree;
DROP PROCEDURE IF EXISTS lister_sessions;
DROP PROCEDURE IF EXISTS inscrire_student;
DROP PROCEDURE IF EXISTS lister_etudiants_session;

DROP TRIGGER IF EXISTS trg_check_dates;
DROP TRIGGER IF EXISTS trg_after_inscription;
DROP TRIGGER IF EXISTS before_inscription;




DELIMITER $$

CREATE FUNCTION get_nom_etudiant(p_cine VARCHAR(10)) 
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    DECLARE v_nom VARCHAR(45);

    SELECT nomEtu
    INTO v_nom
    FROM Etudiant
    WHERE numCINEtu = p_cine;

    RETURN v_nom;
END$$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE nb_etudiants()
BEGIN
    DECLARE v_nbEtudiants INT;

    SELECT COUNT(*)
    INTO v_nbEtudiants
    FROM Etudiant;

    SELECT CONCAT('Nombre total des étudiants : ', v_nbEtudiants) AS Resultat;
END$$

DELIMITER ;




DELIMITER $$

CREATE FUNCTION nb_etudiants_session(p_codeSess INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM Inscription
    WHERE codeSess = p_codeSess;

    RETURN total;
END$$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE verifier_duree(IN p_codeForm INT)
BEGIN
    DECLARE v_duree DOUBLE;

    SELECT dureeForm
    INTO v_duree
    FROM Formation
    WHERE codeForm = p_codeForm;

    IF v_duree < 30 THEN
        SELECT 'Formation courte' AS TypeFormation;
    ELSE
        SELECT 'Formation longue' AS TypeFormation;
    END IF;
END$$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE lister_sessions()
BEGIN
    DECLARE fini INT DEFAULT 0;
    DECLARE v_code INT;
    DECLARE v_nom VARCHAR(45);

    DECLARE curSess CURSOR FOR
        SELECT codeSess, nomSess FROM Session;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fini = 1;

    OPEN curSess;

    boucle: LOOP
        FETCH curSess INTO v_code, v_nom;

        IF fini = 1 THEN
            LEAVE boucle;
        END IF;

        SELECT CONCAT(v_code,' - ',v_nom) AS Session;
    END LOOP;

    CLOSE curSess;
END$$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE inscrire_student(
    IN p_codeSess INT,
    IN p_cine VARCHAR(10),
    IN p_typeCours VARCHAR(45),
    IN p_numInscription VARCHAR(45)
)
BEGIN
    START TRANSACTION;

    INSERT INTO Inscription
    VALUES (p_codeSess, p_cine, p_typeCours, p_numInscription);

    IF ROW_COUNT() = 1 THEN
        COMMIT;
        SELECT 'Inscription réussie' AS Resultat;
    ELSE
        ROLLBACK;
        SELECT 'Erreur inscription' AS Resultat;
    END IF;
END$$

DELIMITER ;




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




DELIMITER $$

CREATE TRIGGER before_inscription
BEFORE INSERT ON Inscription
FOR EACH ROW
BEGIN
    IF NEW.typeCours IS NULL THEN
        SET NEW.typeCours = 'Présentiel';
    END IF;
END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER trg_after_inscription
AFTER INSERT ON Inscription
FOR EACH ROW
BEGIN
    -- Trigger sans SELECT (autorisé MySQL)
END$$

DELIMITER ;

