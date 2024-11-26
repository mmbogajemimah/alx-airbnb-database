### **Normalization to Third Normal Form (3NF)**

To ensure the database adheres to 3NF, we review the schema for potential redundancies and normalization issues. A database is in 3NF if:
1. It is in 2NF (all non-key attributes depend on the entire primary key).
2. No transitive dependency exists (non-key attributes do not depend on other non-key attributes).

Below are the steps and explanations for achieving 3NF:

---

### **Step 1: Analyze the Schema for Redundancies**
#### **User Table**
- Attributes:
  - `user_id` (Primary Key)
  - `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`
- No redundancy or dependency violations detected.

#### **Property Table**
- Attributes:
  - `property_id` (Primary Key)
  - `host_id` (Foreign Key referencing `User.user_id`)
  - `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`
- No redundancy or dependency violations detected.

#### **Booking Table**
- Attributes:
  - `booking_id` (Primary Key)
  - `property_id` (Foreign Key referencing `Property.property_id`)
  - `user_id` (Foreign Key referencing `User.user_id`)
  - `start_date`, `end_date`, `total_price`, `status`, `created_at`
- No redundancy or dependency violations detected.

#### **Payment Table**
- Attributes:
  - `payment_id` (Primary Key)
  - `booking_id` (Foreign Key referencing `Booking.booking_id`)
  - `amount`, `payment_date`, `payment_method`
- No redundancy or dependency violations detected.

#### **Review Table**
- Attributes:
  - `review_id` (Primary Key)
  - `property_id` (Foreign Key referencing `Property.property_id`)
  - `user_id` (Foreign Key referencing `User.user_id`)
  - `rating`, `comment`, `created_at`
- No redundancy or dependency violations detected.

#### **Message Table**
- Attributes:
  - `message_id` (Primary Key)
  - `sender_id` (Foreign Key referencing `User.user_id`)
  - `recipient_id` (Foreign Key referencing `User.user_id`)
  - `message_body`, `sent_at`
- No redundancy or dependency violations detected.

---

### **Step 2: Apply 3NF Principles**
No transitive dependencies or partial dependencies were identified in the schema. All non-key attributes in each table depend on the entire primary key or foreign key, with no indirect dependencies. Thus, the schema already adheres to 3NF.

---

### **Step 3: Document Normalization Process**
#### **Original Schema**
The schema is already normalized:
1. No attributes are repeated inappropriately.
2. Each non-key attribute depends on the primary key or foreign key, directly and entirely.
3. There are no transitive dependencies between non-key attributes.

#### **Modified Schema**
Since the original schema was already in 3NF, no modifications were required.

---

### **Conclusion**
The database schema adheres to third normal form (3NF). All attributes are atomic, fully functionally dependent on the primary key or foreign key, and there are no transitive dependencies. The design ensures data integrity and minimizes redundancy.

---
