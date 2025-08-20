<?php
$host = "localhost";
$user = "root";
$pass = "";
$db   = "pawconnect";

$conn = mysqli_connect($host, $user, $pass, $db);

if (!$conn) {
    die(json_encode([
        'success' => false,
        'message' => 'Database connection failed: ' . mysqli_connect_error()
    ]));
}
?>
