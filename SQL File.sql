CREATE TABLE people(
    person_id SERIAL PRIMARY KEY,
    name CHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    payment_method CHAR(50) NOT NULL,
    payment_credentials VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL REFERENCES people(person_id),
    payment_id INTEGER NOT NULL REFERENCES payments(payment_id)
);

CREATE TABLE menu (
    item_id SERIAL PRIMARY KEY,
    item_cost INTEGER NOT NULL,
    item_description CHAR(100) UNIQUE NOT NULL
);

CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_location VARCHAR(200) UNIQUE NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL REFERENCES people(person_id),
    branch_id INTEGER NOT NULL REFERENCES branches(branch_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    total_cost DECIMAL(10, 2),
    delivery_location VARCHAR(200) NOT NULL,
    status CHAR(50) NOT NULL,
    branch_id INTEGER NOT NULL REFERENCES branches(branch_id),
    order_date DATE NOT NULL
);

CREATE TABLE ordered_items (
    ordered_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id),
    item_id INTEGER NOT NULL REFERENCES menu(item_id),
    quantity INTEGER NOT NULL,
    customizations VARCHAR(50)
);


CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    branch_id INTEGER NOT NULL REFERENCES branches(branch_id),
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    review TEXT NOT NULL,
    Rating INTEGER CHECK (Rating >= 1 AND Rating <= 5) NOT NULL
);

UPDATE orders o
SET total_cost = (
    SELECT SUM(oi.quantity * m.item_cost)
    FROM ordered_items oi
    JOIN menu m on oi.item_id = m.item_id
    WHERE oi.order_id = o.order_id
    );


INSERT INTO people(name, email, phone_number) VALUES ('John Wick', '1@gmail.com', '0000000000');
INSERT INTO people(name, email, phone_number) VALUES ('Paul Atreides', '2@gmail.com', '0000000001');
INSERT INTO people(name, email, phone_number) VALUES ('Will Smith', '3@gmail.com', '0000000002');
INSERT INTO people(name, email, phone_number) VALUES ('John Cena', '4@gmail.com', '0000000003');
INSERT INTO people(name, email, phone_number) VALUES ('Michael Jackson', '5@gmail.com', '0000000004');
INSERT INTO people(name, email, phone_number) VALUES ('Hulk Hogan', '6@gmail.com', '0000000005');
INSERT INTO people(name, email, phone_number) VALUES ('Thomas Wayne', '7@gmail.com', '0000000006');
INSERT INTO people(name, email, phone_number) VALUES ('Toby Maguire', '8@gmail.com', '0000000012');
INSERT INTO people(name, email, phone_number) VALUES ('Jackie Chan', '9@gmail.com', '0000000013');
INSERT INTO people(name, email, phone_number) VALUES ('Robute Gulliman', '10@gmail.com', '0000000014');
INSERT INTO people(name, email, phone_number) VALUES ('Bruce Wayne', '1@quickbites.com', '0000000007');
INSERT INTO people(name, email, phone_number) VALUES ('Barry Allen', '2@quickbites.com', '0000000008');
INSERT INTO people(name, email, phone_number) VALUES ('John Doe', '3@quickbites.com', '0000000009');
INSERT INTO people(name, email, phone_number) VALUES ('John Jones', '4@quickbites.com', '0000000010');
INSERT INTO people(name, email, phone_number) VALUES ('Clark Kent', '5@quickbites.com', '0000000011');

INSERT INTO payments(payment_method, payment_credentials) VALUES ('QR Payment', 'gsfdbvcFGVC');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('Credit Card', 'asfddgs@ES');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('Debit Card', 'DGFVS$#%');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('PayPal', '@#$%@E2345');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('Credit Card', 'sfge=45-6');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('QR Payment', '346thdfgh');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('PayPal', '@#%$$Wdf');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('Credit Card', 'hdgfs#$@!');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('Debit Card', 'sdfesf!@#@!');
INSERT INTO payments(payment_method, payment_credentials) VALUES ('Credit Card', '124!asdg');

%%sql
INSERT INTO branches(branch_location) VALUES ('Tungsin');
INSERT INTO branches(branch_location) VALUES ('Salaya');
INSERT INTO branches(branch_location) VALUES ('Khao San');
INSERT INTO branches(branch_location) VALUES ('Phuket');



INSERT INTO customers(person_id, payment_id) VALUES (1,1 );
INSERT INTO customers(person_id, payment_id) VALUES (2,2 );
INSERT INTO customers(person_id, payment_id) VALUES (3,3 );
INSERT INTO customers(person_id, payment_id) VALUES (4,4 );
INSERT INTO customers(person_id, payment_id) VALUES (5,5 );
INSERT INTO customers(person_id, payment_id) VALUES (6,6 );
INSERT INTO customers(person_id, payment_id) VALUES (7,7 );
INSERT INTO customers(person_id, payment_id) VALUES (8,8 );
INSERT INTO customers(person_id, payment_id) VALUES (9,9 );
INSERT INTO customers(person_id, payment_id) VALUES (10,10 );
INSERT INTO employees(person_id, branch_id) VALUES (11, 1);
INSERT INTO employees(person_id, branch_id) VALUES (12, 1);
INSERT INTO employees(person_id, branch_id) VALUES (13, 2);
INSERT INTO employees(person_id, branch_id) VALUES (14, 3);
INSERT INTO employees(person_id, branch_id) VALUES (15, 4);

INSERT INTO menu(item_cost, item_description) VALUES (120, 'Garlic Chicken');
INSERT INTO menu(item_cost, item_description) VALUES (220, 'Margarita Pizza');
INSERT INTO menu(item_cost, item_description) VALUES (160, 'Chicken Burger');
INSERT INTO menu(item_cost, item_description) VALUES (200, 'Beef Burger');
INSERT INTO menu(item_cost, item_description) VALUES (180, 'Pork Burger');
INSERT INTO menu(item_cost, item_description) VALUES (100, 'French Fries');

INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (1, '123 Roadhouse', 'Delivered', 1, '2024-03-20');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (2, 'Ram Ranch', 'Delivered', 2, '2024-03-21');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (3, 'Electric Avenue', 'Delivered', 3, '2024-03-22');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (4, 'Spongebobs House', 'Delivered', 1, '2024-03-23');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (5, 'Hell', 'Delivered', 2, '2024-03-24');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (6, 'Antarctica', 'Delivering', 3, '2024-03-25');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (7, 'Electric Boogaloo', 'Delivering', 3, '2024-03-25');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (8, 'Home', 'In the Kitchen', 1, '2024-03-25');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (9, 'Space', 'In the Kitchen', 2, '2024-03-25');
INSERT INTO orders(customer_id, delivery_location, status, branch_id, order_date)
VALUES (10, 'Ocean', 'In the Kitchen', 3, '2024-03-25');

%%sql
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (1, 1, 1, 1, 2, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (1, 1, 1, 2, 3, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (2, 2, 3, 3, 1, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (3, 3, 4, 4, 2, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (3, 3, 4, 5, 4, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (4, 4, 1, 6, 1, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (5, 5, 3, 1, 2, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (6, 6, 4, 2, 2, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (7, 7, 4, 3, 1, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (8, 8, 1, 4, 4, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (9, 9, 3, 5, 2, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (10, 10, 4, 6, 1, 'None');

INSERT INTO reviews(customer_id, branch_id, order_id, review, rating)
VALUES (1, 1, 1, 'Nice', 5);
INSERT INTO reviews(customer_id, branch_id, order_id, review, rating)
VALUES (2, 2, 2, 'Alright', 4);
INSERT INTO reviews(customer_id, branch_id, order_id, review, rating)
VALUES (3, 3, 3, 'Mid', 3);
INSERT INTO reviews(customer_id, branch_id, order_id, review, rating)
VALUES (4, 1, 4, 'Meh', 2);
INSERT INTO reviews(customer_id, branch_id, order_id, review, rating)
VALUES (5, 2, 5, 'Terrible', 1);

SELECT * FROM reviews r WHERE r.rating >= 3;

CREATE VIEW high_rated_reviews AS
SELECT *
FROM reviews
WHERE rating >= 4;

SELECT * FROM high_rated_reviews;

CREATE OR REPLACE FUNCTION update_order_status(p_order_id INT, new_status TEXT)
RETURNS VOID AS $$
BEGIN
    UPDATE orders
    SET status = new_status
    WHERE order_id = p_order_id;
END;
$$ LANGUAGE plpgsql;

SELECT update_order_status(8, 'Delivered');

SELECT * FROM menu;
SELECT *
FROM menu
WHERE item_description LIKE '%Burger%';

SELECT *
FROM people
WHERE person_id IN (SELECT person_id FROM customers);

