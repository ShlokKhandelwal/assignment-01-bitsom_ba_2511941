-- Schema Design: Normalized tables from orders_flat.csv

-- ---------------------------------------------
-- TABLE 1: customers
-- ---------------------------------------------
CREATE TABLE customers (
    customer_id    TEXT PRIMARY KEY,
    customer_name  TEXT NOT NULL,
    customer_email TEXT NOT NULL,
    customer_city  TEXT NOT NULL
);

-- ---------------------------------------------
-- TABLE 2: products
-- ---------------------------------------------
CREATE TABLE products (
    product_id   TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    category     TEXT NOT NULL,
    unit_price   REAL NOT NULL
);

-- ---------------------------------------------
-- TABLE 3: sales_reps
-- ---------------------------------------------
CREATE TABLE sales_reps (
    sales_rep_id    TEXT PRIMARY KEY,
    sales_rep_name  TEXT NOT NULL,
    sales_rep_email TEXT NOT NULL,
    office_address  TEXT NOT NULL
);

-- ---------------------------------------------
-- TABLE 4: orders
-- ---------------------------------------------
CREATE TABLE orders (
    order_id     TEXT PRIMARY KEY,
    order_date   TEXT NOT NULL,
    quantity     INTEGER NOT NULL,
    customer_id  TEXT NOT NULL,
    product_id   TEXT NOT NULL,
    sales_rep_id TEXT NOT NULL,
    FOREIGN KEY (customer_id)  REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)   REFERENCES products(product_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

-- ---------------------------------------------
-- INSERT DATA: customers (5 rows)
-- ---------------------------------------------
INSERT INTO customers VALUES ('C001', 'Rohan Mehta',   'rohan@gmail.com',   'Mumbai');
INSERT INTO customers VALUES ('C002', 'Priya Sharma',  'priya@gmail.com',   'Delhi');
INSERT INTO customers VALUES ('C003', 'Amit Verma',    'amit@gmail.com',    'Bangalore');
INSERT INTO customers VALUES ('C004', 'Sunita Rao',    'sunita@gmail.com',  'Chennai');
INSERT INTO customers VALUES ('C005', 'Vikram Singh',  'vikram@gmail.com',  'Mumbai');
INSERT INTO customers VALUES ('C006', 'Neha Gupta',    'neha@gmail.com',    'Delhi');

-- ---------------------------------------------
-- INSERT DATA: products (5 rows)
-- ---------------------------------------------
INSERT INTO products VALUES ('P001', 'Laptop',      'Electronics', 55000);
INSERT INTO products VALUES ('P002', 'Office Desk', 'Furniture',   12000);
INSERT INTO products VALUES ('P003', 'Desk Chair',  'Furniture',    8500);
INSERT INTO products VALUES ('P004', 'Notebook',    'Stationery',    120);
INSERT INTO products VALUES ('P005', 'Headphones',  'Electronics',  3200);
INSERT INTO products VALUES ('P006', 'Whiteboard',  'Stationery',    899);
INSERT INTO products VALUES ('P007', 'Pen Set',     'Stationery',    250);

-- ---------------------------------------------
-- INSERT DATA: sales_reps (5 rows)
-- ---------------------------------------------
INSERT INTO sales_reps VALUES (
    'SR01', 'Deepak Joshi', 'deepak@corp.com',
    'Mumbai HQ, Nariman Point, Mumbai - 400021'
);
INSERT INTO sales_reps VALUES (
    'SR02', 'Anita Desai', 'anita@corp.com',
    'Delhi Office, Connaught Place, New Delhi - 110001'
);
INSERT INTO sales_reps VALUES (
    'SR03', 'Ravi Kumar', 'ravi@corp.com',
    'South Zone, MG Road, Bangalore - 560001'
);
INSERT INTO sales_reps VALUES (
    'SR04', 'Meena Pillai', 'meena@corp.com',
    'Chennai Branch, Anna Salai, Chennai - 600002'
);
INSERT INTO sales_reps VALUES (
    'SR05', 'Arjun Nair', 'arjun@corp.com',
    'West Zone, FC Road, Pune - 411004'
);

-- ---------------------------------------------
-- INSERT DATA: orders (10 rows)
-- ---------------------------------------------
INSERT INTO orders VALUES ('ORD1027', '2023-11-02', 4, 'C002', 'P004', 'SR02');
INSERT INTO orders VALUES ('ORD1114', '2023-08-06', 2, 'C001', 'P007', 'SR01');
INSERT INTO orders VALUES ('ORD1153', '2023-02-14', 3, 'C006', 'P007', 'SR01');
INSERT INTO orders VALUES ('ORD1002', '2023-01-17', 1, 'C002', 'P005', 'SR02');
INSERT INTO orders VALUES ('ORD1118', '2023-11-10', 5, 'C006', 'P007', 'SR02');
INSERT INTO orders VALUES ('ORD1132', '2023-03-07', 5, 'C003', 'P007', 'SR02');
INSERT INTO orders VALUES ('ORD1037', '2023-03-06', 2, 'C002', 'P007', 'SR03');
INSERT INTO orders VALUES ('ORD1075', '2023-04-18', 3, 'C005', 'P003', 'SR03');
INSERT INTO orders VALUES ('ORD1083', '2023-07-03', 2, 'C006', 'P007', 'SR01');
INSERT INTO orders VALUES ('ORD1091', '2023-09-15', 1, 'C004', 'P001', 'SR04');