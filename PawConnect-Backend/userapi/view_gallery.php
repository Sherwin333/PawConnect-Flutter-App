<?php
include './connection.php';

$query = "SELECT * FROM gallery WHERE status = 1 ORDER BY id DESC";
$result = mysqli_query($conn, $query);

$gallery = [];
while ($row = mysqli_fetch_assoc($result)) {
    $gallery[] = $row;
}

echo json_encode($gallery);
?>
