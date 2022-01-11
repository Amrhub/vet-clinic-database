/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE RIGHT(name, 3) = 'mon';

-- List the name of all animals born between 2016 and 2019.
SELECT (name) FROM animals WHERE date_of_birth BETWEEN '2016-12-30' AND '2019-1-1';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT (name) FROM animals WHERE neutered AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT (date_of_birth) FROM animals WHERE name='Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name!='Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- How many animals are there?
SELECT COUNT(*) as number_of_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) as never_tried_to_escape FROM animals where escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) average_weight_kg FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) as escape_attempts FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, min(weight_kg) as min_weight_kg, MAX(weight_kg) as max_weight_kg FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts) as average_escape_attempts_1990_2000 FROM animals where date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';