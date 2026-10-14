<?php
require '../config/database.php';
$db = new Database();
$conn = $db->getConnection();


if (!empty($_GET['id'])) {
    $id = mysqli_real_escape_string($conn, $_GET['id']);

    $query = "DELETE FROM booking WHERE id = $id";
    if (mysqli_query($conn, $query)) {
        $response = array(
            'status' => 'success',
            'message' => 'Booking deleted successfully'
        );

        header('Content-Type: application/json');

        http_response_code(200);

        echo json_encode($response);
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Failed to delete booking'
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
