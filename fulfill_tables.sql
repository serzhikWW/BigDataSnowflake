INSERT INTO customers (
    customer_id, first_name, last_name, email, age, country, postal_code,
    pet_type, pet_name, pet_breed, effective_date, is_current
)
SELECT DISTINCT
    id, customer_first_name, customer_last_name, customer_email, customer_age,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name,
    customer_pet_breed, CURRENT_TIMESTAMP, TRUE
FROM mock_data;

INSERT INTO sellers (
    seller_id, first_name, last_name, email, country, postal_code,
    effective_date, is_current
)
SELECT DISTINCT
    sale_seller_id, seller_first_name, seller_last_name, seller_email,
    seller_country, seller_postal_code, CURRENT_TIMESTAMP, TRUE
FROM mock_data
WHERE sale_seller_id IS NOT NULL;

INSERT INTO products (
    product_id, name, category, pet_category, price, weight, color, size,
    brand, material, description, rating, reviews, release_date, expiry_date,
    effective_date, is_current
)
SELECT DISTINCT
    sale_product_id, product_name, product_category, pet_category, product_price,
    product_weight, product_color, product_size, product_brand, product_material,
    product_description, product_rating, product_reviews, product_release_date,
    product_expiry_date, CURRENT_TIMESTAMP, TRUE
FROM mock_data
WHERE sale_product_id IS NOT NULL;

INSERT INTO stores (
    name, location, city, state, country, phone, email,
    effective_date, is_current
)
SELECT DISTINCT
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email, CURRENT_TIMESTAMP, TRUE
FROM mock_data
WHERE store_name IS NOT NULL;

INSERT INTO suppliers (
    name, contact, email, phone, address, city, country,
    effective_date, is_current
)
SELECT DISTINCT
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country, CURRENT_TIMESTAMP, TRUE
FROM mock_data
WHERE supplier_name IS NOT NULL;

INSERT INTO dates (
    full_date, day, month, year, quarter, day_of_week, day_name, month_name, is_weekend
)
SELECT DISTINCT
    sale_date::date,
    EXTRACT(DAY FROM sale_date::date),
    EXTRACT(MONTH FROM sale_date::date),
    EXTRACT(YEAR FROM sale_date::date),
    EXTRACT(QUARTER FROM sale_date::date),
    EXTRACT(DOW FROM sale_date::date),
    TO_CHAR(sale_date::date, 'Day'),
    TO_CHAR(sale_date::date, 'Month'),
    EXTRACT(DOW FROM sale_date::date) IN (0, 6)
FROM (
    SELECT DISTINCT sale_date
    FROM mock_data
    WHERE sale_date IS NOT NULL
) dates;

INSERT INTO public.fact_sales (
    sale_date,
    customer_id,
    seller_id,
    product_id,
    quantity,
    total_price,
    store_id
)
SELECT
    sale_date::date AS sale_date,
    id AS customer_id,
    sale_seller_id AS seller_id,
    sale_product_id AS product_id,
    sale_quantity AS quantity,
    sale_total_price AS total_price,
    (SELECT store_key FROM stores WHERE name = m.store_name LIMIT 1) AS store_id
FROM
    public.mock_data m
WHERE
    sale_date IS NOT NULL
    AND id IS NOT NULL
    AND sale_seller_id IS NOT NULL
    AND sale_product_id IS NOT NULL
    AND sale_quantity IS NOT NULL
    AND sale_total_price IS NOT NULL;