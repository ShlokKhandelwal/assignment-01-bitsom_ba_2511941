## Anomaly Analysis

### Insert Anomaly
A new product cannot be added to the system unless it is part of an order.
In `orders_flat.csv`, product information (product_id, product_name, category,
unit_price) is stored only within order rows. For example, if the company stocks
a new product like "Whiteboard Marker" but no customer has ordered it yet, there
is no way to record it in this flat table. The product's existence depends entirely
on someone placing an order first.

### Update Anomaly
Sales representative information is repeated across multiple rows. For example,
SR01 (Deepak Joshi, deepak@corp.com, Mumbai HQ, Nariman Point, Mumbai - 400021)
appears in orders ORD1114, ORD1153, and ORD1083. If Deepak's email address or
office address changes, every single row containing SR01 must be updated manually.
Missing even one row would leave the database in an inconsistent state where the
same sales rep has two different email addresses.

### Delete Anomaly
If an order is the only order containing a particular product, deleting that order
permanently destroys all information about that product. For example, ORD1075 is
the only order for "Desk Chair" (P003, Furniture, 8500). If this order is deleted
because it was cancelled or entered by mistake, all knowledge of the Desk Chair
product — its ID, category, and price — is lost from the system entirely.


## Normalization Justification

Keeping all data in one flat table might seem simpler at first glance, but it
creates serious practical problems that grow worse as the business scales.

Consider the orders_flat.csv dataset. Sales rep Deepak Joshi (SR01) appears in
multiple rows — ORD1114, ORD1153, and ORD1083. In a flat table, if Deepak moves
to a new office or changes his email, someone must manually find and update every
row he appears in. With hundreds of orders, this becomes error-prone and
time-consuming. One missed row means the database now contains two conflicting
email addresses for the same person — a direct data integrity failure.

Similarly, product information like the price of "Pen Set" (P007, ₹250) is
repeated across orders ORD1114, ORD1153, ORD1118, ORD1132, ORD1037, and ORD1083.
If the price changes, all six rows must be updated. In a normalized design, price
lives in one products table — update it once, and every order automatically
reflects the correct price.

The flat table also makes it impossible to record a product that has not yet been
ordered, or a customer who has not yet placed an order. This limits business
operations — for example, a newly hired sales rep cannot be added to the system
until they close their first deal.

Normalization solves all of these issues by separating data into focused tables:
customers, products, sales_reps, and orders. Each piece of information is stored
exactly once. This is not over-engineering — it is the foundation of a database
that remains accurate and maintainable as the business grows.