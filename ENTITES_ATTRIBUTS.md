# ENTITÉS ET ATTRIBUTS
## Système de Gestion Cabinet Médical

---

## 📊 DIAGRAMME DES ENTITÉS

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│                    UTILISATEUR (Users)                              │
│  ┌────────────────────────────────────────────────────────────────┐ │
│  │ • id (INT, PK, AUTO_INCREMENT)                                 │ │
│  │ • username (VARCHAR 50, UNIQUE, NOT NULL)                      │ │
│  │ • password (VARCHAR 255, NOT NULL)                             │ │
│  │ • role (ENUM: 'doctor', 'secretaire')                          │ │
│  │ • created_at (TIMESTAMP)                                       │ │
│  │ • updated_at (TIMESTAMP)                                       │ │
│  └────────────────────────────────────────────────────────────────┘ │
│                         ▲                    ▲                       │
│                         │                    │                       │
│                    (1,N)│                    │(1,N)                  │
│                         │                    │                       │
└─────────────────────────┼────────────────────┼─────────────────────┘
                          │                    │
        ┌─────────────────┴─────┐      ┌──────┴──────────────┐
        │                       │      │                     │
        ▼                       ▼      ▼                     ▼

┌──────────────────────────┐  ┌────────────────────────┐
│   RENDEZ-VOUS (RDV)      │  │   DIAGNOSTIC           │
├──────────────────────────┤  ├────────────────────────┤
│ • id (INT, PK)           │  │ • id (INT, PK)         │
│ • patient_id (INT, FK)   │  │ • patient_id (INT, FK) │
│ • doctor_id (INT, FK)    │  │ • doctor_id (INT, FK)  │
│ • date (DATE)            │  │ • diagnostic (TEXT)    │
│ • heure (TIME)           │  │ • date_diagnostic (DT) │
│ • type (VARCHAR)         │  │ • notes_suivi (TEXT)   │
│ • status (ENUM)          │  │ • date_modification(TS)│
│ • notes (TEXT)           │  └────────────────────────┘
│ • date_creation (TS)     │           ▲
└────────────┬─────────────┘           │
             │                         │
             │                    (1,N)│
             │                         │
        (1,N)│                         │
             │    ┌──────────────────┬─┘
             └────┤                  │
                  │                  │
                  ▼                  ▼
         ┌──────────────────────────────────┐
         │   PATIENT                        │
         ├──────────────────────────────────┤
         │ • id (INT, PK, AUTO_INCREMENT)   │
         │ • nom (VARCHAR 100, NOT NULL)    │
         │ • prenom (VARCHAR 100, NOT NULL) │
         │ • cin (VARCHAR 20, UNIQUE)       │
         │ • age (INT)                      │
         │ • telephone (VARCHAR 20)         │
         │ • adresse (TEXT)                 │
         │ • date_inscription (TIMESTAMP)   │
         │ • notes (TEXT)                   │
         └──────────────────────────────────┘
```

---

## 🔵 ENTITÉ 1: UTILISATEUR

**Description**: Gère les comptes utilisateurs et leurs rôles  
**Type**: Entité principale  
**Volume**: 10-50 enregistrements

### Attributs

| N° | Nom | Type SQL | Longueur | Clé | Contraintes | Description |
|----|-----|----------|----------|-----|-------------|-------------|
| 1 | **id** | INTEGER | - | PK | AUTO_INCREMENT, NOT NULL | Identifiant unique |
| 2 | username | VARCHAR | 50 | UQ | NOT NULL, UNIQUE | Nom d'utilisateur |
| 3 | password | VARCHAR | 255 | - | NOT NULL | Mot de passe |
| 4 | role | ENUM | - | - | ('doctor', 'secretaire') | Rôle de l'utilisateur |
| 5 | created_at | TIMESTAMP | - | - | DEFAULT CURRENT_TIMESTAMP | Date création |
| 6 | updated_at | TIMESTAMP | - | - | ON UPDATE CURRENT_TIMESTAMP | Date modification |

### Validations & Formats

```
username:
  • Format: [a-zA-Z0-9_.-]
  • Longueur: 5-50 caractères
  • Unique: OUI
  • Exemple: "dr_smith", "admin_01"

password:
  • Longueur min: 6 caractères
  • À chiffrer: SHA256 ou bcrypt
  • Exemple: "doc123", "admin123"

role:
  • Valeurs: 'doctor' ou 'secretaire'
  • Défaut: 'secretaire'
  • Contrôle d'accès: Role-based

created_at / updated_at:
  • Format: YYYY-MM-DD HH:MM:SS
  • Automatique
```

### Données de Test

| id | username | password | role | created_at |
|----|----------|----------|------|------------|
| 1 | admin | admin123 | secretaire | 2025-12-17 09:00:00 |
| 2 | dr_smith | doc123 | doctor | 2025-12-17 09:05:00 |
| 3 | dr_martin | pass456 | doctor | 2025-12-18 10:30:00 |

---

## 🔵 ENTITÉ 2: PATIENT

**Description**: Stocke les informations personnelles des patients  
**Type**: Entité principale  
**Volume**: 100-50,000 enregistrements

### Attributs

| N° | Nom | Type SQL | Longueur | Clé | Contraintes | Description |
|----|-----|----------|----------|-----|-------------|-------------|
| 1 | **id** | INTEGER | - | PK | AUTO_INCREMENT, NOT NULL | Identifiant unique |
| 2 | nom | VARCHAR | 100 | - | NOT NULL | Nom de famille |
| 3 | prenom | VARCHAR | 100 | - | NOT NULL | Prénom |
| 4 | cin | VARCHAR | 20 | UQ | UNIQUE, NOT NULL | Carte identité |
| 5 | age | INTEGER | - | - | CHECK (0-150) | Âge du patient |
| 6 | telephone | VARCHAR | 20 | - | - | Téléphone |
| 7 | adresse | TEXT | - | - | - | Adresse complète |
| 8 | date_inscription | TIMESTAMP | - | - | DEFAULT CURRENT_TIMESTAMP | Date enregistrement |
| 9 | notes | TEXT | - | - | - | Allergies/Notes |

### Validations & Formats

```
nom / prenom:
  • Format: [a-zA-Zàâäæçéèêëïîôùûüœ\s-]
  • Longueur: 2-100 caractères
  • Obligatoire: OUI
  • Exemple: "Dupont", "Marie-Louise"

cin:
  • Format: Alphanumérique 8-20 car
  • Unique: OUI
  • Obligatoire: OUI
  • Exemple: "AB123456", "CD789012"

age:
  • Type: Entier (0-150)
  • Optionnel
  • Exemple: 35, 72

telephone:
  • Format: +212XXX... ou 0XXX...
  • Optionnel
  • Exemple: "0612345678", "+212612345678"

adresse:
  • Format: Texte libre
  • Optionnel
  • Exemple: "123 Rue de Paris, 75001"

notes:
  • Format: Texte libre
  • Optionnel
  • Usage: Allergies, conditions spéciales
  • Exemple: "Allergie pénicilline"
```

### Données de Test

| id | nom | prenom | cin | age | telephone | adresse |
|----|-----|--------|-----|-----|-----------|---------|
| 1 | Dupont | Jean | AB123456 | 45 | 0612345678 | 123 Rue de Paris, 75001 |
| 2 | Martin | Marie | CD789012 | 38 | +212612345678 | 456 Avenue Foch, 75008 |
| 3 | Bernard | Pierre | EF345678 | 52 | 0698765432 | 789 Boulevard Montparnasse |

### Indexes

```sql
INDEX idx_patient_search (nom, prenom, cin)
INDEX idx_patient_cin (cin)
INDEX idx_patient_inscription (date_inscription)
```

---

## 🔵 ENTITÉ 3: RENDEZ-VOUS

**Description**: Gère les consultations médicales planifiées  
**Type**: Entité associative (dépend de PATIENT et UTILISATEUR)  
**Volume**: 1,000-100,000 enregistrements

### Attributs

| N° | Nom | Type SQL | Longueur | Clé | Contraintes | Description |
|----|-----|----------|----------|-----|-------------|-------------|
| 1 | **id** | INTEGER | - | PK | AUTO_INCREMENT, NOT NULL | Identifiant unique |
| 2 | patient_id | INTEGER | - | FK | NOT NULL, FK→PATIENT.id | Référence patient |
| 3 | doctor_id | INTEGER | - | FK | FK→UTILISATEUR.id | Référence médecin |
| 4 | date | DATE | - | - | NOT NULL, >= TODAY | Date RDV |
| 5 | heure | TIME | - | - | NOT NULL | Heure RDV |
| 6 | type | VARCHAR | 50 | - | DEFAULT 'Consultation' | Type consultation |
| 7 | status | ENUM | - | - | ('Confirmé','Annulé','Reporté','Complété') | État RDV |
| 8 | notes | TEXT | - | - | - | Commentaires |
| 9 | date_creation | TIMESTAMP | - | - | DEFAULT CURRENT_TIMESTAMP | Date création |

### Validations & Formats

```
date:
  • Format: YYYY-MM-DD
  • Obligatoire: OUI
  • Condition: >= Date du jour
  • Exemple: "2025-12-20"

heure:
  • Format: HH:MM (24h)
  • Obligatoire: OUI
  • Plage: 08:00 à 19:00
  • Exemple: "14:30", "09:00"

type:
  • Valeurs: 'Consultation', 'Suivi', 'Urgence', 'Contrôle'
  • Défaut: 'Consultation'
  • Exemple: "Suivi"

status:
  • Valeurs: 'Confirmé', 'Annulé', 'Reporté', 'Complété'
  • Défaut: 'Confirmé'
  • Transitions valides:
    - Confirmé → Annulé, Reporté, Complété
    - Reporté → Confirmé, Annulé
    - Complété → (terminal)
    - Annulé → (terminal)

patient_id:
  • Référence: PATIENT(id)
  • Obligatoire: OUI
  • Cascade DELETE

doctor_id:
  • Référence: UTILISATEUR(id)
  • Optionnel
  • SET NULL à la suppression médecin
```

### Données de Test

| id | patient_id | doctor_id | date | heure | type | status |
|----|-----------|-----------|------|-------|------|--------|
| 1 | 1 | 2 | 2025-12-20 | 14:30 | Consultation | Confirmé |
| 2 | 2 | 2 | 2025-12-21 | 10:00 | Suivi | Confirmé |
| 3 | 3 | 3 | 2025-12-22 | 16:00 | Urgence | Annulé |

### Indexes

```sql
INDEX idx_rdv_patient (patient_id)
INDEX idx_rdv_doctor (doctor_id)
INDEX idx_rdv_date (date)
INDEX idx_rdv_status (status)
INDEX idx_rdv_datetime (date, heure)
```

---

## 🔵 ENTITÉ 4: DIAGNOSTIC

**Description**: Stocke l'historique des diagnostics médicaux  
**Type**: Entité associative (dépend de PATIENT et UTILISATEUR)  
**Volume**: 2,000-200,000 enregistrements

### Attributs

| N° | Nom | Type SQL | Longueur | Clé | Contraintes | Description |
|----|-----|----------|----------|-----|-------------|-------------|
| 1 | **id** | INTEGER | - | PK | AUTO_INCREMENT, NOT NULL | Identifiant unique |
| 2 | patient_id | INTEGER | - | FK | NOT NULL, FK→PATIENT.id | Référence patient |
| 3 | doctor_id | INTEGER | - | FK | NOT NULL, FK→UTILISATEUR.id | Référence médecin |
| 4 | diagnostic | LONGTEXT | 65535 | - | NOT NULL, MIN 10 car | Contenu diagnostic |
| 5 | date_diagnostic | DATETIME | - | - | DEFAULT NOW() | Date/heure diagnostic |
| 6 | notes_suivi | TEXT | - | - | - | Notes de suivi |
| 7 | date_modification | TIMESTAMP | - | - | ON UPDATE CURRENT_TIMESTAMP | Dernière modif |

### Validations & Formats

```
diagnostic:
  • Type: LONGTEXT (max 65535 caractères)
  • Obligatoire: OUI
  • Longueur min: 10 caractères
  • Format: Texte libre + formatage
  • Exemple: "Patient présente une hypertension artérielle..."

date_diagnostic:
  • Format: YYYY-MM-DD HH:MM:SS
  • Obligatoire: OUI
  • Défaut: Date/heure actuelle
  • Condition: <= date_modification
  • Exemple: "2025-12-17 14:30:00"

notes_suivi:
  • Format: Texte libre
  • Optionnel
  • Exemple: "Revoir dans 1 mois"

patient_id:
  • Référence: PATIENT(id)
  • Obligatoire: OUI
  • Cascade DELETE

doctor_id:
  • Référence: UTILISATEUR(id) WHERE role='doctor'
  • Obligatoire: OUI
  • RESTRICT DELETE (empêche suppression médecin avec diagnostics)
```

### Données de Test

| id | patient_id | doctor_id | diagnostic | date_diagnostic |
|----|-----------|-----------|------------|-----------------|
| 1 | 1 | 2 | Patient présente hypertension... | 2025-12-17 14:30:00 |
| 2 | 2 | 2 | Diabète type 2 confirmé... | 2025-12-18 10:15:00 |
| 3 | 3 | 3 | Infection respiratoire... | 2025-12-19 16:45:00 |

### Indexes

```sql
INDEX idx_diagnostic_patient (patient_id)
INDEX idx_diagnostic_doctor (doctor_id)
INDEX idx_diagnostic_date (date_diagnostic)
INDEX idx_diagnostic_search (patient_id, date_diagnostic DESC)
```

---

## 📋 TABLEAU SYNTHÉTIQUE

### Vue d'ensemble des entités

| Entité | Attributs | PK | FK | Dépend de | Volume |
|--------|-----------|----|----|-----------|--------|
| UTILISATEUR | 6 | id | - | - | 10-50 |
| PATIENT | 9 | id | - | - | 100-50K |
| RENDEZ-VOUS | 9 | id | 2 (patient, doctor) | PATIENT, UTILISATEUR | 1K-100K |
| DIAGNOSTIC | 7 | id | 2 (patient, doctor) | PATIENT, UTILISATEUR | 2K-200K |

### Comptage total

```
Entités: 4
Attributs totaux: 31
Clés primaires: 4
Clés étrangères: 4
Clés uniques: 2 (username, cin)
Indexes: 10+
```

---

## 🔗 RELATIONS ENTRE ENTITÉS

### Diagramme de relations

```
UTILISATEUR
    │
    ├─→ (1,N) RENDEZ-VOUS (doctor_id)
    │
    └─→ (1,N) DIAGNOSTIC (doctor_id)


PATIENT
    │
    ├─→ (1,N) RENDEZ-VOUS (patient_id)
    │
    └─→ (1,N) DIAGNOSTIC (patient_id)
```

### Cardinalités

| Relation | Type | Contraintes |
|----------|------|-------------|
| UTILISATEUR → RENDEZ-VOUS | 1:N | doctor_id = FK |
| UTILISATEUR → DIAGNOSTIC | 1:N | doctor_id = FK |
| PATIENT → RENDEZ-VOUS | 1:N | patient_id = FK |
| PATIENT → DIAGNOSTIC | 1:N | patient_id = FK |

### Actions CASCADE

```
Si PATIENT est supprimé:
  ✓ RENDEZ-VOUS associés → SUPPRESSION CASCADE
  ✓ DIAGNOSTIC associés → SUPPRESSION CASCADE

Si UTILISATEUR (doctor) est supprimé:
  ✓ RENDEZ-VOUS → doctor_id = NULL (SET NULL)
  ✗ DIAGNOSTIC → REFUSÉ (RESTRICT)
```

---

## 📊 VOLUMÉTRIE ESTIMÉE

### Croissance mensuelle

```
Patients:     +50 à +200/mois
Rendez-vous:  +500 à +2000/mois
Diagnostics:  +1000 à +5000/mois
Utilisateurs: +1 à +5/mois
```

### Taille base de données

```
UTILISATEUR:  50 enregistrements ≈ 10 KB
PATIENT:      10,000 enregistrements ≈ 2 MB
RENDEZ-VOUS:  50,000 enregistrements ≈ 8 MB
DIAGNOSTIC:   100,000 enregistrements ≈ 500 MB
────────────────────────────────────────────
TOTAL ESTIMÉ: ≈ 510 MB
```

---

## ✅ RÉSUMÉ FINAL

### Modèle logique simplifié

```
UTILISATEUR {
  id*, 
  username (UQ), 
  password, 
  role, 
  created_at, 
  updated_at
}

PATIENT {
  id*, 
  nom, 
  prenom, 
  cin (UQ), 
  age, 
  telephone, 
  adresse, 
  date_inscription, 
  notes
}

RENDEZ-VOUS {
  id*, 
  patient_id# (FK→PATIENT), 
  doctor_id# (FK→UTILISATEUR), 
  date, 
  heure, 
  type, 
  status, 
  notes, 
  date_creation
}

DIAGNOSTIC {
  id*, 
  patient_id# (FK→PATIENT), 
  doctor_id# (FK→UTILISATEUR), 
  diagnostic, 
  date_diagnostic, 
  notes_suivi, 
  date_modification
}
```

**Légende**:
- `*` = Clé primaire
- `#` = Clé étrangère
- `UQ` = Unique
- `FK` = Foreign Key

---

**Document généré**: 23 Janvier 2026  
**Version**: 1.0
