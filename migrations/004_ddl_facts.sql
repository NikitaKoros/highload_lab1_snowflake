CREATE TABLE IF NOT EXISTS fact_sale (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    sale_date DATE,
    customer_id UUID,
    seller_id UUID,
    product_id UUID,
    store_id UUID,
    sale_quantity INT,
    sale_total_price NUMERIC,
    PRIMARY KEY (id),
    CONSTRAINT sale_customer_fk FOREIGN KEY (customer_id) REFERENCES dim_customer(id),
    CONSTRAINT sale_seller_fk FOREIGN KEY (seller_id) REFERENCES dim_seller(id),
    CONSTRAINT sale_product_fk FOREIGN KEY (product_id) REFERENCES dim_product(id),
    CONSTRAINT sale_store_fk FOREIGN KEY (store_id) REFERENCES dim_store(id)
);