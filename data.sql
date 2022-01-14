/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(1, 'Agumon', '2020-02-03', '10.23', true, 0);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(2, 'Gabumon', '2018-11-15', '8', true, 2);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(3, 'Pikachu', '2021-01-07', '15.04', false, 1);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(4, 'Devimon', '2021-03-12', '11', true, 5);

-- Register new animals 
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(5,'Charmander', '2020-02-08', -11, false, 0);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(6,'Plantmon', '2022-11-15', -5.7, true, 2);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(7,'Squirtle', '1993-04-02', -12.13, false, 3);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(8,'Angemon', '2005-06-12', -45, false, 1);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(9,'Boarmon', '2005-06-07', 20.4, true, 7);

INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
(10,'Blossom', '1998-10-13', 17, true, 3);

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK;   

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' where RIGHT(name, 3) = 'mon';
UPDATE animals SET species = 'pokemon' where species IS NULL;
END TRANSACTION;

BEGIN TRANSACTION; 
DELETE  FROM animals;
ROLLBACK;

BEGIN TRANSACTION; 
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT  animalsBackup;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT animalsBackup;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
END TRANSACTION;


INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('digimon');
INSERT INTO species (name) VALUES ('pokemon');

--Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'digimon') where RIGHT(name, 3) = 'mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'pokemon') where species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') where name = 'Agumon';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob' ) WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';