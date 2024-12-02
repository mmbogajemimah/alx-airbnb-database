# Index Implementation and Performance Optimization for Airbnb Database

This document describes the implementation of indexes in the Airbnb database to optimize query performance. We identify key columns that are frequently used in queries (e.g., in `WHERE`, `JOIN`, or `ORDER BY` clauses) and create indexes on those columns. The goal is to speed up query execution times, especially for large datasets.

## High-Usage Columns Identified

1. **User Table**:
   - `email`: The email column is frequently used for user lookups during login, registration, and account management. It is also unique, so indexing this column will speed up searches.

2. **Booking Table**:
   - `user_id`: The `user_id` column is often used to retrieve bookings made by a particular user. Indexing it will optimize these queries.
   - `property_id`: This column is frequently used in queries to retrieve all bookings for a specific property. Indexing it speeds up property-based searches.
   - `start_date`: The `start_date` column is used in queries to filter or sort bookings by their start dates. Indexing this will optimize date-based filtering and sorting.

3. **Property Table**:
   - `host_id`: The `host_id` column is used to find all properties belonging to a specific host. Indexing it will optimize host-based property retrieval.
   - `location`: The `location` column is frequently used to filter properties based on geographical location. Indexing it will help with location-based filtering.

## SQL Indexes Created

The following indexes have been created to optimize performance:

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


.