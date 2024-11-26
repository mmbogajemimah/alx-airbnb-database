

---

### **Entities and Attributes**

1. **User**
   - **Primary Key**: `user_id` (UUID, Indexed)
   - Attributes:
     - `first_name`: VARCHAR, NOT NULL
     - `last_name`: VARCHAR, NOT NULL
     - `email`: UNIQUE, NOT NULL
     - `password_hash`: VARCHAR, NOT NULL
     - `phone_number`: VARCHAR, NULL
     - `role`: ENUM (`guest`, `host`, `admin`), NOT NULL
     - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

2. **Property**
   - **Primary Key**: `property_id` (UUID, Indexed)
   - Foreign Key:
     - `host_id` references `User(user_id)`
   - Attributes:
     - `name`: VARCHAR, NOT NULL
     - `description`: TEXT, NOT NULL
     - `location`: VARCHAR, NOT NULL
     - `pricepernight`: DECIMAL, NOT NULL
     - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
     - `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

3. **Booking**
   - **Primary Key**: `booking_id` (UUID, Indexed)
   - Foreign Keys:
     - `property_id` references `Property(property_id)`
     - `user_id` references `User(user_id)`
   - Attributes:
     - `start_date`: DATE, NOT NULL
     - `end_date`: DATE, NOT NULL
     - `total_price`: DECIMAL, NOT NULL
     - `status`: ENUM (`pending`, `confirmed`, `canceled`), NOT NULL
     - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

4. **Payment**
   - **Primary Key**: `payment_id` (UUID, Indexed)
   - Foreign Key:
     - `booking_id` references `Booking(booking_id)`
   - Attributes:
     - `amount`: DECIMAL, NOT NULL
     - `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
     - `payment_method`: ENUM (`credit_card`, `paypal`, `stripe`), NOT NULL

5. **Review**
   - **Primary Key**: `review_id` (UUID, Indexed)
   - Foreign Keys:
     - `property_id` references `Property(property_id)`
     - `user_id` references `User(user_id)`
   - Attributes:
     - `rating`: INTEGER, CHECK (rating >= 1 AND rating <= 5), NOT NULL
     - `comment`: TEXT, NOT NULL
     - `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

6. **Message**
   - **Primary Key**: `message_id` (UUID, Indexed)
   - Foreign Keys:
     - `sender_id` references `User(user_id)`
     - `recipient_id` references `User(user_id)`
   - Attributes:
     - `message_body`: TEXT, NOT NULL
     - `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

### **Relationships**
1. **User and Property**
   - One User (host) can have multiple Properties.
   - One Property belongs to one User (host).

2. **User and Booking**
   - One User (guest) can have multiple Bookings.
   - One Booking belongs to one User.

3. **Property and Booking**
   - One Property can have multiple Bookings.
   - One Booking is associated with one Property.

4. **Booking and Payment**
   - One Booking can have one or more Payments.
   - One Payment is linked to one Booking.

5. **Property and Review**
   - One Property can have multiple Reviews.
   - One Review belongs to one Property.

6. **User and Review**
   - One User (guest) can write multiple Reviews.
   - One Review belongs to one User.

7. **User and Message**
   - One User can send or receive multiple Messages.
   - Each Message has a sender and a recipient.

---

### ER Diagram (Key Elements)
You can use a tool like **Draw.io**, **Lucidchart**, or **dbdiagram.io** to represent this visually. Here's how the entities and relationships should appear:

#### **Nodes (Entities)**:
- **User**
- **Property**
- **Booking**
- **Payment**
- **Review**
- **Message**

#### **Edges (Relationships)**:
- `User (user_id)` → `Property (host_id)`
- `User (user_id)` → `Booking (user_id)`
- `Property (property_id)` → `Booking (property_id)`
- `Booking (booking_id)` → `Payment (booking_id)`
- `Property (property_id)` → `Review (property_id)`
- `User (user_id)` → `Review (user_id)`
- `User (user_id)` → `Message (sender_id, recipient_id)`