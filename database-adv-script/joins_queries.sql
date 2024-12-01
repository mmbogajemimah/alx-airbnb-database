-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT * 
FROM Bookings 
INNER JOIN Users ON Bookings.user_id = Users.id;


-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT *
FROM Property
LEFT JOIN Reviews ON Property.id = Reviews.property_id;



-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT * 
FROM Users 
FULL OUTER JOIN Bookings ON Users.id = Bookings.user_id
