<?php
include './connection.php';

$query = "SELECT * FROM adopt WHERE status = 1";
$result = mysqli_query($conn, $query);

$pets = [];
while ($row = mysqli_fetch_assoc($result)) {
    // Extract just the image filename
    $row['image'] = basename($row['image']);
    $pets[] = $row;
}

echo json_encode($pets);
?>
