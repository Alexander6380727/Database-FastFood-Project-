CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name CHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    payment_id INTEGER REFERENCES payment(payment_id),
    delivery_location VARCHAR(200),
    status CHAR(50),
    restaurant_branch INTEGER REFERENCES branches(branch_id),
    order_date DATE
);

CREATE TABLE order_history (

);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    payment_method CHAR(50),
    payment_credentials VARCHAR(100)
);

CREATE TABLE menu (
    item_id SERIAL PRIMARY KEY,

);

CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,

);