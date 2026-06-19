-- ============================================================================
-- Medical Cabinet Database Setup
-- Gestion Cabinet Médical
-- ============================================================================

-- Drop database if exists
DROP DATABASE IF EXISTS medical_cabinet;

-- Create database
CREATE DATABASE medical_cabinet CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE medical_cabinet;

-- ============================================================================
-- Table: users (Login System)
-- ============================================================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('secretaire', 'doctor') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- Table: patients (Patient Management)
-- ============================================================================
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    cin VARCHAR(20) UNIQUE,
    age INT,
    telephone VARCHAR(20),
    adresse TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_nom (nom),
    INDEX idx_cin (cin)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- Table: rendezvous (Appointment Management)
-- ============================================================================
CREATE TABLE rendezvous (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    date DATE NOT NULL,
    heure VARCHAR(10) NOT NULL,
    type VARCHAR(50),
    status ENUM('pending', 'confirmed', 'completed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    INDEX idx_date (date),
    INDEX idx_patient (patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- Table: diagnostics (Diagnostic Management)
-- ============================================================================
CREATE TABLE diagnostics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnostic TEXT NOT NULL,
    date_diagnostic DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_patient (patient_id),
    INDEX idx_date (date_diagnostic)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- Insert Default Users (Admin Credentials)
-- ============================================================================
-- Admin user (password: admin123)
INSERT INTO users (username, password, role) VALUES 
('admin', 'admin123', 'secretaire'),
('dr_smith', 'doc123', 'doctor');

-- ============================================================================
-- Sample Patients Data (Optional)
-- ============================================================================
INSERT INTO patients (nom, prenom, cin, age, telephone, adresse) VALUES
('Dupont', 'Jean', 'C123456', 45, '+212612345678', 'Rue des Fleurs, Casablanca'),
('Martin', 'Sophie', 'C234567', 32, '+212623456789', 'Avenue Mohammed V, Rabat'),
('Bernard', 'Pierre', 'C345678', 58, '+212634567890', 'Boulevard Anfa, Casablanca');

-- ============================================================================
-- Sample Appointments Data (Optional)
-- ============================================================================
INSERT INTO rendezvous (patient_id, date, heure, type, status) VALUES
(1, '2025-12-15', '14:30', 'Consultation', 'confirmed'),
(2, '2025-12-16', '09:00', 'Suivi', 'pending'),
(3, '2025-12-17', '11:00', 'Examen', 'confirmed');

-- ============================================================================
-- Sample Diagnostics Data (Optional)
-- ============================================================================
INSERT INTO diagnostics (patient_id, doctor_id, diagnostic, date_diagnostic) VALUES
(1, 2, 'Patient présente des symptômes de fatigue chronique. Recommandé: analyse sanguine complète et repos.', '2025-12-10'),
(2, 2, 'Diagnostic: Hypertension artérielle légère. Traitement: régime alimentaire équilibré et exercice régulier.', '2025-12-08');

-- ============================================================================
-- Database Permissions (Optional - Adjust as needed)
-- ============================================================================
-- CREATE USER 'medical_user'@'localhost' IDENTIFIED BY 'medical_password';
-- GRANT ALL PRIVILEGES ON medical_cabinet.* TO 'medical_user'@'localhost';
-- FLUSH PRIVILEGES;

-- ============================================================================
-- Verification Queries
-- ============================================================================
SELECT 'Database created successfully!' AS status;
SELECT 'Users count: ' AS info, COUNT(*) FROM users;
SELECT 'Patients count: ' AS info, COUNT(*) FROM patients;
SELECT 'Appointments count: ' AS info, COUNT(*) FROM rendezvous;
SELECT 'Diagnostics count: ' AS info, COUNT(*) FROM diagnostics;
