DROP TABLE IF EXISTS users, spaces; 

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text,
  password text,
  first_name text,
  last_name text
  );

CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price_per_night decimal(5,2),
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE users, spaces RESTART IDENTITY;

INSERT INTO users (email, password, first_name, last_name) VALUES ('bob@gmail.com','12345','Bob','Billy');
INSERT INTO users (email, password, first_name, last_name) VALUES ('Jill@gmail.com','password','Jane','Smith');

INSERT INTO spaces (name, description, price_per_night, user_id) VALUES ('Luxurious Apartment with a Sea View', 'Newly-decorated modern apartment overlooking the sea. Two-minute walk to the beach!', '120.00', '1');
INSERT INTO spaces (name, description, price_per_night, user_id) VALUES ('Cosy lake cabin', 'A beautiful cabin near the Lake District, completely remote and off the beaten track. Enjoy some great walks nearby!', '100', '2');