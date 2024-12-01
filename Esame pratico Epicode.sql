-- Selezione del database
USE ToysGroupDB;

-- Creazione della tabella Product
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL
);

-- Creazione della tabella Region
CREATE TABLE Region (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Creazione della tabella Sales
CREATE TABLE Sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    product_id INT NOT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (region_id) REFERENCES Region(region_id) ON DELETE CASCADE
);
-- Inserimento di prodotti
INSERT INTO Product (name, category) VALUES 
('Macchinina', 'Veicoli'),
('Peluche', 'Giochi morbidi'),
('Puzzle', 'Educativi'),
('Bambola', 'Giochi morbidi');

-- Inserimento di regioni
INSERT INTO Region (name) VALUES 
('Europa'),
('Asia'),
('America');

-- Inserimento di transazioni di vendita
INSERT INTO Sales (date, quantity, amount, product_id, region_id) VALUES
('2024-01-15', 10, 500.00, 1, 1),
('2024-03-10', 5, 250.00, 2, 2),
('2024-04-20', 7, 350.00, 3, 3),
('2024-06-25', 3, 150.00, 2, 1),
('2024-07-30', 1, 50.00, 1, 3);
-- Verifica univocità di product_id
SELECT product_id, COUNT(*) 
FROM Product 
GROUP BY product_id 
HAVING COUNT(*) > 1;

-- Verifica univocità di region_id
SELECT region_id, COUNT(*) 
FROM Region 
GROUP BY region_id 
HAVING COUNT(*) > 1;

-- Verifica univocità di sales_id
SELECT sales_id, COUNT(*) 
FROM Sales 
GROUP BY sales_id 
HAVING COUNT(*) > 1;
SELECT 
    p.name AS product_name,
    YEAR(s.date) AS sales_year,
    SUM(s.amount) AS total_revenue
FROM 
    Sales s
JOIN 
    Product p ON s.product_id = p.product_id
GROUP BY 
    p.name, YEAR(s.date);
SELECT 
    r.name AS region_name,
    YEAR(s.date) AS sales_year,
    SUM(s.amount) AS total_revenue
FROM 
    Sales s
JOIN 
    Region r ON s.region_id = r.region_id
GROUP BY 
    r.name, YEAR(s.date)
ORDER BY 
    sales_year ASC, total_revenue DESC;
SELECT 
    p.category, 
    SUM(s.quantity) AS total_quantity
FROM 
    Sales s
JOIN 
    Product p ON s.product_id = p.product_id
GROUP BY 
    p.category
ORDER BY 
    total_quantity DESC
LIMIT 1;
SELECT 
    p.name AS product_name
FROM 
    Product p
LEFT JOIN 
    Sales s ON p.product_id = s.product_id
WHERE 
    s.sales_id IS NULL;
SELECT 
    p.name AS product_name,
    MAX(s.date) AS last_sale_date
FROM 
    Sales s
JOIN 
    Product p ON s.product_id = p.product_id
GROUP BY 
p.name;
SELECT name, category 
FROM Product;
SELECT 
    p.name AS product_name,
    YEAR(s.date) AS sales_year,
    SUM(s.amount) AS total_revenue
FROM 
    Sales s
JOIN 
    Product p ON s.product_id = p.product_id
GROUP BY 
    p.name, YEAR(s.date);
SELECT 
    p.name AS product_name,
    YEAR(s.date) AS sales_year,
    SUM(s.amount) AS total_revenue
FROM 
    Sales s
JOIN 
    Product p ON s.product_id = p.product_id
GROUP BY 
    p.name, YEAR(s.date);
SELECT 
    r.name AS region_name,
    YEAR(s.date) AS sales_year,
    SUM(s.amount) AS total_revenue
FROM 
    Sales s
JOIN 
    Region r ON s.region_id = r.region_id
GROUP BY 
    r.name, YEAR(s.date)
ORDER BY 
    sales_year ASC, total_revenue DESC;
SELECT 
    p.category, 
    SUM(s.quantity) AS total_quantity
FROM 
    Sales s
JOIN 
    Product p ON s.product_id = p.product_id
GROUP BY 
    p.category
ORDER BY 
    total_quantity DESC
LIMIT 1;
-- L'articolo maggiormente richiesto del mercato sono i Veicoli
SELECT 
    p.name AS product_name
FROM 
    Product p
LEFT JOIN 
    Sales s ON p.product_id = s.product_id
WHERE 
    s.sales_id IS NULL;
-- Con la Left Join i prodotti invenduti sono i prodotti Bambola 
SELECT 
    name AS product_name
FROM 
    Product
WHERE 
    product_id NOT IN (
        SELECT product_id 
        FROM Sales
    );
-- Con la Not IN i prodotti invenduti sono i prodotti Bambola 
SELECT 
    p.name AS product_name,
    MAX(s.date) AS last_sale_date
FROM 
    Sales s
JOIN 
    Product p ON s.product_id = p.product_id
GROUP BY 
    p.name;
