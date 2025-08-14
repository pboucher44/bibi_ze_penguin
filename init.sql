-- Créer un rôle pour PostgREST
CREATE ROLE web_anon NOLOGIN;

-- Table des utilisateurs (simplifiée)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    age INTEGER CHECK (age >= 0 AND age <= 120),
    gender VARCHAR(10) CHECK (gender IN ('male', 'female')),
    kcal_authorized INTEGER NOT NULL,
    kcal_consumed INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Donner les permissions au rôle web_anon
GRANT USAGE ON SCHEMA bibi TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON users TO web_anon;
GRANT web_anon TO root;

-- Données de test
INSERT INTO users (username, age, gender, kcal_authorized, kcal_consumed) VALUES
    ('jean', 25, 'male', 2500, 0),
    ('marie', 30, 'female', 2000, 0),
    ('paul', 45, 'male', 2200, 0),
    ('sophie', 22, 'female', 1800, 0);
