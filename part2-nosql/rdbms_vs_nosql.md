## Database Recommendation

For a healthcare startup building a patient management system, I would recommend
MySQL (a relational database) as the primary database, with a specific caveat
for the fraud detection module.

Patient data is highly structured and consistent — every patient has a name, age,
blood group, diagnosis, prescriptions, and treatment history. This structured
nature maps perfectly to relational tables. More importantly, healthcare data
demands ACID compliance (Atomicity, Consistency, Isolation, Durability). Consider
a scenario where a doctor updates a patient's medication: either the entire update
must succeed, or none of it should. A partial write — where the old drug is removed
but the new one is not recorded — could be life-threatening. MySQL guarantees this
through ACID transactions. MongoDB, which follows the BASE model (Basically
Available, Soft state, Eventually consistent), does not provide the same level of
guarantee by default.

From a CAP theorem perspective, MySQL prioritizes Consistency and Partition
Tolerance (CP). For medical records, consistency is non-negotiable — every doctor
reading a patient file must see the exact same, most up-to-date information.
Eventual consistency, which MongoDB accepts in distributed setups, is unacceptable
in clinical environments.

However, for the fraud detection module, I would reconsider. Fraud detection
requires analyzing large volumes of unstructured or semi-structured data — login
patterns, device fingerprints, behavioral signals — at very high speed. MongoDB's
flexible document model and horizontal scalability make it better suited for
ingesting and querying this kind of varied, high-velocity data.

Therefore, my final recommendation is a hybrid approach: MySQL for the core
patient management system where data integrity is critical, and MongoDB for the
fraud detection pipeline where flexibility and speed matter more than strict
consistency.