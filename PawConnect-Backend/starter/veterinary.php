<?php
session_start();
include './connection.php';

if (!isset($_SESSION['login'])) {
    header("Location: login.php");
}

include 'link.php';
include 'sidebar.php';
include 'header.php';

// Delete veterinary
if (isset($_GET['del']) && isset($_GET['id'])) {
    $id = $_GET['id'];
    if (mysqli_query($conn, "DELETE FROM veterinary WHERE id = '$id'")) {
        echo "<script>alert('Veterinary deleted successfully..!');</script>";
    } else {
        echo "<script>alert('Unable to delete veterinary..!');</script>";
        echo mysqli_error($conn);
    }
}

// Toggle Status
if (isset($_GET['toggle_status'])) {
    $id = $_GET['toggle_status'];
    $get = mysqli_fetch_assoc(mysqli_query($conn, "SELECT status FROM veterinary WHERE id = '$id'"));
    $new_status = $get['status'] ? 0 : 1;
    mysqli_query($conn, "UPDATE veterinary SET status = '$new_status' WHERE id = '$id'");
    echo "<script>window.location='veterinary.php';</script>";
}
?>

<style>
    .badge-success {
        background-color: #28a745;
        color: white;
    }

    .badge-danger {
        background-color: #dc3545;
        color: white;
    }

    .delete-btn {
        color: #dc3545;
        transition: 0.3s ease;
    }

    .delete-btn:hover {
        color: #a71d2a;
        transform: scale(1.1);
    }

    .table thead th {
        background-color: #f8f9fa;
    }

    .table td, .table th {
        vertical-align: middle;
    }
</style>

<div class="main-content" style="background-color: #f5f7fa; min-height: 100vh;">
    <div class="container-fluid content-top-gap">

        <nav aria-label="breadcrumb">
            <ol class="breadcrumb my-breadcrumb bg-white px-3 py-2 rounded shadow-sm">
                <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Veterinary</li>
            </ol>
        </nav>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary">🐾 Veterinary Info</h4>
                <a href="add-veterinary.php" class="btn btn-outline-primary btn-sm">
                    <i class="fa fa-plus-circle"></i> Add Veterinary
                </a>
            </div>
        </div>

        <div class="card shadow-sm border-0 p-4 mb-5">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Posted On</th>
                                <th>Doctor Name</th>
                                <th>Address</th>
                                <th>Contact</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                            $query = mysqli_query($conn, "SELECT * FROM veterinary ORDER BY id DESC");
                            $cnt = 1;
                            while ($row = mysqli_fetch_array($query)) {
                            ?>
                            <tr>
                                <td><?= $cnt ?></td>
                                <td><?= htmlspecialchars($row['created_date']) ?></td>
                                <td><?= htmlspecialchars($row['name']) ?></td>
                                <td><?= htmlspecialchars($row['address']) ?></td>
                                <td><?= htmlspecialchars($row['contact']) ?></td>
                                <td>
                                    <a href="veterinary.php?toggle_status=<?= $row['id'] ?>"
                                       class="badge badge-<?= $row['status'] ? 'success' : 'danger' ?>"
                                       style="cursor:pointer;">
                                        <?= $row['status'] ? 'Active' : 'Inactive' ?>
                                    </a>
                                </td>
                                <td>
                                    <a href="veterinary.php?id=<?= $row['id'] ?>&del=delete"
                                       onclick="return confirm('Are you sure you want to delete this veterinary?')"
                                       class="delete-btn" title="Delete">
                                       <i class="fa fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <?php 
                                $cnt++;
                            } 
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<?php include 'footer.php'; ?>
