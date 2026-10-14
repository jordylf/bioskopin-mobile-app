<?php
require '../config/database.php';
$db = new Database();
$conn = $db->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id) && !empty($data->title) && !empty($data->description)) {
    $id = mysqli_real_escape_string($conn, $data->id);
    $title = mysqli_real_escape_string($conn, $data->title);
    $description = mysqli_real_escape_string($conn, $data->description);

    $query = "SELECT * FROM film WHERE id = $id";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) > 0) {
        $query = "UPDATE film SET title = '$title', description = '$description' WHERE id = $id";
        if (mysqli_query($conn, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Film updated successfully'
            );

            header('Content-Type: application/json');

            http_response_code(200);

            echo json_encode($response);
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Failed to update film'
            );

            header('Content-Type: application/json');

            http_response_code(500);

            echo json_encode($response);
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Film not found'
        );

        header('Content-Type: application/json');

        http_response_code(404);

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
