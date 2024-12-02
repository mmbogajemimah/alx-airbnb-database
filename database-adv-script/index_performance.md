To improve query performance, especially on high-usage columns in the **User**, **Booking**, and **Property** tables, we need to identify the frequently queried columns. These include those used in `WHERE`, `JOIN`, and `ORDER BY` clauses, which often benefit from indexing.

Here’s a step-by-step process:

### Step 1: Identify High-Usage Columns
- **User Table**:
  - `user_id`: This is the primary key and frequently used in `JOIN` operations (e.g., `Booking.user_id`, `Review.user_id`).
  - `email`: Often queried in `WHERE` clauses to search for users.
  - `role`: Could be used for filtering user types (e.g., `guest`, `host`, `admin`).

- **Booking Table**:
  - `user_id`: Used to identify which user made the booking (e.g., `WHERE user_id = ...`).
  - `property_id`: Used to join with the **Property** table and to filter bookings by property.
  - `start_date` and `end_date`: Used in filtering bookings by date ranges, often in the `WHERE` clause (e.g., `WHERE start_date >= ... AND end_date <= ...`).

- **Property Table**:
  - `property_id`: This is the primary key and is used in `JOIN` operations with the **Booking** and **Review** tables.
  - `host_id`: Foreign key used to identify the user (host) of the property, often queried in `JOIN` and `WHERE` clauses.
  - `location`: Could be used in filtering searches by location, especially for searching available properties.

### Step 2: Create Indexes
Based on the analysis, we can create indexes for the high-usage columns.

#### SQL Index Creation Commands

```sql
-- **User Table**
-- Index on `user_id` for quick access during JOINs and lookups
CREATE INDEX idx_user_id ON User(user_id);

-- Index on `email` for faster user lookup by email
CREATE INDEX idx_user_email ON User(email);

-- Index on `role` for faster filtering by user type (e.g., `WHERE role = 'host'`)
CREATE INDEX idx_user_role ON User(role);

-- **Booking Table**
-- Index on `user_id` for filtering and joining with the `User` table
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on `property_id` for filtering and joining with the `Property` table
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Composite index on `start_date` and `end_date` to speed up range queries
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- **Property Table**
-- Index on `property_id` for faster lookups and joins with the `Booking` and `Review` tables
CREATE INDEX idx_property_id ON Property(property_id);

-- Index on `host_id` for filtering by the host (owner of the property)
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Index on `location` for fast filtering/searching based on location
CREATE INDEX idx_property_location ON Property(location);
```

### Step 3: Save Index Creation in `database_index.sql`
To save the above commands to a file named `database_index.sql`, simply place the following content in a file:

```sql
-- Indexes for User Table
CREATE INDEX idx_user_id ON User(user_id);
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);

-- Indexes for Booking Table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Indexes for Property Table
CREATE INDEX idx_property_id ON Property(property_id);
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
```

### Step 4: Measure Query Performance Before and After Adding Indexes

To measure the impact of these indexes on query performance, we can use `EXPLAIN` (for MySQL, PostgreSQL) or `ANALYZE` (for PostgreSQL) to check the query execution plan before and after adding indexes.

#### Example Query Performance Test (Before and After Indexes)

1. **Before Adding Indexes:**
   Run `EXPLAIN` or `ANALYZE` for a typical query, such as retrieving bookings for a user:

   ```sql
   EXPLAIN 
   SELECT * FROM Booking WHERE user_id = 'some-user-id';
   ```

   The output will provide information on how the query is executed, whether it's performing a full table scan or using an index.

2. **After Adding Indexes:**
   After creating the indexes, run the same query again and use `EXPLAIN` or `ANALYZE`:

   ```sql
   EXPLAIN 
   SELECT * FROM Booking WHERE user_id = 'some-user-id';
   ```

   Look at the output to see if the query now uses an index (it should show `Index Scan` or similar, rather than `Seq Scan` or `Full Table Scan`).

### Example of `EXPLAIN` Output

Before adding indexes (without indexes):

```plaintext
+----+-------------+---------+------+---------------+---------+---------+-------+------+----------+-------------------+
| id | select_type | table   | type | possible_keys | key     | key_len | ref   | rows | filtered | Extra             |
+----+-------------+---------+------+---------------+---------+---------+-------+------+----------+-------------------+
|  1 | SIMPLE      | Booking | ALL  | NULL          | NULL    | NULL    | NULL  | 1000 |   100.00 | Using where       |
+----+-------------+---------+------+---------------+---------+---------+-------+------+----------+-------------------+
```

After adding indexes (with indexes):

```plaintext
+----+-------------+---------+------+-------------------+-------------------+---------+-------+------+----------+-------------------+
| id | select_type | table   | type | possible_keys     | key               | key_len | ref   | rows | filtered | Extra             |
+----+-------------+---------+------+-------------------+-------------------+---------+-------+------+----------+-------------------+
|  1 | SIMPLE      | Booking | ref  | idx_booking_user_id | idx_booking_user_id | 16      | const | 10   |   100.00 | Using where       |
+----+-------------+---------+------+-------------------+-------------------+---------+-------+------+----------+-------------------+
```

Notice how the `type` changes from `ALL` (Full Table Scan) to `ref` (Index Scan) after adding indexes, which indicates a performance improvement.

---

### Conclusion

- By adding indexes on frequently used columns (`user_id`, `property_id`, `start_date`, `location`, etc.), we improve query performance, especially for filtering and joining operations.
- Use the `EXPLAIN` or `ANALYZE` commands to measure the performance before and after creating the indexes to ensure they’re being utilized effectively by the query planner.
