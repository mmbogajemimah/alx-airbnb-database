# Index Performance Analysis

## Identifying High-Usage Columns

## User Table

. email (used in WHERE clauses)
. id (used in JOIN clauses)


## Booking Table

## High-usage columns:

. user_id (used in WHERE and JOIN clauses)

. property_id (used in WHERE and JOIN clauses)

. booking_date (used in ORDER BY clauses)

## Property Table

##  High-usage columns:

. location (used in WHERE clauses)

. id (used in JOIN clauses)

## Creating Indexes

-- User Table Indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_id ON User(id);

-- Booking Table Indexes
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_booking_date ON Booking(booking_date);

-- Property Table Indexes
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_id ON Property(id);

## Measuring Query Performance

### Before Adding Indexes

. Use the following commands to measure query performance before adding indexes

EXPLAIN ANALYZE SELECT * FROM User WHERE email = 'example@example.com';

EXPLAIN ANALYZE SELECT * FROM Booking WHERE user_id = 1;

### After Adding Indexes

. Use the following commands to measure query performance after adding indexes:

EXPLAIN ANALYZE SELECT * FROM User WHERE email = 'example@example.com';

EXPLAIN ANALYZE SELECT * FROM Booking WHERE user_id = 1;

EXPLAIN ANALYZE SELECT * FROM Property WHERE location = 'New York';

### Compare the query performance results before and after adding indexes to evaluate the effectiveness of the indexes.

.EXPLAIN ANALYZE SELECT * FROM Property WHERE location = 'New York';