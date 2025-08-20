<?php
header('Content-Type: application/json');
include './connection.php';

$response = [];

$query = "SELECT * FROM vaccine WHERE status = 1 ORDER BY createddate DESC";
$result = mysqli_query($conn, $query);

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $response[] = $row;
    }
    echo json_encode($response);
} else {
    echo json_encode(['error' => 'Failed to fetch vaccine data']);
}
?>
