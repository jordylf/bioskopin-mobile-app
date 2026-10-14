<?php
require_once '../vendor/autoload.php';  // Pastikan untuk memuat autoload Composer
use \Firebase\JWT\JWT;

function createJWT($userData)
{
    $key = "secret_key";  // Ganti dengan kunci rahasia yang aman
    $issuedAt = time();
    $issuer = "http://localhost/bioskopin-api";  // Ganti dengan domain Anda jika diperlukan

    // Data yang akan dimasukkan ke dalam payload JWT
    $payload = array(
        "iat" => $issuedAt,
        "iss" => $issuer,
        "userId" => $userData['id'],
    );

    // Membuat JWT
    return JWT::encode($payload, $key, 'HS256');
}
