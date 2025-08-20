<?php
include './connection.php';

header('Content-Type: application/json');

$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$contact = $_POST['contact'] ?? '';
$password = $_POST['password'] ?? '';

// Simple validation
if (empty($name) || empty($email) || empty($contact) || empty($password)) {
    echo json_encode([
        'success' => false,
        'message' => 'Please fill all fields.'
    ]);
    exit;
}

// Check if email already exists
$check = mysqli_query($conn, "SELECT id FROM user WHERE email = '$email'");
if (mysqli_num_rows($check) > 0) {
    echo json_encode([
        'success' => false,
        'message' => 'Email already registered.'
    ]);
    exit;
}

// Insert user
$query = "INSERT INTO user (name, email, contact, password, status, token) 
          VALUES ('$name', '$email', '$contact', '$password', 1, '')";

if (mysqli_query($conn, $query)) {
    echo json_encode([
        'success' => true,
        'message' => 'User registered successfully.'
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Registration failed. Please try again.'
    ]);
}
?>