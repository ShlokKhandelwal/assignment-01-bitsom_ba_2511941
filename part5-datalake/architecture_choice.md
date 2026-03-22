## Architecture Recommendation

For a fast-growing food delivery startup collecting GPS location logs, customer
text reviews, payment transactions, and restaurant menu images, I would recommend
a **Data Lakehouse** architecture.

**Reason 1 — Variety of Data Types**
The startup collects four fundamentally different types of data: structured data
(payment transactions), semi-structured data (GPS logs and text reviews), and
unstructured data (restaurant menu images). A traditional Data Warehouse can only
handle structured, pre-defined data and would reject GPS logs and images entirely.
A pure Data Lake can store everything but lacks the querying and governance
capabilities needed for payment reporting. A Data Lakehouse handles all four data
types in one unified system — raw files for images and logs, structured tables for
transactions.

**Reason 2 — Real-Time and Batch Processing Together**
GPS location data streams in real time from thousands of delivery riders
simultaneously, while payment reports are generated in batches at end of day.
A Data Lakehouse supports both streaming ingestion and batch analytics in the
same platform, eliminating the need to maintain two separate systems.

**Reason 3 — Cost-Effective Scalability**
As the startup grows from hundreds to millions of orders, storage costs become
critical. A Data Lakehouse stores raw data on cheap object storage (like AWS S3)
while adding a metadata and indexing layer (like Delta Lake or Apache Iceberg)
on top for fast SQL queries. This gives the performance of a Data Warehouse at
the storage cost of a Data Lake — the best of both worlds for a fast-growing
startup watching its infrastructure budget.