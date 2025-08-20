<?php
include './connection.php';

header('Content-Type: application/json');

// Validate required fields
if (
    isset($_POST['name']) &&
    isset($_POST['contact']) &&
    isset($_POST['email']) &&
    isset($_POST['gender']) &&
    isset($_POST['date_of_birth']) &&
    isset($_POST['address']) &&
    isset($_POST['profession']) &&
    isset($_POST['reason'])
) {
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $contact = mysqli_real_escape_string($conn, $_POST['contact']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    $dob = mysqli_real_escape_string($conn, $_POST['date_of_birth']);
    $address = mysqli_real_escape_string($conn, $_POST['address']);
    $profession = mysqli_real_escape_string($conn, $_POST['profession']);
    $reason = mysqli_real_escape_string($conn, $_POST['reason']);

    $sql = "INSERT INTO volunteer (name, contact, email, gender, date_of_birth, address, profession, reason)
            VALUES ('$name', '$contact', '$email', '$gender', '$dob', '$address', '$profession', '$reason')";

    if (mysqli_query($conn, $sql)) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => mysqli_error($conn)]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Missing required fields.']);
}
?>