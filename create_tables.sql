-- Таблица покупателей
CREATE TABLE customers (
    customer_key SERIAL PRIMARY KEY,
    customer_id int8 NOT NULL,
    first_name text,
    last_name text,
    email text,
    age int8,
    country text,
    postal_code text,
    pet_type text,
    pet_name text,
    pet_breed text,
    effective_date timestamp,
    expiration_date timestamp,
    is_current boolean
);

-- Таблица продавцов
CREATE TABLE sellers (
    seller_key SERIAL PRIMARY KEY,
    seller_id int8 NOT NULL,
    first_name text,
    last_name text,
    email text,
    country text,
    postal_code text,
    effective_date timestamp,
    expiration_date timestamp,
    is_current boolean
);

-- Таблица товаров
CREATE TABLE products (
    product_key SERIAL PRIMARY KEY,
    product_id int8 NOT NULL,
    name text,
    category text,
    pet_category text,
    price float8,
    weight float8,
    color text,
    size text,
    brand text,
    material text,
    description text,
    rating float8,
    reviews int8,
    release_date text,
    expiry_date text,
    effective_date timestamp,
    expiration_date timestamp,
    is_current boolean
);

-- Таблица магазинов
CREATE TABLE stores (
    store_key SERIAL PRIMARY KEY,
    store_id SERIAL NOT NULL,
    name text,
    location text,
    city text,
    state text,
    country text,
    phone text,
    email text,
    effective_date timestamp,
    expiration_date timestamp,
    is_current boolean
);

-- Таблица поставщиков
CREATE TABLE suppliers (
    supplier_key SERIAL PRIMARY KEY,
    supplier_id SERIAL NOT NULL,
    name text,
    contact text,
    email text,
    phone text,
    address text,
    city text,
    country text,
    effective_date timestamp,
    expiration_date timestamp,
    is_current boolean
);

-- Таблица дат
CREATE TABLE dates (
    date_key SERIAL PRIMARY KEY,
    full_date date,
    day int,
    month int,
    year int,
    quarter int,
    day_of_week int,
    day_name text,
    month_name text,
    is_weekend boolean
);

CREATE TABLE fact_sales (
    sale_key SERIAL PRIMARY KEY,
    customer_key int REFERENCES customers(customer_key),
    seller_key int REFERENCES sellers(seller_key),
    product_key int REFERENCES products(product_key),
    store_key int REFERENCES stores(store_key),
    supplier_key int REFERENCES suppliers(supplier_key),
    date_key int REFERENCES dates(date_key),
    quantity int8,
    total_price float8,
    unit_price float8
);