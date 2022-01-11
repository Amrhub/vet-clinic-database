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