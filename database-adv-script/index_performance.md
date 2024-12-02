### Objective: **Identify and Create Indexes to Improve Query Performance**

To optimize query performance for the **Airbnb Database**, we need to analyze the commonly used columns across the `User`, `Booking`, and `Property` tables and create indexes for them. Indexes can speed up the retrieval of data, especially in large tables, by reducing the time spent searching for specific rows during `SELECT`, `JOIN`, `WHERE`, and `ORDER BY` operations.

---

### **Step 1: Identify High-Usage Columns**

#### **User Table**:
- **`email`**: Frequently used for user lookups during login, registration, and account management. It's unique, so indexing it will significantly improve search speed.
- **`user_id`**: Often used in `JOIN` operations, particularly in queries that join the `User` table with the `Booking` table or others.

#### **Booking Table**:
- **`user_id`**: Used in queries to retrieve bookings made by a particular user. It is often part of `JOIN` clauses.
- **`property_id`**: Used to find all bookings for a specific property. Commonly used in `JOIN` and filtering queries.
- **`start_date`**: Used to filter and sort bookings by their start date (common in date range queries). Indexing this column speeds up date-based filtering and sorting.

#### **Property Table**:
- **`host_id`**: Used to retrieve all properties belonging to a specific host. Often used in `JOIN` operations.
- **`location`**: Frequently used for geographical filtering when searching for properties in a specific location.

---

### **Step 2: Create SQL Indexes**

Here are the SQL `CREATE INDEX` commands for the identified columns:

```sql
-- 1. Index on User table: email
CREATE INDEX idx_user_email ON "User"(email);

-- 2. Index on Booking table: user_id
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- 3. Index on Booking table: property_id
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- 4. Index on Property table: host_id
CREATE INDEX idx_property_host_id ON Property(host_id);

-- 5. Index on Booking table: start_date
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- 6. Index on Property table: location
CREATE INDEX idx_property_location ON Property(location);
```

### **Step 3: Measuring Query Performance**

To assess the impact of these indexes, we will measure the performance of a query before and after adding the indexes. The typical queries that will benefit from these indexes include:

1. **Fetching bookings for a user**:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM Booking
   WHERE user_id = 'some_user_id';
   ```

2. **Fetching bookings for a specific property**:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM Booking
   WHERE property_id = 'some_property_id';
   ```

3. **Fetching properties by location**:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM Property
   WHERE location = 'New York';
   ```

4. **Fetching bookings in a date range**:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM Booking
   WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
   ```

---

### **Step 4: Measure Query Performance Before Indexing**

Before adding indexes, run the queries above and check the execution plans with `EXPLAIN ANALYZE` to identify inefficiencies such as **full table scans** or **high I/O**. Example:

```sql
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
```

The execution plan may show a **Seq Scan** (sequential scan) or **Index Scan** if an index is missing, indicating that the query is not optimized. The **actual time** and **rows scanned** will give insight into query performance.

---

### **Step 5: Measure Query Performance After Adding Indexes**

After adding the above indexes, rerun the same queries and use `EXPLAIN ANALYZE` to see if the database uses the indexes. The expected results should show **Index Scans** instead of **Seq Scans**, which significantly improves performance, especially for large tables.

Example output after indexing:

```sql
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
```

Output:

```plaintext
QUERY PLAN
--------------------------------------------------------
Index Scan using idx_booking_start_date on Booking  (cost=0.42..8.56 rows=100 width=100) (actual time=0.001..0.021 rows=100 loops=1)
  Index Cond: (start_date >= '2024-01-01' AND start_date <= '2024-12-31')
Planning Time: 0.092 ms
Execution Time: 0.123 ms
```

In this case, the query should execute faster (in this example, it's only 0.123 ms) compared to before, where the query might have taken tens or hundreds of milliseconds due to full table scans.

---

### **Step 6: Report on Improvements**

#### **Before Indexing**:
- Queries on the `Booking` table, such as fetching bookings by date range or `user_id`, might result in **full table scans**, leading to slower performance on large datasets.
- Execution times were relatively high due to the database scanning all rows in the table.

#### **After Indexing**:
- With indexes on frequently queried columns (`user_id`, `property_id`, `start_date`), the database now uses **Index Scans** for the queries.
- The execution time is **significantly reduced** as the indexes allow the database to quickly locate the relevant rows instead of scanning the entire table.
- For example, a query for bookings in a date range that would previously scan the entire `Booking` table now executes in just milliseconds, making the overall system much more responsive.

### **Conclusion**:
By creating indexes on key columns in the `User`, `Booking`, and `Property` tables, we have optimized query performance significantly. Indexing will especially help when dealing with large datasets, as it reduces the need for full table scans and ensures that common queries like those based on `user_id`, `start_date`, and `location` are handled more efficiently.

---

### **Saving SQL Index Commands to `database_index.sql`**

```sql
-- database_index.sql

-- 1. Index on User table: email
CREATE INDEX idx_user_email ON "User"(email);

-- 2. Index on Booking table: user_id
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- 3. Index on Booking table: property_id
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- 4. Index on Property table: host_id
CREATE INDEX idx_property_host_id ON Property(host_id);

-- 5. Index on Booking table: start_date
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- 6. Index on Property table: location
CREATE INDEX idx_property_location ON Property(location);
```

