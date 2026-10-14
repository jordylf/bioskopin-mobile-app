<?php
require_once '../config/database.php';
require_once '../jwt/create.php';

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->email) && !empty($data->password)) {
    $db = new Database();
    $conn = $db->getConnection();
    $email = mysqli_real_escape_string($conn, $data->email);
    $query = "SELECT * FROM users WHERE email = '$email'";
    $result = mysqli_query($conn, $query);
    $user = mysqli_fetch_assoc($result);

    if ($user && password_verify($data->password, $user['password'])) {
        $jwt = createJWT($user);

        $response = array(
            'status' => 'success',
            'message' => 'Login successful',
            'token' => $jwt,
            'data' => array(
                'fullname' => $user['fullname'],
                'email' => $user['email'],
            )
        );

        header('Content-Type: application/json');

        http_response_code(200);

        echo json_encode($response);
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Invalid email or password'
        );

        header('Content-Type: application/json');

        http_response_code(401);

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
