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
  $path = "starter/gallery/" . $_FILES["file"]["name"];
  $title = $_POST['title'];


  if (move_uploaded_file($_FILES["file"]["tmp_name"], "gallery/" . $_FILES["file"]["name"])) {
    if (mysqli_query($conn, "insert into gallery(title, image, status)values('$title', '$path', true)")) {
      echo "<script>alert('Gallery added successfully..!');</script>";
    } else {
      echo "<script>alert('Unable to add gallery..!');</script>";
    }
  } else {
    echo "<script>alert('Unable to upload file on server..!');</script>";
  }
}


?>

<div class="main-content">
  <div class="container-fluid content-top-gap">

    <nav aria-label="breadcrumb">
      <ol class="breadcrumb my-breadcrumb">
        <li class="breadcrumb-item"><a href="index.php">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Add Gallery</li>
      </ol>
    </nav>

    <div class="cards__heading">
      <h3>Our Gallery</h3>
    </div>

    <div class="card card_border p-4 mb-4 shadow-sm">
      <div class="card-body">
        <div class="row">
          <div class="col-md-6">
            <h4 class="mb-4 text-primary">Add New Gallery Image</h4>
            <form method="post" enctype="multipart/form-data">
              <div class="form-group mb-3">
                <label class="form-label font-weight-bold">Title</label>
                <input type="text" class="form-control" name="title" placeholder="Enter title" required>
              </div>

              <div class="form-group mb-4">
                <label class="form-label font-weight-bold">Select Image</label>
                <input type="file" class="form-control-file" name="file" accept="image/*" required>
              </div>

              <button type="submit" name="submit" class="btn btn-outline-primary btn-block">
                <i class="fa fa-plus"></i> Add to Gallery
              </button>
            </form>
          </div>

          <div class="col-md-6 d-flex align-items-center justify-content-center">
            <img src="image/gallery.jpg" alt="Gallery Preview" class="img-fluid rounded shadow"
              style="max-height: 300px;">
          </div>
        </div>
      </div>
    </div>

  </div>
</div>

<?php
include 'footer.php';
?>