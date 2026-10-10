CREATE DATABASE IF NOT EXISTS hotel_management;

USE hotel_management;

CREATE TABLE IF NOT EXISTS hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(40) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    room_status VARCHAR(20) NOT NULL DEFAULT 'Available',
    UNIQUE (hotel_id, room_number),
    FOREIGN KEY (hotel_id) REFERENCES hotels (hotel_id),
    CHECK (price_per_night >= 0),
    CHECK (
        room_status IN ('Available', 'Maintenance')
    )
);

CREATE TABLE IF NOT EXISTS guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (guest_id) REFERENCES guests (guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms (room_id),
    CHECK (check_out > check_in),
    CHECK (
        booking_status IN (
            'Confirmed',
            'CheckedIn',
            'CheckedOut',
            'Cancelled'
        )
    )
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Paid',
    FOREIGN KEY (reservation_id) REFERENCES reservations (reservation_id),
    CHECK (amount >= 0),
    CHECK (
        payment_status IN ('Paid', 'Pending', 'Refunded')
    )
);

USE hotel_management;

-- 1. Hotels
INSERT INTO
    hotels (hotel_name, city)
VALUES (
        'Grand Nagpur Hotel',
        'Nagpur'
    ),
    ('Sunrise Suites', 'Pune');

-- 2. Rooms
INSERT INTO
    rooms (
        hotel_id,
        room_number,
        room_type,
        price_per_night,
        room_status
    )
VALUES (
        1,
        '101',
        'Standard',
        2500.00,
        'Available'
    ),
    (
        1,
        '102',
        'Deluxe',
        4000.00,
        'Available'
    ),
    (
        1,
        '103',
        'Suite',
        6500.00,
        'Maintenance'
    ),
    (
        2,
        '201',
        'Standard',
        3000.00,
        'Available'
    ),
    (
        2,
        '202',
        'Deluxe',
        4500.00,
        'Available'
    );

-- 3. Guests
INSERT INTO
    guests (guest_name, email, phone)
VALUES (
        'Amit Sharma',
        'amit@example.com',
        '9876543210'
    ),
    (
        'Priya Patel',
        'priya@example.com',
        '9876543211'
    ),
    (
        'Rahul Verma',
        'rahul@example.com',
        '9876543212'
    );

-- 4. Reservations
INSERT INTO
    reservations (
        guest_id,
        room_id,
        check_in,
        check_out,
        booking_status
    )
VALUES (
        1,
        1,
        '2026-10-12',
        '2026-10-15',
        'Confirmed'
    ),
    (
        2,
        2,
        '2026-10-13',
        '2026-10-16',
        'Confirmed'
    ),
    (
        3,
        4,
        '2026-10-10',
        '2026-10-12',
        'CheckedIn'
    );

-- 5. Payments
INSERT INTO
    payments (
        reservation_id,
        amount,
        payment_date,
        payment_status
    )
VALUES (
        1,
        7500.00,
        '2026-10-10',
        'Paid'
    ),
    (
        2,
        12000.00,
        '2026-10-10',
        'Paid'
    ),
    (
        3,
        3000.00,
        '2026-10-10',
        'Pending'
    );