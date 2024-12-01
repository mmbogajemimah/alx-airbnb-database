-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT * 
FROM Bookings 
INNER JOIN Users ON Bookings.user_id = Users.id;


-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.location AS property_location,
    p.pricepernight,
    p.created_at AS property_created_at,
    p.updated_at AS property_updated_at,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_created_at
FROM 
    Property p
LEFT JOIN 
    Review r
ON 
    p.property_id = r.property_id
ORDER BY 
    p.property_id, r.created_at;



-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT * 
FROM Users 
FULL OUTER JOIN Bookings ON Users.id = Bookings.user_id
