DROP TABLE IF EXISTS spaces; 

CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price_per_night money,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE spaces RESTART IDENTITY;

INSERT INTO spaces (name, description, price_per_night, user_id) VALUES ('Luxurious Apartment with a Sea View', 'Newly-decorated modern apartment overlooking the sea. Two-minute walk to the beach!', '120.00', '1');
INSERT INTO spaces (name, description, price_per_night, user_id) VALUES ('Cosy lake cabin', 'A beautiful cabin near the Lake District, completely remote and off the beaten track. Enjoy some great walks nearby!', '100', '2');