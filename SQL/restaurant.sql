-- Restaurant Owners
-- 5 Tables
-- 1x Fact, 4x Dimension
-- add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/ with


CREATE TABLE customers (
  id INT PRIMARY KEY,
  name TEXT,
  gender TEXT
);

INSERT INTO customers VALUES
  (1, 'Anna'  , 'F'),
  (2, 'Light' , 'M'),
  (3, 'Killua', 'M'),
  (4, 'Miku'  , 'F'),
  (5, 'Ray'   , 'M'),
  (6, 'Emma'  , 'F');
  
CREATE TABLE staffs (
  id INT PRIMARY KEY,
  name TEXT
);

INSERT INTO staffs VALUES
  (1, 'Loid'),
  (2, 'Peach'),
  (3, 'Sam');
  
CREATE TABLE orders (
  id INT PRIMARY KEY,
  order_date DATE,
  customer_id INT,
  staff_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  FOREIGN KEY (staff_id) REFERENCES staffs(id)
);

INSERT INTO orders VALUES
  (1, '2022-08-01', 1, 1),
  (2, '2022-08-01', 2, 1),
  (3, '2022-08-02', 3, 2),
  (4, '2022-08-02', 4, 1),
  (5, '2022-08-02', 2, 2),
  (6, '2022-08-03', 5, 3),
  (7, '2022-08-03', 1, 3),
  (8, '2022-08-04', 6, 2),
  (9, '2022-08-04', 3, 2),
  (10, '2022-08-04', 5, 3);
  
CREATE TABLE menus (
  id INT PRIMARY KEY,
  product TEXT,
  price REAL
);

INSERT INTO menus VALUES
  (1, 'coffee'  , 120),
  (2, 'cocoa'   , 150),
  (3, 'milk tea', 135),
  (4, 'cookie'  , 80),
  (5, 'brownie' , 95);
  
CREATE TABLE transactions (
  id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity REAL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO transactions VALUES
  (1, 1, 1, 1),
  (2, 2, 1, 1),
  (3, 2, 2, 1),
  (4, 3, 2, 1),
  (5, 3, 3, 1),
  (6, 4, 1, 1),
  (7, 4, 4, 1),
  (8, 5, 2, 2),
  (9, 6, 2, 1),
  (10, 6, 5, 1),
  (11, 7, 1, 1),
  (12, 7, 3, 1),
  (13, 7, 4, 2),
  (14, 8, 3, 2),
  (15, 9, 5, 2),
  (16, 10, 1, 1);

-- total revenue sort by order id
SELECT
  orders.id,
  SUM(menus.price * transactions.quantity) AS total
FROM orders
JOIN transactions ON orders.id = transactions.order_id
JOIN menus ON transactions.product_id = menus.id
GROUP BY orders.id;

-- total revenue sort by order date
SELECT
  orders.order_date,
  SUM(menus.price * transactions.quantity) AS total
FROM orders
JOIN transactions ON orders.id = transactions.order_id
JOIN menus ON transactions.product_id = menus.id
GROUP BY orders.order_date;

-- analyze what product customer purchased
SELECT
  customers.name,
  menus.product
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN transactions ON orders.id = transactions.order_id
JOIN menus ON transactions.product_id = menus.id
ORDER BY customers.name;

-- total revenue sort by customer gender
SELECT 
  customers.gender,
  SUM(menus.price * transactions.quantity) AS total
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN transactions ON orders.id = transactions.order_id
JOIN menus ON transactions.product_id = menus.id
GROUP BY 1;

-- analyze total revenue by order id
WITH sales AS (
  SELECT
    o.id,
    SUM(m.price * t.quantity) AS total
  FROM orders AS o
  JOIN transactions AS t ON o.id = t.order_id
  JOIN menus AS m ON t.product_id = m.id
  GROUP BY o.id
)

SELECT
  MIN(total),
  MAX(total),
  AVG(total),
  SUM(total)
FROM sales;

-- analyze total revenue by order date
WITH sales AS (
  SELECT
    o.order_date,
    SUM(m.price * t.quantity) AS total
  FROM orders AS o
  JOIN transactions AS t ON o.id = t.order_id
  JOIN menus AS m ON t.product_id = m.id
  GROUP BY o.order_date
)

SELECT
  MIN(total),
  MAX(total),
  AVG(total),
  SUM(total)
FROM sales;

-- overall transaction 
SELECT
  orders.order_date,
  customers.name,
  menus.product,
  transactions.quantity,
  staffs.name
FROM transactions
JOIN menus ON transactions.product_id = menus.id
JOIN orders ON transactions.order_id = orders.id
JOIN customers ON orders.customer_id = customers.id
JOIN staffs ON orders.staff_id = staffs.id;
