-- dim_location
INSERT INTO dim_location (country, city, state, postal_code)
-- store: country + city + state
SELECT DISTINCT
    store_country,
    store_city,
    store_state,
    NULL
FROM mock_data
WHERE store_city IS NOT NULL
UNION
-- supplier: country + city
SELECT DISTINCT
    supplier_country,
    supplier_city,
    NULL,
    NULL
FROM mock_data
WHERE supplier_city IS NOT NULL
UNION
-- customer: country + postal_code
SELECT DISTINCT
    customer_country,
    NULL,
    NULL,
    customer_postal_code
FROM mock_data
WHERE customer_postal_code IS NOT NULL
UNION
-- seller: country + postal_code
SELECT DISTINCT
    seller_country,
    NULL,
    NULL,
    seller_postal_code
FROM mock_data
WHERE seller_postal_code IS NOT NULL;

-- dim_pet
INSERT INTO dim_pet (type, name, breed, pet_category)
SELECT DISTINCT
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed,
    pet_category
FROM mock_data
WHERE customer_pet_type IS NOT NULL;

-- dim_customer
INSERT INTO dim_customer (first_name, last_name, age, email, location_id, pet_id)
SELECT DISTINCT ON (m.customer_email)
    m.customer_first_name,
    m.customer_last_name,
    m.customer_age,
    m.customer_email,
    l.id,
    p.id
FROM mock_data m
LEFT JOIN dim_location l
    ON l.country = m.customer_country
    AND l.postal_code = m.customer_postal_code
JOIN dim_pet p
    ON p.type = m.customer_pet_type
    AND p.name = m.customer_pet_name
    AND p.breed = m.customer_pet_breed;

-- dim_seller
INSERT INTO dim_seller (first_name, last_name, email, location_id)
SELECT DISTINCT ON (m.seller_email)
    m.seller_first_name,
    m.seller_last_name,
    m.seller_email,
    l.id
FROM mock_data m
LEFT JOIN dim_location l
    ON l.country = m.seller_country
    AND l.postal_code = m.seller_postal_code;

-- dim_supplier
INSERT INTO dim_supplier (supplier_name, contact, email, phone, address, city, country)
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
FROM mock_data
WHERE supplier_name IS NOT NULL;

-- dim_product
INSERT INTO dim_product (
    product_name, product_category, product_price, product_quantity,
    product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date, supplier_id
)
SELECT DISTINCT ON (m.product_name, m.product_brand)
    m.product_name,
    m.product_category,
    m.product_price,
    m.product_quantity,
    m.product_weight,
    m.product_color,
    m.product_size,
    m.product_brand,
    m.product_material,
    m.product_description,
    m.product_rating,
    m.product_reviews,
    m.product_release_date,
    m.product_expiry_date,
    s.id
FROM mock_data m
JOIN dim_supplier s ON s.supplier_name = m.supplier_name;

-- dim_store
INSERT INTO dim_store (store_name, phone, email, location_id)
SELECT DISTINCT ON (m.store_name)
    m.store_name,
    m.store_phone,
    m.store_email,
    l.id
FROM mock_data m
LEFT JOIN dim_location l
    ON l.country = m.store_country
    AND l.city = m.store_city
    AND l.state = m.store_state;
