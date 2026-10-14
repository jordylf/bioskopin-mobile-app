<?php
require_once '../config/database.php';
require_once '../jwt/verify.php';

// Ambil header Authorization
$headers = apache_request_headers();
$authHeader = $headers['Authorization'] ?? null;

if ($authHeader) {
    // Mengambil token dari header Authorization
    $jwt = str_replace("Bearer ", "", $authHeader);

    // Memverifikasi JWT
    $userData = verifyJWT($jwt);

    if ($userData) {
        // Jika token valid, lanjutkan untuk mengambil data booking
        $db = new Database();
        $conn = $db->getConnection();
        $query = "SELECT booking.id, film.title, booking.ticket_quantity, booking.status, booking.created_at FROM booking 
            JOIN film ON booking.film_id = film.id 
            JOIN users ON booking.user_id = users.id WHERE booking.user_id = " . $userData['userId'] . " ORDER BY created_at DESC";
        $result = mysqli_query($conn, $query);
        $bookings = [];

        while ($row = mysqli_fetch_assoc($result)) {
            $bookings[] = $row;
        }

        // Mengirimkan data booking dalam format JSON
        $response = array(
            'status' => 'success',
            'data' => $bookings
        );

        header('Content-Type: application/json');

        http_response_code(200);

        echo json_encode($response);
    } else {
        // Jika token tidak valid atau kadaluarsa
        $response = array(
            'status' => 'error',
            'message' => 'Invalid or expired token'
        );

        header('Content-Type: application/json');

        http_response_code(401);  // Unauthorized

        echo json_encode($response);
    }
} else {
    // Jika tidak ada header Authorization
    $response = array(
        'status' => 'error',
        'message' => 'Token missing'
    );
    header('Content-Type: application/json');

    http_response_code(401);  // Unauthorized

    echo json_encode($response);
}
