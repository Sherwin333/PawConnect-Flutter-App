<?php
include './connection.php';

// Fetch all posts with status = 1 (work-related)
$query = "SELECT * FROM post WHERE status = 1 ORDER BY id DESC";
$result = mysqli_query($conn, $query);

$works = [];
while ($row = mysqli_fetch_assoc($result)) {
    $works[] = $row;
}

echo json_encode($works);
?>
