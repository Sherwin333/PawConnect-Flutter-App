<?php
header('Content-Type: application/json');
include './connection.php';

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

$response = [];

if ($email != '' && $password != '') {
    $sql = "SELECT id, name, email FROM user WHERE email = '$email' AND password = '$password' AND status = 1";
    $res = mysqli_query($conn, $sql);

    if (mysqli_num_rows($res) > 0) {
        $row = mysqli_fetch_assoc($res);
        $response['success'] = true;
        $response['id'] = $row['id'];
        $response['name'] = $row['name'];
        $response['email'] = $row['email'];
        $response['message'] = "Login successful!";
    } else {
        $response['success'] = false;
        $response['message'] = "Invalid credentials!";
    }
} else {
    $response['success'] = false;
    $response['message'] = "Missing email or password.";
}

echo json_encode($response);
?>
