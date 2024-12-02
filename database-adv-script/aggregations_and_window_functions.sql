-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

SELECT guest_id, COUNT(*) AS total_bookings
FROM Bookings
GROUP BY guest_id;



-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
-- Query using ROW_NUMBER and RANK window functions

SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_number_rank,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank
FROM 
    Properties p
LEFT JOIN 
    Bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    row_number_rank;