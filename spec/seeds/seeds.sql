CREATE TABLE users (id SERIAL PRIMARY KEY, email text, password text, first_name text, last_name text );

INSERT INTO users (email, password, first_name, last_name) VALUES ('bob@gmail.com','12345','Bob','Billy');
INSERT INTO users (email, password, first_name, last_name) VALUES ('Jill@gmail.com','password','Jane','Smith');