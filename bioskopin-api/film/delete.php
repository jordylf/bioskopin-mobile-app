<?php
require_once '../config/database.php';

// Mendapatkan koneksi database
$db = new Database();
$conn = $db->getConnection();

// Ambil ID dari query string (untuk metode GET atau DELETE)
$id = $_GET['id'] ?? null;

if ($id && is_numeric($id)) {
    // Escape ID untuk menghindari SQL injection
    $id = mysqli_real_escape_string($conn, $id);

    // Mencari film berdasarkan ID
    $query = "SELECT * FROM film WHERE id = $id";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) > 0) {
        // Ambil data film untuk mendapatkan nama gambar
        $film = mysqli_fetch_assoc($result);

        // Path gambar yang akan dihapus
        $target_dir = __DIR__ . "/../uploads/";
        $imagePath = $target_dir . $film['image'];

        // Hapus file gambar jika ada
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        // Menghapus film dari database
        $query = "DELETE FROM film WHERE id = $id";
        if (mysqli_query($conn, $query)) {
            $response = array(
                'status' => 'success',
                'message' => 'Film deleted successfully'
            );

            header('Content-Type: application/json');

            http_response_code(200);
        } else {
            $response = array(
                'status' => 'error',
                'message' => 'Failed to delete film from database'
            );

            header('Content-Type: application/json');

            http_response_code(500);
        }
    } else {
        $response = array(
            'status' => 'error',
            'message' => 'Film not found'
        );

        header('Content-Type: application/json');

        http_response_code(404);
    }
} else {
    $response = array(
        'status' => 'error',
        'message' => 'Invalid or missing ID'
    );

    header('Content-Type: application/json');

    http_response_code(400); // Bad Request
}

// Menampilkan response dalam format JSON
echo json_encode($response);
