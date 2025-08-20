<?php
session_start();
include './connection.php';

if (!isset($_SESSION['login'])) {
    header("Location: login.php");
}

include 'link.php';
include 'sidebar.php';
include 'header.php';

// Delete post
if (isset($_GET['del'])) {
    if (mysqli_query($conn, "DELETE FROM post WHERE id = '" . $_GET['id'] . "'")) {
        echo "<script>alert('Post deleted successfully..!')</script>";
    } else {
        echo "<script>alert('Unable to delete post..!')</script>";
    }
}

// Toggle status
if (isset($_GET['toggle_status'])) {
    $id = $_GET['toggle_status'];
    $get = mysqli_fetch_assoc(mysqli_query($conn, "SELECT status FROM post WHERE id = '$id'"));
    $new_status = $get['status'] ? 0 : 1;
    mysqli_query($conn, "UPDATE post SET status = '$new_status' WHERE id = '$id'");
    echo "<script>window.location='work.php';</script>";
}
?>

<style>
    .status-badge {
        padding: 5px 10px;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: 600;
        white-space: nowrap;
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

    .media-preview {
        max-width: 150px;
        height: auto;
        border-radius: 6px;
    }

    .table td,
    .table th {
        vertical-align: middle !important;
    }

    .description-cell {
        max-width: 300px;
        white-space: normal;
        word-wrap: break-word;
    }
</style>

<div class="main-content" style="background-color: #f5f7fa; min-height: 100vh;">
    <div class="container-fluid content-top-gap">

        <nav aria-label="breadcrumb">
            <ol class="breadcrumb my-breadcrumb bg-white px-3 py-2 rounded shadow-sm">
                <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Our Work</li>
            </ol>
        </nav>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary">🛠️ Our Work</h4>
                <a href="add-work.php" class="btn btn-outline-primary btn-sm">
                    <i class="fa fa-calendar"></i> Add Post
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
                                <th>Posted By</th>
                                <th>Posted On</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Preview</th>
                                <th>Type</th>
                                <th class="text-center" style="min-width: 120px;">Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $query = mysqli_query($conn, "SELECT id, title, description, date, type, path, status FROM post ORDER BY id DESC");
                            $cnt = 1;
                            while ($row = mysqli_fetch_array($query)) {
                                ?>
                                <tr>
                                    <td><?php echo htmlentities($cnt); ?></td>
                                    <td>Admin</td>
                                    <td><?php echo htmlentities($row['date']); ?></td>
                                    <td><?php echo htmlentities($row['title']); ?></td>
                                    <td class="description-cell"><?php echo htmlentities($row['description']); ?></td>
                                    <td>
                                        <?php
                                        if ($row['type'] == "Image") {
                                            echo '<img src="../' . $row['path'] . '" class="media-preview">';
                                        } elseif ($row['type'] == "Video") {
                                            echo '<video class="media-preview" controls><source src="../' . $row['path'] . '" type="video/mp4">Your browser does not support the video tag.</video>';
                                        } else {
                                            echo "No preview";
                                        }
                                        ?>
                                    </td>
                                    <td><?php echo htmlentities($row['type']); ?></td>
                                    <td class="text-center">
                                        <a href="work.php?toggle_status=<?php echo $row['id']; ?>"
                                            class="status-badge <?php echo $row['status'] ? 'status-active' : 'status-inactive'; ?>"
                                            title="Click to toggle status">
                                            <?php echo $row['status'] ? 'Active' : 'In-Active'; ?>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="work.php?id=<?php echo $row['id']; ?>&del=delete"
                                            onClick="return confirm('Are you sure you want to delete?')" class="delete-btn"
                                            title="Delete Post">
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
</div>

<?php include 'footer.php'; ?>