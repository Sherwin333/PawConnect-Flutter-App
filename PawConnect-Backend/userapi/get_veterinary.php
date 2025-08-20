<?php
include './connection.php';

$data = array();
$res = mysqli_query($conn, "SELECT * FROM veterinary WHERE status = 1 ORDER BY created_date DESC");

while ($row = mysqli_fetch_assoc($res)) {
    $data[] = $row;
}

header('Content-Type: application/json');
echo json_encode($data);
?>
