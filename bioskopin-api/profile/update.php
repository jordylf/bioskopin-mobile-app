<?php
require_once '../config/database.php';
require_once '../jwt/verify.php';  // Memuat fungsi untuk memverifikasi JWT

// Ambil header Authorization
$headers = apache_request_headers();
$authHeader = $headers['Authorization'] ?? null;

if ($authHeader) {
    // Mengambil token dari header Authorization
    $jwt = str_replace("Bearer ", "", $authHeader);

    // Memverifikasi JWT
    $userData = verifyJWT($jwt);

    // Jika token valid
    if ($userData) {
        // Parse input data dari body request
        $data = json_decode(file_get_contents("php://input"));

        if (!empty($data->fullname) && !empty($data->email)) {
            $db = new Database();
            $conn = $db->getConnection();

            $id = $userData['userId'];
            $fullname = mysqli_real_escape_string($conn, $data->fullname);
            $email = mysqli_real_escape_string($conn, $data->email);

            $checkEmailQuery = "SELECT * FROM users WHERE email = '$email' AND id != $id";
            $checkEmailResult = mysqli_query($conn, $checkEmailQuery);

            if (mysqli_num_rows($checkEmailResult) > 0) {
                $response = array(
                    'status' => 'error',
                    'message' => 'Email already exists'
                );

                header('Content-Type: application/json');

                http_response_code(409);

                echo json_encode($response);
            } else {

                $query = "UPDATE users SET fullname = '$fullname', email = '$email' WHERE id = $id";
                if (mysqli_query($conn, $query)) {
                    $response = array(
                        'status' => 'success',
                        'message' => 'Profile updated successfully'
                    );

                    header('Content-Type: application/json');

                    http_response_code(200);

                    echo json_encode($response);
                } else {
                    $response = array(
                        'status' => 'error',
                        'message' => 'Failed to update profile'
                    );

                    header('Content-Type: application/json');

                    http_response_code(500);

                    echo json_encode($response);
                }
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
    http_response_code(401);  // Unauthorized
    echo json_encode($response);
}
