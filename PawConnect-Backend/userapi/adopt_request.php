<?php
include './connection.php';

$userId = $_POST['user_id'];
$petId = $_POST['pet_id'];

$checkQuery = "SELECT * FROM adopt_request WHERE user_id = '$userId' AND pet_id = '$petId'";
$checkResult = mysqli_query($conn, $checkQuery);

if (mysqli_num_rows($checkResult) > 0) {
    echo json_encode(['success' => false, 'message' => 'You have already requested to adopt this pet.']);
} else {
    $insertQuery = "INSERT INTO adopt_request (user_id, pet_id, status) VALUES ('$userId', '$petId', 'Pending')";
    if (mysqli_query($conn, $insertQuery)) {
        echo json_encode(['success' => true, 'message' => 'Adoption request sent successfully.']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to send adoption request.']);
    }
}
?>
