USE hotel_management;

-- 1. Reservation report
SELECT r.reservation_id, g.guest_name, h.hotel_name, rm.room_number, rm.room_type, r.check_in, r.check_out, r.booking_status
FROM
    reservations r
    JOIN guests g ON r.guest_id = g.guest_id
    JOIN rooms rm ON r.room_id = rm.room_id
    JOIN hotels h ON rm.hotel_id = h.hotel_id
ORDER BY r.check_in;

-- 2. Total paid revenue
SELECT SUM(amount) AS total_paid_revenue
FROM payments
WHERE
    payment_status = 'Paid';

-- 3. Pending payments
SELECT p.payment_id, g.guest_name, p.amount, p.payment_status
FROM
    payments p
    JOIN reservations r ON p.reservation_id = r.reservation_id
    JOIN guests g ON r.guest_id = g.guest_id
WHERE
    p.payment_status = 'Pending';

-- 4. Room counts by hotel and status
SELECT h.hotel_name, rm.room_status, COUNT(*) AS room_count
FROM hotels h
    JOIN rooms rm ON h.hotel_id = rm.hotel_id
GROUP BY
    h.hotel_name,
    rm.room_status
ORDER BY h.hotel_name, rm.room_status;

-- 5. Find invalid reservation dates
SELECT
    reservation_id,
    check_in,
    check_out
FROM reservations
WHERE
    check_out <= check_in;

-- 6. Calculate expected room charges
SELECT
    r.reservation_id,
    g.guest_name,
    rm.room_number,
    DATEDIFF(r.check_out, r.check_in) AS nights,
    rm.price_per_night,
    DATEDIFF(r.check_out, r.check_in) * rm.price_per_night AS expected_room_charge
FROM
    reservations r
    JOIN guests g ON r.guest_id = g.guest_id
    JOIN rooms rm ON r.room_id = rm.room_id
WHERE
    r.booking_status <> 'Cancelled';