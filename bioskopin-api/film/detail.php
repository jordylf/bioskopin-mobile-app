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
        // Memastikan id ada dalam query string
        if (isset($_GET['id']) && is_numeric($_GET['id'])) {
            $id = $_GET['id'];  // Mendapatkan id film dari query string
            $db = new Database();
            $conn = $db->getConnection();

            $query = "SELECT id, title, genre, duration, description, image, showtime FROM film WHERE id = $id";
            $result = mysqli_query($conn, $query);

            // Mengecek apakah data ditemukan
            if ($result->num_rows > 0) {
                $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';

                $host = $_SERVER['HTTP_HOST'];

                $baseUrl = "$protocol://$host/bioskopin-api/uploads/";

                // Ambil hasil sebagai objek
                $row = $result->fetch_assoc();

                // Menambahkan URL lengkap untuk gambar
                $row['image'] = $baseUrl . $row['image'];

                // Membuat objek untuk data film
                $movie = (object) $row;

                // Mengirimkan data film dalam format JSON
                $response = array(
                    'status' => 'success',
                    'data' => $movie // Kirim sebagai objek tunggal
                );

                header('Content-Type: application/json');

                http_response_code(200);

                echo json_encode($response);
            } else {
                // Jika film tidak ditemukan
                $response = array(
                    'status' => 'error',
                    'message' => 'Film not found'
                );

                header('Content-Type: application/json');

                http_response_code(404);

                echo json_encode($response);
            }
        } else {
            // Jika id tidak valid atau tidak ada
            $response = array(
                'status' => 'error',
                'message' => 'Invalid or missing film ID'
            );

            header('Content-Type: application/json');

            http_response_code(400);  // Bad Request

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
