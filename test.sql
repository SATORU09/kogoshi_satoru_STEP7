SELECT * FROM users;

SELECT * FROM users
WHERE YEAR(created_at) = 2024;

SELECT * FROM users
WHERE age < 30 AND gender = 'female';

SELECT product_name, price FROM products;

SELECT u.name AS ユーザー名, o.order_date AS 注文日
FROM orders o
JOIN users u ON o.user_id = u.id;

SELECT 
    p.product_name AS 商品名,
    oi.quantity AS 数量,
    p.price AS 単価,
    (oi.quantity * p.price) AS 金額
FROM order_items oi
JOIN products p ON oi.product_id = p.id;

SELECT 
    u.name AS ユーザー名,
    COUNT(o.id) AS 注文件数
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

SELECT 
    u.name AS ユーザー名,
    SUM(oi.quantity * p.price) AS 総購入金額
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY u.id, u.name;

SELECT 
    u.name AS ユーザー名,
    SUM(oi.quantity * p.price) AS 合計金額
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY u.id, u.name
ORDER BY 合計金額 DESC
LIMIT 1;

SELECT 
    p.product_name AS 商品名,
    SUM(oi.quantity) AS 注文数
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.product_name;

SELECT *
FROM users u
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.user_id = u.id
);

SELECT order_id
FROM order_items
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) >= 2;

SELECT DISTINCT u.name
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.product_name = 'テレビ';

SELECT
    o.order_date,
    u.name AS user_name,
    p.product_name,
    oi.quantity,
    p.price * oi.quantity AS total_price
FROM order_items oi
JOIN orders o ON oi.order_id = o.id
JOIN users u ON o.user_id = u.id
JOIN products p ON oi.product_id = p.id;

SELECT p.product_name
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id
ORDER BY SUM(oi.quantity) DESC
LIMIT 1;

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS order_count
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

SELECT *
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.id
);

CREATE INDEX idx_product_id ON order_items(product_id);

SELECT
    u.name,
    AVG(sub.total_price) AS avg_order_amount
FROM users u
JOIN (
    SELECT
        o.user_id,
        o.id AS order_id,
        SUM(oi.quantity * p.price) AS total_price
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id
    GROUP BY o.id
) sub ON u.id = sub.user_id
GROUP BY u.id, u.name;

SELECT
    u.name,
    MAX(o.order_date) AS latest_order_date
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

INSERT INTO users (id, name, age, gender, created_at)
VALUES (6, '中村愛', 25, 'female', '2025-06-01');

INSERT INTO products (id, product_name, price)
VALUES (6, 'エアコン', 60000);

INSERT INTO orders (id, user_id, order_date)
VALUES (10, 1, '2025-06-10');

INSERT INTO order_items (id, order_id, product_id, quantity)
VALUES (10, 10, 6, 1);

UPDATE users
SET age = 24
WHERE name = '田中美咲';

UPDATE products
SET price = price * 1.10;

UPDATE orders
SET order_date = '2024-05-01'
WHERE order_date < '2024-05-01';

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM users WHERE name = '高橋健一';

SET FOREIGN_KEY_CHECKS = 1;

DELETE FROM order_items
WHERE order_id = 5;

DELETE FROM products
WHERE id NOT IN (
    SELECT DISTINCT product_id FROM order_items
);


