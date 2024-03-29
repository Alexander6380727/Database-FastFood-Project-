CREATE TABLE people(
    person_id SERIAL PRIMARY KEY,
    name CHAR(100),
    email VARCHAR(100) UNIQUE ,
    phone_number VARCHAR(20) UNIQUE
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES people(person_id),
    payment_id INTEGER REFERENCES payments(payment_id)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    payment_method CHAR(50),
    payment_credentials VARCHAR(100)
);

CREATE TABLE menu (
    item_id SERIAL PRIMARY KEY,
    item_cost INTEGER,
    item_description CHAR(100) UNIQUE
);

CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_location VARCHAR(200) UNIQUE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    payment_id INTEGER REFERENCES payments(payment_id),
    total_cost DECIMAL(10, 2),
    delivery_location VARCHAR(200),
    status CHAR(50),
    branch_id INTEGER REFERENCES branches(branch_id),
    order_date DATE
);

CREATE TABLE ordered_items (
    ordered_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    customer_id INTEGER REFERENCES customers(customer_id),
    employee_id INTEGER REFERENCES employees(employee_id),
    item_id INTEGER REFERENCES menu(item_id),
    quantity INTEGER,
    customizations VARCHAR(50)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    person_id INTEGER REFERENCES people(person_id),
    branch_id INTEGER REFERENCES branches(branch_id)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    branch_id INTEGER REFERENCES branches(branch_id),
    order_id INTEGER REFERENCES orders(order_id),
    review TEXT,
    Rating INTEGER CHECK (Rating >= 1 AND Rating <= 5)
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

INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (1, 'QR Payment', 'gsfdbvcFGVC');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (2, 'Credit Card', 'asfddgs@ES');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (3,'Debit Card', 'DGFVS$#%');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (4, 'PayPal', '@#$%@E2345');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (5, 'Credit Card', 'sfge=45-6');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (6, 'QR Payment', '346thdfgh');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (7, 'PayPal', '@#%$$Wdf');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (8, 'Credit Card', 'hdgfs#$@!');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (9, 'Debit Card', 'sdfesf!@#@!');
INSERT INTO payments(customer_id, payment_method, payment_credentials) VALUES (10, 'Credit Card', '124!asdg');

INSERT INTO branches(branch_location) VALUES ('Tungsin');
INSERT INTO branches(branch_location) VALUES ('Salaya');
INSERT INTO branches(branch_location) VALUES ('Khao San');
INSERT INTO branches(branch_location) VALUES ('Phuket');

INSERT INTO customers(person_id, payment_id) VALUES (1,1 );
INSERT INTO customers(person_id, payment_id) VALUES (2,2 );
INSERT INTO customers(person_id, payment_id) VALUES (3,3 );
INSERT INTO customers(person_id, payment_id) VALUES (4,4 );
INSERT INTO customers(person_id, payment_id) VALUES (5,5 );
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

INSERT INTO orders(customer_id, payment_id, delivery_location, status, branch_id, order_date)
VALUES (1, 1, '123 Roadhouse', 'In the Kitchen', 1, '2024-03-27');
INSERT INTO orders(customer_id, payment_id, delivery_location, status, branch_id, order_date)
VALUES (2, 2, 'Ram Ranch', 'Delivering', 2, '2024-03-27');
INSERT INTO orders(customer_id, payment_id, delivery_location, status, branch_id, order_date)
VALUES (3, 3, 'Electric Avenue', 'Delivered', 3, '2024-03-26');

INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (1, 1, 1, 1, 2, 'None');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (1, 1, 3, 3, 1, '2 Patties');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (2, 2, 4, 1, 1, 'Large');
INSERT INTO ordered_items(order_id, customer_id, employee_id, item_id, quantity, customizations) VALUES (3, 3, 5, 3, 1, 'None');

INSERT INTO reviews(customer_id, branch_id, order_id, review, rating)
VALUES (3, 3, 3, 'Burg', 5);

