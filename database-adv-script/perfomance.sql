
-- Retrieve all bookings with user, property, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_method,
    pm.payment_status
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pm ON b.booking_id = pm.booking_id
WHERE 
    b.status = 'confirmed' AND b.total_price > 0;
-- Performance Analysis
EXPLAIN SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_method,
    pm.payment_status
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pm ON b.booking_id = pm.booking_id
WHERE 
    b.status = 'confirmed'
ORDER BY 
    b.start_date DESC
LIMIT 1000;

-- Optimized Query with Subquery and Indexing Strategy
WITH ConfirmedBookings AS (
    SELECT 
        booking_id,
        user_id,
        property_id,
        start_date,
        end_date,
        total_price,
        status
    FROM 
        Booking
    WHERE 
        status = 'confirmed'
)

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    
    u.user_id,
    u.first_name,
    u.last_name,
    
    p.property_id,
    p.name AS property_name,
    p.location,
    
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_method
FROM 
    ConfirmedBookings b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pm ON b.booking_id = pm.booking_id
ORDER BY 
    b.start_date DESC
LIMIT 1000;

-- Recommended Indexes for Optimization
CREATE INDEX idx_booking_status_date ON Booking(status, start_date);
CREATE INDEX idx_booking_user_property ON Booking(user_id, property_id);