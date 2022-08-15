DROP TABLE IF EXISTS users, bookings;

CREATE TABLE users (id SERIAL PRIMARY KEY, email text, password text, first_name text, last_name text );
CREATE TABLE bookings (id SERIAL PRIMARY KEY, date_booked DATE, confirmed BOOLEAN, space_id int);

TRUNCATE TABLE users, bookings RESTART IDENTITY;

INSERT INTO users (email, password, first_name, last_name) VALUES ('bob@gmail.com','12345','Bob','Billy');
INSERT INTO users (email, password, first_name, last_name) VALUES ('Jill@gmail.com','password','Jane','Smith');

INSERT INTO bookings (date_booked, confirmed, space_id) VALUES('2022-08-15', 'f', 1);
INSERT INTO bookings (date_booked, confirmed, space_id) VALUES('2022-08-16', 't', 2);

