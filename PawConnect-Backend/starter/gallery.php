<?php
session_start();
include './connection.php';

if (!isset($_SESSION['login'])) {
    header("Location: login.php");
}

include 'link.php';
include 'sidebar.php';
include 'header.php';

// Delete Image
if (isset($_GET['del'])) {
    if (mysqli_query($conn, "DELETE FROM gallery WHERE id = '" . $_GET['id'] . "'")) {
        echo "<script>alert('Image deleted successfully..!')</script>";
    } else {
        echo "<script>alert('Unable to delete image..!')</script>";
        echo mysqli_error($conn);
    }
}

// Toggle Status
if (isset($_GET['toggle_status'])) {
    $id = $_GET['toggle_status'];
    $get = mysqli_fetch_assoc(mysqli_query($conn, "SELECT status FROM gallery WHERE id = '$id'"));
    $new_status = $get['status'] ? 0 : 1;
    mysqli_query($conn, "UPDATE gallery SET status = '$new_status' WHERE id = '$id'");
    echo "<script>window.location='gallery.php';</script>";
}
?>

<style>
    .gallery-img {
        height: 60px;
        width: 60px;
        object-fit: cover;
        border-radius: 6px;
        border: 1px solid #ddd;
    }

    .status-badge {
        padding: 5px 10px;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: 600;
    }

    .status-active {
        background-color: #d4edda;
        color: #155724;
    }

    .status-inactive {
        background-color: #f8d7da;
        color: #721c24;
    }

    .delete-btn {
        color: #dc3545;
        transition: 0.3s ease;
    }

    .delete-btn:hover {
        color: #a71d2a;
        transform: scale(1.1);
    }

    .table td,
    .table th {
        vertical-align: middle !important;
    }
</style>

<div class="main-content" style="background-color: #f5f7fa; min-height: 100vh;">
    <div class="container-fluid content-top-gap">

        <nav aria-label="breadcrumb">
            <ol class="breadcrumb my-breadcrumb bg-white px-3 py-2 rounded shadow-sm">
                <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Our Gallery</li>
            </ol>
        </nav>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary">📸 Our Gallery</h4>
                <a href="add-gallery.php" class="btn btn-outline-primary btn-sm">
                    <i class="fa fa-image"></i> Add Gallery
                </a>
            </div>
        </div>

        <div class="card shadow-sm border-0 p-4 mb-5">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped mb-0">
                        <thead class="thead-light">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Date</th>
                                <th>Image</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $query = mysqli_query($conn, "SELECT id, title, date, image, status FROM gallery ORDER BY id DESC");
                            $cnt = 1;
                            while ($row = mysqli_fetch_array($query)) {
                                ?>
                                <tr>
                                    <td><?php echo $cnt++; ?></td>
                                    <td><?php echo htmlentities($row['title']); ?></td>
                                    <td><?php echo htmlentities($row['date']); ?></td>
                                    <td><img src="../<?php echo $row['image']; ?>" class="gallery-img" alt="Image"></td>
                                    <td>
                                        <a href="gallery.php?toggle_status=<?php echo $row['id']; ?>"
                                            class="status-badge <?php echo $row['status'] ? 'status-active' : 'status-inactive'; ?>"
                                            title="Click to toggle status">
                                            <?php echo $row['status'] ? 'Active' : 'In-Active'; ?>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="gallery.php?id=<?php echo $row['id']; ?>&del=delete"
                                            onClick="return confirm('Are you sure you want to delete this image?')"
                                            class="delete-btn" title="Delete Image">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<?php include 'footer.php'; ?>