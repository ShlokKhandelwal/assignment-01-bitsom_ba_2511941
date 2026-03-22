-- Star Schema Design for Retail Data Warehouse

-- ---------------------------------------------
-- DIMENSION TABLE 1: dim_date
-- ---------------------------------------------
CREATE TABLE dim_date (
    date_id     INTEGER PRIMARY KEY,
    full_date   TEXT NOT NULL,
    day         INTEGER NOT NULL,
    month       INTEGER NOT NULL,
    month_name  TEXT NOT NULL,
    quarter     INTEGER NOT NULL,
    year        INTEGER NOT NULL
);

-- ---------------------------------------------
-- DIMENSION TABLE 2: dim_store
-- ---------------------------------------------
CREATE TABLE dim_store (
    store_id    INTEGER PRIMARY KEY,
    store_name  TEXT NOT NULL,
    store_city  TEXT NOT NULL
);

-- ---------------------------------------------
-- DIMENSION TABLE 3: dim_product
-- ---------------------------------------------
CREATE TABLE dim_product (
    product_id      INTEGER PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category        TEXT NOT NULL
);

-- ---------------------------------------------
-- FACT TABLE: fact_sales
-- ---------------------------------------------
CREATE TABLE fact_sales (
    sale_id         INTEGER PRIMARY KEY,
    date_id         INTEGER NOT NULL,
    store_id        INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    units_sold      INTEGER NOT NULL,
    unit_price      REAL NOT NULL,
    total_revenue   REAL NOT NULL,
    FOREIGN KEY (date_id)    REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id)   REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- ---------------------------------------------
-- INSERT: dim_date (cleaned & standardized)
-- All dates converted to YYYY-MM-DD format
-- ---------------------------------------------
INSERT INTO dim_date VALUES (1,  '2023-08-29', 29, 8,  'August',    3, 2023);
INSERT INTO dim_date VALUES (2,  '2023-12-12', 12, 12, 'December',  4, 2023);
INSERT INTO dim_date VALUES (3,  '2023-02-05',  5, 2,  'February',  1, 2023);
INSERT INTO dim_date VALUES (4,  '2023-02-20', 20, 2,  'February',  1, 2023);
INSERT INTO dim_date VALUES (5,  '2023-01-15', 15, 1,  'January',   1, 2023);
INSERT INTO dim_date VALUES (6,  '2023-08-09',  9, 8,  'August',    3, 2023);
INSERT INTO dim_date VALUES (7,  '2023-03-31', 31, 3,  'March',     1, 2023);
INSERT INTO dim_date VALUES (8,  '2023-10-26', 26, 10, 'October',   4, 2023);
INSERT INTO dim_date VALUES (9,  '2023-12-08',  8, 12, 'December',  4, 2023);
INSERT INTO dim_date VALUES (10, '2023-08-15', 15, 8,  'August',    3, 2023);

-- ---------------------------------------------
-- INSERT: dim_store
-- ---------------------------------------------
INSERT INTO dim_store VALUES (1, 'Chennai Anna',  'Chennai');
INSERT INTO dim_store VALUES (2, 'Delhi South',   'Delhi');
INSERT INTO dim_store VALUES (3, 'Bangalore MG',  'Bangalore');
INSERT INTO dim_store VALUES (4, 'Pune FC Road',  'Pune');
INSERT INTO dim_store VALUES (5, 'Mumbai West',   'Mumbai');

-- ---------------------------------------------
-- INSERT: dim_product
-- Categories cleaned: all standardized to title case
-- "electronics" → "Electronics"
-- "Grocery"     → "Groceries"
-- ---------------------------------------------
INSERT INTO dim_product VALUES (1, 'Speaker',     'Electronics');
INSERT INTO dim_product VALUES (2, 'Tablet',      'Electronics');
INSERT INTO dim_product VALUES (3, 'Phone',       'Electronics');
INSERT INTO dim_product VALUES (4, 'Smartwatch',  'Electronics');
INSERT INTO dim_product VALUES (5, 'Atta 10kg',   'Groceries');
INSERT INTO dim_product VALUES (6, 'Jeans',       'Clothing');
INSERT INTO dim_product VALUES (7, 'Biscuits',    'Groceries');

-- ---------------------------------------------
-- INSERT: fact_sales (10 rows — cleaned data)
-- total_revenue = units_sold * unit_price
-- ---------------------------------------------
INSERT INTO fact_sales VALUES (1,  1,  1, 1,  3,  49262.78, 147788.34);
INSERT INTO fact_sales VALUES (2,  2,  1, 2,  11, 23226.12, 255487.32);
INSERT INTO fact_sales VALUES (3,  3,  1, 3,  20, 48703.39, 974067.80);
INSERT INTO fact_sales VALUES (4,  4,  2, 2,  14, 23226.12, 325165.68);
INSERT INTO fact_sales VALUES (5,  5,  1, 4,  10, 58851.01, 588510.10);
INSERT INTO fact_sales VALUES (6,  6,  3, 5,  12, 52464.00, 629568.00);
INSERT INTO fact_sales VALUES (7,  7,  4, 4,  6,  58851.01, 353106.06);
INSERT INTO fact_sales VALUES (8,  8,  4, 6,  16, 2317.47,  37079.52);
INSERT INTO fact_sales VALUES (9,  9,  3, 7,  9,  27469.99, 247229.91);
INSERT INTO fact_sales VALUES (10, 10, 3, 4,  3,  58851.01, 176553.03);