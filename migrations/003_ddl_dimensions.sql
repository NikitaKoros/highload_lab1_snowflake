CREATE TABLE IF NOT EXISTS dim_location (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS dim_pet (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    type VARCHAR(100),
    name VARCHAR(100),
    breed VARCHAR(100),
    pet_category VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS dim_customer (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age INT,
    email VARCHAR(254),
    location_id UUID,
    pet_id UUID,
    PRIMARY KEY (id),
    CONSTRAINT customer_location_fk FOREIGN KEY (location_id) REFERENCES dim_location(id),
    CONSTRAINT customer_pet_fk FOREIGN KEY (pet_id) REFERENCES dim_pet(id)
);

CREATE TABLE IF NOT EXISTS dim_seller (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(254),
    location_id UUID,
    PRIMARY KEY (id),
    CONSTRAINT seller_location_fk FOREIGN KEY (location_id) REFERENCES dim_location(id)
);

CREATE TABLE IF NOT EXISTS dim_supplier (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    supplier_name VARCHAR(200),
    contact VARCHAR(100),
    email VARCHAR(254),
    phone VARCHAR(50),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS dim_product (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    product_name VARCHAR(200),
    product_category VARCHAR(100),
    product_price NUMERIC,
    product_quantity INT,
    product_weight NUMERIC,
    product_color VARCHAR(50),
    product_size VARCHAR(50),
    product_brand VARCHAR(100),
    product_material VARCHAR(100),
    product_description TEXT,
    product_rating NUMERIC,
    product_reviews INT,
    product_release_date DATE,
    product_expiry_date DATE,
    supplier_id UUID,
    PRIMARY KEY (id),
    CONSTRAINT product_supplier_fk FOREIGN KEY (supplier_id) REFERENCES dim_supplier(id)
);

CREATE TABLE IF NOT EXISTS dim_store (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    store_name VARCHAR(200),
    phone VARCHAR(50),
    email VARCHAR(254),
    location_id UUID,
    PRIMARY KEY (id),
    CONSTRAINT store_location_fk FOREIGN KEY (location_id) REFERENCES dim_location(id)
);
