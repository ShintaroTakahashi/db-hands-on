CREATE DATABASE library_db;

\c library_db;

CREATE SCHEMA IF NOT EXISTS library_records;
SET search_path = library_records;

CREATE ROLE library_records_user WITH LOGIN PASSWORD 'library_records_user';

GRANT ALL PRIVILEGES ON SCHEMA library_records TO library_records_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA library_records GRANT ALL PRIVILEGES ON TABLES TO library_records_user;

CREATE TABLE IF NOT EXISTS library_records.author (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS library_records.publisher (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS library_records.book (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  publisher_id UUID NOT NULL REFERENCES publisher(id),
  published_date DATE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS library_records.book_author (
  book_id UUID NOT NULL REFERENCES book(id),
  author_id UUID NOT NULL REFERENCES author(id),
  PRIMARY KEY (book_id, author_id)
);

INSERT INTO library_records.author (name) VALUES ('しんたろー');
INSERT INTO library_records.publisher (name) VALUES ('ビットエー出版');
INSERT INTO library_records.book (title, publisher_id, published_date) VALUES ('PostgreSQLの本', (SELECT id FROM library_records.publisher WHERE name = 'ビットエー出版'), '2021-01-01');
INSERT INTO library_records.book_author (book_id, author_id) VALUES ((SELECT id FROM library_records.book WHERE title = 'PostgreSQLの本'), (SELECT id FROM library_records.author WHERE name = 'しんたろー'));
