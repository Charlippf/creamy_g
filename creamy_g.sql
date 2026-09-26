--question 1
SELECT customers.name, orders.order_id, orders.order_date
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id;

--question 2
SELECT customers.name, customers.email, orders.order_id, orders.order_date 
FROM customers 
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id;

--question 3
SELECT orders.order_id, orders.order_date, orders.total_amount, customers.name 
FROM orders 
LEFT JOIN customers 
ON orders.customer_id = customers.customer_id;

--question 4
SELECT customers.name, orders.order_id, orders.order_date, orders.total_amount 
FROM customers 
FULL OUTER JOIN orders 
ON customers.customer_id = orders.customer_id;

--question 5
SELECT customers.name, customers.email, customers.city 
FROM customers 
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id 
WHERE orders.order_id IS NULL;

--question 6
SELECT products.product_name, products.category, products.price 
FROM products 
LEFT JOIN order_items 
ON products.product_id = order_items.product_id WHERE order_items.order_item_id IS NULL;

--question 7
SELECT orders.order_id, orders.customer_id, orders.order_date, orders.total_amount FROM orders 
LEFT JOIN customers 
ON orders.customer_id = customers.customer_id 
WHERE customers.customer_id IS NULL;

--question 8
SELECT customers.name, orders.order_date, products.product_name 
FROM customers 
INNER JOIN orders ON customers.customer_id = orders.customer_id 
INNER JOIN order_items ON orders.order_id = order_items.order_id 
INNER JOIN products ON order_items.product_id = products.product_id;

--question 9
SELECT customers.name, orders.order_date, products.product_name, order_items.quantity 
FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id 
LEFT JOIN order_items ON orders.order_id = order_items.order_id 
LEFT JOIN products ON order_items.product_id = products.product_id 
WHERE products.product_id IS NOT NULL;

--question 10
SELECT customers.name, orders.order_date, products.product_name, products.category, order_items.quantity, order_items.unit_price 
FROM order_items 
LEFT JOIN orders ON order_items.order_id = orders.order_id 
LEFT JOIN customers ON orders.customer_id = customers.customer_id 

--question 11
SELECT customers.name, COUNT(orders.order_id) AS total_orders, SUM(orders.total_amount) AS total_spent 
FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id 
GROUP BY customers.name;

--question 12
SELECT products.product_name, products.category, SUM(order_items.quantity) AS total_quantity, SUM(order_items.quantity * order_items.unit_price) AS total_revenue FROM products 
LEFT JOIN order_items ON products.product_id = order_items.product_id 
GROUP BY products.product_name, products.category;
LEFT JOIN products ON order_items.product_id = products.product_id;

--question 13
SELECT products.category, COUNT(products.product_id) AS total_products, COUNT(order_items.product_id) AS products_sold 
FROM products 
LEFT JOIN order_items ON products.product_id = order_items.product_id 
GROUP BY products.category;

--question 14
SELECT 'Orders without customers' AS problem, COUNT(*) FROM orders 
LEFT JOIN customers ON orders.customer_id = customers.customer_id 
WHERE customers.customer_id IS NULL 
UNION ALL 
SELECT 'Items without orders', COUNT(*) FROM order_items 
LEFT JOIN orders ON order_items.order_id = orders.order_id 
WHERE orders.order_id IS NULL 
UNION ALL 
SELECT 'Items without products', COUNT(*) FROM order_items 
LEFT JOIN products ON order_items.product_id = products.product_id 
WHERE products.product_id IS NULL;

--question 15
SELECT 'Customer with no orders' AS problem, customers.name 
FROM customers 
LEFT JOIN orders ON customers.customer_id = orders.customer_id 
WHERE orders.order_id IS NULL 
UNION ALL 
SELECT 'Order without customer', orders.order_id::text 
FROM orders 
LEFT JOIN customers ON orders.customer_id = customers.customer_id 
WHERE customers.customer_id IS NULL 
UNION ALL 
SELECT 'Product with no sales', products.product_name 
FROM products LEFT JOIN order_items ON products.product_id = order_items.product_id 
WHERE order_items.order_item_id IS NULL;

--question 16
SELECT customers.name, 
COUNT(DISTINCT products.category) AS category_count, STRING_AGG(DISTINCT products.category, ', ') 
AS categories 
FROM customers JOIN orders ON customers.customer_id = orders.customer_id 
JOIN order_items ON orders.order_id = order_items.order_id 
JOIN products ON order_items.product_id = products.product_id

--question 17
SELECT orders.order_id, orders.total_amount, SUM(order_items.quantity * order_items.unit_price) 
AS calculated_total, orders.total_amount - SUM(order_items.quantity * order_items.unit_price) AS difference 
FROM orders JOIN customers ON orders.customer_id = customers.customer_id 
JOIN order_items ON orders.order_id = order_items.order_id 
GROUP BY orders.order_id, orders.total_amount;
GROUP BY customers.name;

--question 18
SELECT customers.name, STRING_AGG(DISTINCT products.category, ', ') AS categories 
FROM customers JOIN orders ON customers.customer_id = orders.customer_id 
JOIN order_items ON orders.order_id = order_items.order_id 
JOIN products ON order_items.product_id = products.product_id 
GROUP BY customers.name 
HAVING COUNT(DISTINCT products.category) > 1 AND COUNT(CASE WHEN products.category = 'Electronics' THEN 1 END) > 0;