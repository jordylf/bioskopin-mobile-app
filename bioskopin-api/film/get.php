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
        // Jika token valid, lanjutkan untuk mengambil data film
        $db = new Database();
        $conn = $db->getConnection();
        $query = "SELECT id, title, image, description FROM film ORDER BY created_at DESC";
        $result = mysqli_query($conn, $query);
        $movies = [];

        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';

        $host = $_SERVER['HTTP_HOST'];

        $baseUrl = "$protocol://$host/bioskopin-api/uploads/";

        while ($row = mysqli_fetch_assoc($result)) {
            $row['image'] = $baseUrl . $row['image'];
            $movies[] = $row;
        }

        // Mengirimkan data film dalam format JSON
        $response = array(
            'status' => 'success',
            'data' => $movies
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
