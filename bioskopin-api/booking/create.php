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

        $data = json_decode(file_get_contents("php://input"));

        if (!empty($data->film_id) && !empty($data->quantity)) {
            $user_id = $userData['userId'];

            $film_id = mysqli_real_escape_string($conn, $data->film_id);
            $quantity = mysqli_real_escape_string($conn, $data->quantity);

            $query = "INSERT INTO booking (user_id, film_id, ticket_quantity, status) VALUES ('$user_id', '$film_id', '$quantity', 'pending')";

            if (mysqli_query($conn, $query)) {
                $response = array(
                    'status' => 'success',
                    'message' => 'Booking created successfully'
                );

                header('Content-Type: application/json');

                http_response_code(200);

                echo json_encode($response);
            } else {
                $response = array(
                    'status' => 'error',
                    'message' => 'Unable to create booking'
                );

                header('Content-Type: application/json');

                http_response_code(500);

                echo json_encode($response);
            }
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Incomplete data'
            );

            header('Content-Type: application/json');

            http_response_code(400);

            echo json_encode($response);
        }
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
