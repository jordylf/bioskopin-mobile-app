<?php
require_once '../config/database.php';
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->fullname) && !empty($data->email) && !empty($data->password)) {
    $db = new Database();
    $conn = $db->getConnection();
    $fullname = mysqli_real_escape_string($conn, $data->fullname);
    $email = mysqli_real_escape_string($conn, $data->email);
    $password = password_hash($data->password, PASSWORD_BCRYPT);

    $check_query = "SELECT * FROM users WHERE email = '$email'";
    $check_result = mysqli_query($conn, $check_query);

    if (mysqli_num_rows($check_result) > 0) {
        $response = array(
            'status' => 'error',
            'message' => 'Email already exists'
        );

        header('Content-Type: application/json');

        http_response_code(409);

        echo json_encode($response);
    } else {
        $query = "INSERT INTO users (fullname, email, password) VALUES ('$fullname', '$email', '$password')";

        if (mysqli_query($conn, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'User registered successfully'
            );

            header('Content-Type: application/json');

            http_response_code(201);

            echo json_encode($response);
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Unable to register user'
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
