<?php
require '../config/database.php';
$db = new Database();
$conn = $db->getConnection();

if (isset($_FILES['image']) && !empty($_POST['title']) && !empty($_POST['description'])) {
    $title = mysqli_real_escape_string($conn, $_POST['title']);
    $genre = mysqli_real_escape_string($conn, $_POST['genre']);
    $duration = mysqli_real_escape_string($conn, $_POST['duration']);
    $description = mysqli_real_escape_string($conn, $_POST['description']);
    $image = $_FILES['image']['name'];
    $target_dir = __DIR__ . "/../uploads/";
    $target_file = $target_dir . basename($image);
    $showtime = mysqli_real_escape_string($conn, $_POST['showtime']);

    if (move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
        $query = "INSERT INTO film (title, genre, duration, description, image, showtime) VALUES ('$title', '$genre', '$duration', '$description', '$image', '$showtime')";
        if (mysqli_query($conn, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Film added successfully'
            );

            header('Content-Type: application/json');

            http_response_code(201);

            echo json_encode($response);
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Failed to add film'
            );

            header('Content-Type: application/json');

            http_response_code(500);

            echo json_encode($response);
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Failed to upload image'
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
