<?php
include './connection.php';

$response = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $uid = $_POST['uid'];
    $description = $_POST['description'];

    if (isset($_FILES['image'])) {
        $image = $_FILES['image']['name'];
        $tempPath = $_FILES['image']['tmp_name'];
        $uploadPath = "../starter/rescue/" . $image;

        if (move_uploaded_file($tempPath, $uploadPath)) {
            $query = "INSERT INTO rescue (description, image, uid, status) VALUES ('$description', 'starter/rescue/$image', '$uid', 0)";
            if (mysqli_query($conn, $query)) {
                $response['success'] = true;
                $response['message'] = 'Rescue request submitted!';
            } else {
                $response['success'] = false;
                $response['message'] = 'Database error!';
            }
        } else {
            $response['success'] = false;
            $response['message'] = 'Failed to upload image!';
        }
    } else {
        $response['success'] = false;
        $response['message'] = 'No image found!';
    }
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid Request!';
}

echo json_encode($response);
?>