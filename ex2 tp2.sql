

DROP DATABASE IF EXISTS BD1;
CREATE DATABASE BD1;
USE BD1;



-- Table Client
CREATE TABLE Client (
    CIN VARCHAR(10) PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Adresse VARCHAR(100)
);

-- Table Produit
CREATE TABLE Produit (
    CodeP INT PRIMARY KEY,
    Libelle VARCHAR(50),
    PrixUnitaire DECIMAL(10,2),
    QuantiteStock INT
);

-- Table Commande
CREATE TABLE Commande (
    Ref_cmd INT PRIMARY KEY AUTO_INCREMENT,
    CIN VARCHAR(10),
    CodeP INT,
    QuantiteCmd INT,
    Date_Cmd DATE,
    FOREIGN KEY (CIN) REFERENCES Client(CIN),
    FOREIGN KEY (CodeP) REFERENCES Produit(CodeP)
);



INSERT INTO Client VALUES
('C001', 'Lamlih', 'Sara', 'marrakech'),
('C002', 'Ali', 'Youssef', 'Rabat'),
('C003', 'ben aila', 'Imane', 'Fès');

INSERT INTO Produit VALUES
(101, 'Clavier', 150.00, 50),
(102, 'Souris', 80.00, 100),
(103, 'Écran', 1200.00, 20);



DELIMITER $$

CREATE PROCEDURE passer_commande(
    IN p_CIN VARCHAR(10),
    IN p_CodeP INT,
    IN p_Qte INT
)
BEGIN
    START TRANSACTION;

    -- Vérifier le stock
    UPDATE Produit
    SET QuantiteStock = QuantiteStock - p_Qte
    WHERE CodeP = p_CodeP
      AND QuantiteStock >= p_Qte;

    -- Si stock suffisant, insérer commande et commit
    IF ROW_COUNT() = 1 THEN
        INSERT INTO Commande (CIN, CodeP, QuantiteCmd, Date_Cmd)
        VALUES (p_CIN, p_CodeP, p_Qte, CURDATE());
        COMMIT;
        SELECT CONCAT('Commande réussie pour ', p_CIN, ' produit ', p_CodeP) AS Message;
    ELSE
        ROLLBACK;
        SELECT CONCAT('Commande échouée pour ', p_CIN, ' produit ', p_CodeP, ' : stock insuffisant') AS Message;
    END IF;

END$$

DELIMITER ;



-- Commande réussie
CALL passer_commande('C001', 101, 5);

-- Commande échouée (stock insuffisant)
CALL passer_commande('C002', 103, 30);



SELECT * FROM Client;
SELECT * FROM Produit;
SELECT * FROM Commande;


