CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name CHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    payment_id INTEGER REFERENCES payments(payment_id),
    total_cost DECIMAL(10, 2),
    delivery_location VARCHAR(200),
    status CHAR(50),
    restaurant_branch INTEGER REFERENCES branches(branch_id),
    order_date DATE
);

CREATE TABLE ordered_items (
    ordered_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    customer_id INTEGER REFERENCES customers(customer_id),
    item_id INTEGER REFERENCES menu(item_id),
    quantity INTEGER,
    customizations VARCHAR(50)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    payment_method CHAR(50),
    payment_credentials VARCHAR(100)
);

CREATE TABLE menu (
    item_id SERIAL PRIMARY KEY,
    item_cost INTEGER
);

CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_location VARCHAR(200)
);

UPDATE orders o
SET total_cost = (
    SELECT SUM(oi.quantity * m.item_cost)
    FROM ordered_items oi
    JOIN menu m on oi.item_id = m.item_id
    WHERE oi.order_id = o.order_id
    )