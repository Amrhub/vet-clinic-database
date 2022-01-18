/* Database schema to keep the structure of entire database. */

CREATE TABLE IF NOT EXISTS animals (
    id INT PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT, 
    neutered BOOLEAN,
    weight_kg decimal
);

CREATE TABLE IF NOT EXISTS owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    age INT NOT NULL
);

CREATE TABLE IF NOT EXISTS species (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS vets (
    id  SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE
);

CREATE TABLE IF NOT EXISTS specializations (
    species_id INT NOT NULL,
    vets_id INT NOT NULL,

    PRIMARY KEY(species_id, vets_id),
    CONSTRAINT fk_species_specializations
        FOREIGN KEY(species_id)
            REFERENCES species(id),
    CONSTRAINT fk_vets_specializations
        FOREIGN KEY(vets_id)
            REFERENCES vets(id)
);

CREATE TABLE IF NOT EXISTS visits (
    id INT GENERATE ALWAYS AS IDENTITY,
    animals_id INT NOT NULL,
    vets_id INT NOT NULL,
    date_of_visit DATE NOT NULL,

    CONSTRAINT fk_animals_visits
        FOREIGN KEY(animals_id)
            REFERENCES animals(id)
            ON DELETE CASCADE,
    CONSTRAINT fk_vets_visits
        FOREIGN KEY(vets_id)
            REFERENCES vets(id)
            ON DELETE CASCADE
);

-- modify animals table
ALTER TABLE animals ADD COLUMN species text;
ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY; 
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owners_id INT;  
ALTER TABLE animals ADD CONSTRAINT fk_species_animals FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners_animals FOREIGN KEY (owners_id) REFERENCES owners(id);

-- modify owners table 
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX owners_email_DESC ON owners(email DESC); 