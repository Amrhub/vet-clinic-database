/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT, 
    neutered BOOLEAN,
    weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species text;