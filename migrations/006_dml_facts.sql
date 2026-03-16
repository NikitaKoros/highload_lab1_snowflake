-- fact_sale
INSERT INTO fact_sale (sale_date, customer_id, seller_id, product_id, store_id, sale_quantity, sale_total_price)
SELECT
    m.sale_date,
    c.id,
    se.id,
    p.id,
    st.id,
    m.sale_quantity,
    m.sale_total_price
FROM mock_data m
JOIN dim_customer c ON c.email = m.customer_email
JOIN dim_seller se ON se.email = m.seller_email
JOIN dim_product p ON p.product_name = m.product_name AND p.product_brand = m.product_brand
JOIN dim_store st ON st.store_name = m.store_name;
