-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT 
    Property.property_id
    Property.name
    Property.description
    Property.location
    Property.pricepernight
FROM Property
WHERE
    Property.property_id IN (
        SELECT 
            Review.property_id
        FROM
            Review
        GROUP BY
            Review.property_id
        HAVING
            AVG(Review.rating) > 4.0
    );


-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT
    User.user_id,
    User.name,
    User.email
FROM
    User
WHERE
    (SELECT COUNT(*)
    FROM Booking
    WHERE Booking.user_id = User.user_id) > 3;