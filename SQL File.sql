CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name CHAR(50),
    last_name CHAR(50),
    gender CHAR(20),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    delivery_location VARCHAR(200),
    payment_method ,
    restaurant_branch
);

CREATE TABLE menu (

);

CREATE TABLE branches (

);