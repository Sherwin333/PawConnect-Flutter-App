<?php
include './connection.php';

$response = ['success' => false];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userid = $_POST['userid'] ?? '';
    $amount = $_POST['amount'] ?? '';
    $description = $_POST['description'] ?? '';

    if (!empty($userid) && !empty($amount)) {
        $stmt = $conn->prepare("INSERT INTO donation (userid, amount, description, status) VALUES (?, ?, ?, 1)");
        $stmt->bind_param("iis", $userid, $amount, $description);

        if ($stmt->execute()) {
            $response['success'] = true;
        }

        $stmt->close();
    }
}

echo json_encode($response);
?>