-- Database: animalshelter

-- DROP DATABASE IF EXISTS animalshelter;

CREATE DATABASE animalshelter
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

\connect animalshelter;

CREATE SCHEMA IF NOT EXISTS public;

-- Table: public.animaltype

-- DROP TABLE IF EXISTS public.animaltype;
CREATE TABLE IF NOT EXISTS animalshelter.public.animaltype
(
    id integer NOT NULL,
    animal text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT animaltype_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS animalshelter.public.animaltype
    OWNER to postgres;

-- Table: public.animals

-- DROP TABLE IF EXISTS public.animals;

CREATE TABLE IF NOT EXISTS animalshelter.public.animals
(
    id uuid NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    animaltype integer NOT NULL,
    birthyear integer,
    other json,
    CONSTRAINT animals_pkey PRIMARY KEY (id),
    CONSTRAINT animaltype FOREIGN KEY (animaltype)
        REFERENCES public.animaltype (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS animalshelter.public.animals
    OWNER to postgres;

CREATE ROLE go_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:4rJaKPydv7jabH3fa6hQ/Q==$yPQFqnfk9Vw/mJ9n6NHnN5oMxW7OMkQDLrX8zm8pu0k=:Eduh7Hi8CP/O6o2p9L1UioGX5lKsAtsq0hmWBg3jAVA=';

GRANT pg_read_all_data TO go_user;

-- Insert some test data
INSERT INTO animalshelter.public.animaltype VALUES (0, 'cat');
INSERT INTO animalshelter.public.animals VALUES 
(
    gen_random_uuid(), 
    'Vincent',
    0, 
    2012, 
    '{"personality": "Loves everyone, basically a dog", "catType": "ginger"}'
);