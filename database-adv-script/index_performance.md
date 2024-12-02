-- Performance Analysis Queries

-- Before Index: Analyze Query Performance
EXPLAIN SELECT * FROM Booking 
WHERE user_id = 'some_user_id' AND status = 'confirmed';

-- After Index: Performance Check
EXPLAIN SELECT * FROM Booking 
WHERE user_id = 'some_user_id' AND status = 'confirmed';

-- Additional Performance Monitoring
-- Use MySQL's built-in performance schema or monitoring tools
-- to track index usage and query performance over time