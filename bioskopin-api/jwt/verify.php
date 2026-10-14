<?php
require_once '../vendor/autoload.php';  // Pastikan untuk memuat autoload Composer
use \Firebase\JWT\JWT;
use Firebase\JWT\Key;

function verifyJWT($jwt)
{
    $key = "secret_key";  // Ganti dengan kunci rahasia yang aman

    try {
        // Decode JWT dan verifikasi token
        $decoded = JWT::decode($jwt, new Key($key, 'HS256'));

        // Jika berhasil, kembalikan data dari payload
        return (array) $decoded;
    } catch (Exception $e) {
        // Jika token tidak valid atau kadaluarsa
        return null;
    }
}
