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
    $name = $_POST['name'];
    $address = $_POST['address'];
    $contact = $_POST['contact'];

    $query = "INSERT INTO veterinary(name, address, contact, status) VALUES('$name', '$address', '$contact', 1)";
    if (mysqli_query($conn, $query)) {
        echo "<script>alert('Veterinary added successfully..!');</script>";
    } else {
        echo "<script>alert('Unable to add veterinary..!');</script>";
    }
}
?>

<div class="main-content" style="background-color: #f5f7fa; min-height: 100vh;">
  <div class="container-fluid content-top-gap">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb my-breadcrumb bg-white px-3 py-2 rounded shadow-sm">
        <li class="breadcrumb-item"><a href="index.php">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Add Veterinary</li>
      </ol>
    </nav>

    <!-- Page Heading -->
    <div class="card shadow-sm border-0 mb-4">
      <div class="card-body d-flex justify-content-between align-items-center">
        <h4 class="mb-0 text-primary">➕ Add Veterinary</h4>
      </div>
    </div>

    <!-- Form Card -->
    <div class="card shadow-sm border-0 p-4">
      <div class="row">
        <div class="col-lg-6">
          <form method="post" class="row g-3" enctype="multipart/form-data">
            
            <div class="col-12 mb-3">
              <label for="name" class="form-label fw-semibold">Doctor Name</label>
              <input type="text" class="form-control input-style" name="name" id="name" required>
            </div>

            <div class="col-12 mb-3">
              <label for="address" class="form-label fw-semibold">Address</label>
              <textarea class="form-control input-style" name="address" id="address" rows="3" required></textarea>
            </div>

            <div class="col-12 mb-4">
              <label for="contact" class="form-label fw-semibold">Contact Number</label>
              <input type="text" title="Please enter 10 digit valid number"
                name="contact" pattern="[6789][0-9]{9}"
                class="form-control input-style" id="contact" required>
            </div>

            <div class="col-12">
              <button class="btn btn-primary px-4" type="submit" name="submit">
                <i class="fa fa-plus-circle"></i> Submit
              </button>
            </div>

          </form>
        </div>

        <div class="col-lg-6 mt-4 mt-lg-0 d-flex align-items-center justify-content-center">
          <img src="image/veterinary.jpg" alt="Veterinary" class="img-fluid rounded shadow-sm w-100" style="max-height: 350px; object-fit: contain;">
        </div>
      </div>
    </div>

  </div>
</div>

<?php include 'footer.php'; ?>
