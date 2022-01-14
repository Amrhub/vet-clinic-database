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
SELECT AVG(escape_attempts) as average_escape_attempts_1990_2000 FROM animals 
where date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';

-- What animals belong to Melody Pond?
SELECT a.name FROM animals as a JOIN owners as o ON a.owners_id = o.id WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.* FROM animals as a JOIN species as s ON a.species_id = s.id WHERE s.name = 'pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, a.name FROM owners as o  LEFT JOIN animals as a ON a.owners_id = o.id;

-- How many animals are there per species?
SELECT count(s.name) as number_of_animals, s.name as species_name FROM animals as a 
JOIN  species as s ON a.species_id = s.id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name as animal_name, s.name as animal_species FROM animals as a 
JOIN owners as o ON a.owners_id = o.id 
JOIN species as s ON a.species_id = s.id 
WHERE s.name = 'digimon' AND o.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name FROM animals as a JOIN owners as o ON a.owners_id = o.id 
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, count(o.full_name) as number_of_animals FROM owners as o JOIN animals as a ON o.id = a.owners_id
GROUP BY o.full_name ORDER BY number_of_animals DESC FETCH FIRST ROW ONLY;

-- Who was the last animal seen by William Tatcher?
SELECT a.name last_animal_seen, v.name vets_name, vi.date_of_visit FROM visits vi 
JOIN animals a ON a.id = vi.animals_id
JOIN vets v ON v.id = vi.vets_id
WHERE v.name = 'William Tatcher' ORDER BY vi.date_of_visit DESC FETCH FIRST ROW ONLY;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.name) as number_of_animals FROM animals as a JOIN visits as v ON a.id = v.animals_id
JOIN vets as ve ON v.vets_id = ve.id WHERE ve.name = 'Maisy Smith';

-- List all vets and their specialties, including vets with no specialties.
SELECT ve.name, s.name FROM vets ve 
LEFT JOIN specializations sp ON sp.vets_id = ve.id 
LEFT JOIN species s ON s.id = sp.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name animal_name, v.date_of_visit FROM animals a
JOIN visits v ON v.animals_id = a.id
JOIN vets ve ON ve.id = v.vets_id
WHERE ve.name = 'Stephanie Mendez' AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name animal_name, count(a.name) number_of_visits FROM animals a
JOIN visits v ON v.animals_id = a.id
GROUP BY a.name
ORDER BY number_of_visits DESC
FETCH FIRST ROW ONLY;

-- Who was Maisy Smith's first visit?
SELECT ve.name vet_name, a.name first_visit, v.date_of_visit FROM animals a
JOIN visits v ON v.animals_id = a.id
JOIN vets ve ON ve.id = v.vets_id
WHERE ve.name = 'Maisy Smith'
ORDER BY v.date_of_visit
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name animal_name, a.date_of_birth animal_date_of_birth,
a.escape_attempts, a.neutered, a.weight_kg animal_weight_kg, 
ve.name vet_name, ve.age vet_age, ve.date_of_graduation vet_graduation_date,
v.date_of_visit FROM animals a
JOIN visits v ON v.animals_id = a.id
JOIN vets ve ON ve.id = v.vets_id
ORDER BY v.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT ve.name vet_name, count(v.animals_id) number_of_visits FROM vets ve 
LEFT JOIN visits v ON v.vets_id = ve.id
LEFT JOIN specializations s ON s.vets_id = ve.id
WHERE s.species_id IS NULL
GROUP BY ve.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT  count(s.name) number_of_visits, s.name species_type FROM visits v 
JOIN animals a ON a.id = v.animals_id
JOIN species s ON s.id = a.species_id
JOIN vets ve ON ve.id = v.vets_id
WHERE ve.name = 'Maisy Smith'
GROUP BY s.name;
