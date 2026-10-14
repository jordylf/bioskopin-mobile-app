<?php
require_once '../config/database.php';
$db = new Database();
$conn = $db->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->status)) {
    $id = $_GET['id'];
    $status = mysqli_real_escape_string($conn, $data->status);

    $query = "UPDATE booking SET status = '$status' WHERE id = $id";
    if (mysqli_query($conn, $query)) {
        $response = array(
            'status' => 'success',
            'message' => 'Booking status updated successfully'
        );

        header('Content-Type: application/json');

        http_response_code(200);

        echo json_encode($response);
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Unable to update booking status'
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
