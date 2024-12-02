-- -- Creating index on the user_id column in the Booking table for faster lookups during joins
-- CREATE INDEX idx_user_id ON Booking(user_id);

-- -- Creating index on the property_id column in the Booking table for faster lookups during joins
-- CREATE INDEX idx_property_id ON Booking(property_id);

-- -- Creating index on the start_date column in the Booking table for faster date range queries
-- CREATE INDEX idx_start_date ON Booking(start_date);

-- -- Creating index on the end_date column in the Booking table for faster date range queries
-- CREATE INDEX idx_end_date ON Booking(end_date);

-- -- Creating index on the user_id column in the User table for faster lookups during joins and queries
-- CREATE INDEX idx_user_id_user ON User(user_id);

-- -- Creating index on the email column in the User table for faster searching of users by email
-- CREATE INDEX idx_email ON User(email);

-- -- Creating index on the rating column in the Property table for faster filtering by ratings
-- CREATE INDEX idx_rating ON Property(rating);

-- -- Creating index on the location column in the Property table for faster location-based filtering
-- CREATE INDEX idx_location ON Property(location);


-- Step 1: Before Adding Indexes (EXPLAIN ANALYZE for performance measurement)

-- Query performance before adding index on user_id in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE user_id = 'some-uuid';

-- Query performance before adding index on property_id in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE property_id = 'some-uuid';

-- Query performance before adding index on start_date in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31';

-- Query performance before adding index on end_date in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE end_date BETWEEN '2022-01-01' AND '2022-12-31';

-- Query performance before adding index on user_id in User table
EXPLAIN ANALYZE
SELECT * FROM User
WHERE user_id = 'some-uuid';

-- Query performance before adding index on email in User table
EXPLAIN ANALYZE
SELECT * FROM User
WHERE email = 'user@example.com';

-- Query performance before adding index on rating in Property table
EXPLAIN ANALYZE
SELECT * FROM Property
WHERE rating > 4.5;

-- Query performance before adding index on location in Property table
EXPLAIN ANALYZE
SELECT * FROM Property
WHERE location = 'New York';

-- Step 2: Creating Indexes for High-Usage Columns

-- Index on the user_id column in the Booking table for faster joins
CREATE INDEX idx_user_id_booking ON Booking(user_id);

-- Index on the property_id column in the Booking table for faster joins
CREATE INDEX idx_property_id_booking ON Booking(property_id);

-- Index on the start_date column in the Booking table for faster date range queries
CREATE INDEX idx_start_date_booking ON Booking(start_date);

-- Index on the end_date column in the Booking table for faster date range queries
CREATE INDEX idx_end_date_booking ON Booking(end_date);

-- Index on the user_id column in the User table for faster lookups
CREATE INDEX idx_user_id_user ON User(user_id);

-- Index on the email column in the User table for faster user searches
CREATE INDEX idx_email_user ON User(email);

-- Index on the rating column in the Property table for faster filtering
CREATE INDEX idx_rating_property ON Property(rating);

-- Index on the location column in the Property table for faster location-based filtering
CREATE INDEX idx_location_property ON Property(location);

-- Step 3: After Adding Indexes (EXPLAIN ANALYZE for performance measurement)

-- Query performance after adding index on user_id in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE user_id = 'some-uuid';

-- Query performance after adding index on property_id in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE property_id = 'some-uuid';

-- Query performance after adding index on start_date in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2022-01-01' AND '2022-12-31';

-- Query performance after adding index on end_date in Booking table
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE end_date BETWEEN '2022-01-01' AND '2022-12-31';

-- Que