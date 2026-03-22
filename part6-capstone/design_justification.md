## Storage Systems

The hospital system requires four different storage systems, each chosen
for a specific goal.

For Goal 1 (predicting patient readmission), a Data Lake storing raw
historical treatment data in its original format is used as the data
source. This feeds a machine learning pipeline (Python/Scikit-learn)
that trains and serves the readmission prediction model. The Data Lake
is ideal here because ML models need large volumes of raw, unprocessed
historical data in flexible formats.

For Goal 2 (plain English search of patient history), a Vector Database
(ChromaDB) is used. Doctor notes and patient history are converted into
embeddings and stored as vectors. When a doctor asks "Has this patient
had a cardiac event before?", the query is converted to a vector and
semantically similar records are retrieved instantly — even if different
terminology was used in the original notes.

For Goal 3 (monthly management reports), a Data Warehouse (Amazon
Redshift) is used. Cleaned, structured data about bed occupancy,
department costs, and admissions is loaded here via an ETL pipeline.
Business Intelligence tools like Power BI connect to Redshift to
generate monthly dashboards for hospital administrators.

For Goal 4 (real-time ICU vitals), Apache Kafka is used as a streaming
ingestion layer. ICU sensor data streams continuously into Kafka, which
routes it to both a time-series database for real-time monitoring alerts
and the Data Lake for long-term storage and ML training.

## OLTP vs OLAP Boundary

The OLTP (transactional) system is PostgreSQL, which handles all
day-to-day operations — registering new patients, recording
prescriptions, updating treatment status, and logging doctor visits.
This system is optimized for fast individual reads and writes with full
ACID compliance to ensure no medical record is ever partially written.

The boundary between OLTP and OLAP occurs at the ETL pipeline. Every
night, a scheduled ETL job extracts the previous day's completed records
from PostgreSQL, transforms them (cleaning nulls, standardizing formats,
computing derived metrics like length of stay and total cost), and loads
them into the Data Warehouse (Redshift). From this point, all analytical
queries — monthly reports, trend analysis, department comparisons — run
against Redshift, not PostgreSQL. This separation ensures that heavy
analytical queries never slow down the live hospital operations system.

## Trade-offs

The most significant trade-off in this design is complexity vs
flexibility. Using five different storage systems (PostgreSQL, Data Lake,
Vector DB, Data Warehouse, Kafka) gives each workload its optimal
storage engine, but it dramatically increases operational complexity.
The engineering team must maintain five different systems, each with
its own backups, security policies, access controls, and failure modes.
For a hospital, a failure in any one system could impact patient care.

To mitigate this, I would recommend adopting a Data Lakehouse
architecture (using Delta Lake on top of cloud object storage) as a
consolidation layer. This would allow the Data Lake and Data Warehouse
to be merged into a single system that supports both raw storage and
fast SQL analytics. Additionally, using a managed cloud platform such
as AWS or Azure would reduce operational burden significantly — services
like AWS MSK (managed Kafka), AWS Redshift, and AWS S3 are maintained
by Amazon, freeing the hospital's engineering team to focus on the
application layer rather than infrastructure management.