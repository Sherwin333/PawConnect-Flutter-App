<?php
session_start();
include './connection.php';

if (!isset($_SESSION['login'])) {
    header("Location: login.php");
}

include 'link.php';
include 'sidebar.php';
include 'header.php';

// Delete vaccine
if (isset($_GET['del'])) {
    if (mysqli_query($conn, "DELETE FROM vaccine WHERE id = '" . $_GET['id'] . "'")) {
        echo "<script>alert('Vaccine deleted successfully..!'); window.location='vaccine.php';</script>";
    } else {
        echo "<script>alert('Unable to delete vaccine..!');</script>";
        echo mysqli_error($conn);
    }
}

// Toggle status
if (isset($_GET['toggle_status'])) {
    $id = $_GET['toggle_status'];
    $get = mysqli_fetch_assoc(mysqli_query($conn, "SELECT status FROM vaccine WHERE id = '$id'"));
    $new_status = $get['status'] ? 0 : 1;
    mysqli_query($conn, "UPDATE vaccine SET status = '$new_status' WHERE id = '$id'");
    echo "<script>window.location='vaccine.php';</script>";
}
?>

<style>
    .table-container {
        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        overflow: hidden;
        background: #fff;
    }

    .table td img {
        height: 50px;
        width: 50px;
        object-fit: cover;
        border-radius: 4px;
    }
</style>

<div class="main-content">
    <div class="container-fluid content-top-gap">

        <nav aria-label="breadcrumb">
            <ol class="breadcrumb my-breadcrumb bg-white px-3 py-2 rounded shadow-sm">
                <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Vaccine</li>
            </ol>
        </nav>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary">💉 Vaccine Records</h4>
                <a href="add-vaccine.php" class="btn btn-outline-primary btn-sm">
                    <i class="fa fa-plus-circle"></i> Add Vaccine
                </a>
            </div>
        </div>

        <div class="card table-container p-lg-4 p-2 mb-5">
            <div class="card-body table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th>#</th>
                            <th>Posted On</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Image</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $query = mysqli_query($conn, "SELECT * FROM vaccine ORDER BY id DESC");
                        $cnt = 1;
                        while ($row = mysqli_fetch_array($query)) {
                            ?>
                            <tr>
                                <td><?php echo htmlentities($cnt); ?></td>
                                <td><?php echo htmlentities($row['createddate']); ?></td>
                                <td><?php echo htmlentities($row['title']); ?></td>
                                <td><?php echo htmlentities($row['description']); ?></td>
                                <td><img src="../<?php echo $row['image']; ?>" alt="Image"></td>
                                <td>
                                    <a href="vaccine.php?toggle_status=<?php echo $row['id']; ?>"
                                        class="badge badge-<?php echo $row['status'] ? 'success' : 'danger'; ?>"
                                        style="cursor:pointer;">
                                        <?php echo $row['status'] ? 'Active' : 'In-Active'; ?>
                                    </a>
                                </td>
                                <td>
                                    <a href="vaccine.php?id=<?php echo $row['id']; ?>&del=delete"
                                        onclick="return confirm('Are you sure you want to delete this vaccine?')"
                                        class="btn btn-sm btn-outline-danger">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <?php $cnt++;
                        } ?>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<?php include 'footer.php'; ?>