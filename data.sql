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

-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon
INSERT INTO specializations (vets_id, species_id) VALUES (
    (SELECT id from vets WHERE name = 'William Tatcher'),
    (SELECT id from species WHERE name = 'pokemon')
);
INSERT INTO specializations (vets_id, species_id) VALUES (
    (SELECT id from vets WHERE name = 'Stephanie Mendez'),
    (SELECT id from species WHERE name = 'digimon')
);
INSERT INTO specializations (vets_id, species_id) VALUES (
    (SELECT id from vets WHERE name = 'Stephanie Mendez'),
    (SELECT id from species WHERE name = 'pokemon')
);
INSERT INTO specializations (vets_id, species_id) VALUES (
    (SELECT id from vets WHERE name = 'Jack Harkness'),
    (SELECT id from species WHERE name = 'digimon')
);

-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'William Tatcher'),
    (SELECT id from animals WHERE name = 'Agumon'),
    '2020-05-24'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Stephanie Mendez'),
    (SELECT id from animals WHERE name = 'Agumon'),
    '2020-07-22'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Jack Harkness'),
    (SELECT id from animals WHERE name = 'Gabumon'),
    '2021-02-02'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Pikachu'),
    '2020-01-05'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Pikachu'),
    '2020-03-08'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Pikachu'),
    '2020-05-14'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Stephanie Mendez'),
    (SELECT id from animals WHERE name = 'Devimon'),
    '2021-05-04'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Jack Harkness'),
    (SELECT id from animals WHERE name = 'Charmander'),
    '2021-02-24'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Plantmon'),
    '2019-12-21'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'William Tatcher'),
    (SELECT id from animals WHERE name = 'Plantmon'),
    '2020-08-10'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Plantmon'),
    '2021-04-07'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Stephanie Mendez'),
    (SELECT id from animals WHERE name = 'Squirtle'),
    '2019-09-29'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Jack Harkness'),
    (SELECT id from animals WHERE name = 'Angemon'),
    '2020-10-03'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Jack Harkness'),
    (SELECT id from animals WHERE name = 'Angemon'),
    '2020-11-04'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Boarmon'),
    '2019-01-24'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Boarmon'),
    '2019-05-15'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Boarmon'),
    '2020-02-27'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'Maisy Smith'),
    (SELECT id from animals WHERE name = 'Boarmon'),
    '2020-08-03'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'William Tatcher'),
    (SELECT id from animals WHERE name = 'Blossom'),
    '2020-05-24'
);
INSERT INTO visits (vets_id, animals_id, date_of_visit) VALUES (
    (SELECT id from vets WHERE name = 'William Tatcher'),
    (SELECT id from animals WHERE name = 'Blossom'),
    '2020-01-11'
);

