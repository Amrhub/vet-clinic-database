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

-- modify animals table
ALTER TABLE animals ADD COLUMN species text;
ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY; 
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owners_id INT;  
ALTER TABLE animals ADD CONSTRAINT fk_species_animals FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners_animals FOREIGN KEY (owners_id) REFERENCES owners(id);
