INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES 
    ('123e4567-e89b-12d3-a456-426614174000', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '1234567890', 'guest', CURRENT_TIMESTAMP),
    ('123e4567-e89b-12d3-a456-426614174001', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '0987654321', 'host', CURRENT_TIMESTAMP),
    ('123e4567-e89b-12d3-a456-426614174002', 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password_3', NULL, 'admin', CURRENT_TIMESTAMP);


INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES 
    ('223e4567-e89b-12d3-a456-426614174000', '123e4567-e89b-12d3-a456-426614174001', 'Cozy Apartment', 'A beautiful 2-bedroom apartment in the city center.', 'New York, NY', 150.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('223e4567-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174001', 'Beachside Villa', 'Luxurious villa with a stunning ocean view.', 'Malibu, CA', 500.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES 
    ('323e4567-e89b-12d3-a456-426614174000', '223e4567-e89b-12d3-a456-426614174000', '123e4567-e89b-12d3-a456-426614174000', '2024-12-01', '2024-12-05', 600.00, 'confirmed', CURRENT_TIMESTAMP),
    ('323e4567-e89b-12d3-a456-426614174001', '223e4567-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174000', '2024-12-10', '2024-12-15', 2500.00, 'pending', CURRENT_TIMESTAMP);


INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES 
    ('423e4567-e89b-12d3-a456-426614174000', '323e4567-e89b-12d3-a456-426614174000', 600.00, CURRENT_TIMESTAMP, 'credit_card'),
    ('423e4567-e89b-12d3-a456-426614174001', '323e4567-e89b-12d3-a456-426614174001', 2500.00, CURRENT_TIMESTAMP, 'paypal');


INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES 
    ('523e4567-e89b-12d3-a456-426614174000', '223e4567-e89b-12d3-a456-426614174000', '123e4567-e89b-12d3-a456-426614174000', 5, 'Amazing place, very clean and cozy!', CURRENT_TIMESTAMP),
    ('523e4567-e89b-12d3-a456-426614174001', '223e4567-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174000', 4, 'Beautiful villa, but the Wi-Fi was slow.', CURRENT_TIMESTAMP);


INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES 
    ('623e4567-e89b-12d3-a456-426614174000', '123e4567-e89b-12d3-a456-426614174000', '123e4567-e89b-12d3-a456-426614174001', 'Hi, I am interested in booking your property.', CURRENT_TIMESTAMP),
    ('623e4567-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174000', 'Sure, let me know if you have any questions.', CURRENT_TIMESTAMP);
