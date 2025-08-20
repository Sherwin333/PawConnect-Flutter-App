<?php
session_start();
include './connection.php';

if (!isset($_SESSION['login'])) {
  header("Location: login.php");
}

include 'link.php';
include 'sidebar.php';
include 'header.php';

if (isset($_POST['submit'])) {
  $path = "starter/post/" . $_FILES["file"]["name"];
  $title = $_POST['title'];
  $description = $_POST['description'];
  $type = "Image";

  if (strstr($_FILES["file"]["type"], "image/")) {
    if (move_uploaded_file($_FILES["file"]["tmp_name"], "post/" . $_FILES["file"]["name"])) {
      if (mysqli_query($conn, "INSERT INTO post(user_id, title, description, type, path, status) VALUES('1', '$title', '$description', '$type', '$path', true)")) {
        echo "<script>alert('Post added successfully..!');</script>";
      } else {
        echo "<script>alert('Unable to add post..!');</script>";
      }
    } else {
      echo "<script>alert('Unable to upload image on server..!');</script>";
    }
  } else {
    echo "<script>alert('Invalid file format. Only image files allowed..!');</script>";
  }
}
?>

<style>
  .custom-card {
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
  }

  .form-label {
    font-weight: 600;
  }

  .input-style {
    border-radius: 8px;
  }
</style>

<div class="main-content" style="background-color: #f5f7fa; min-height: 100vh;">
  <div class="container-fluid content-top-gap">

    <nav aria-label="breadcrumb">
      <ol class="breadcrumb my-breadcrumb bg-white px-3 py-2 rounded shadow-sm">
        <li class="breadcrumb-item"><a href="index.php">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Add Work</li>
      </ol>
    </nav>

    <div class="card shadow-sm border-0 mb-4">
      <div class="card-body d-flex justify-content-between align-items-center">
        <h4 class="mb-0 text-primary">📢 Add New Post</h4>
      </div>
    </div>

    <div class="card custom-card p-4 mb-5">
      <div class="row">
        <div class="col-lg-6">
          <form method="post" enctype="multipart/form-data" class="row g-3">

            <div class="col-12">
              <label class="form-label">Title</label>
              <input type="text" name="title" class="form-control input-style" required>
            </div>

            <div class="col-12 mt-3">
              <label class="form-label">Description</label>
              <textarea name="description" class="form-control input-style" rows="4" required></textarea>
            </div>

            <div class="col-12 mt-3">
              <label class="form-label">Upload Image</label>
              <input type="file" name="file" accept="image/*" class="form-control input-style" required>
            </div>

            <div class="col-12 mt-4">
              <button type="submit" name="submit" class="btn btn-primary w-100">Submit Post</button>
            </div>

          </form>
        </div>

        <div class="col-lg-6 text-center mt-4 mt-lg-0">
          <img src="image/work.jpg" alt="Our Work" class="img-fluid rounded" style="max-height: 350px;">
        </div>
      </div>
    </div>

  </div>
</div>

<?php include 'footer.php'; ?>
