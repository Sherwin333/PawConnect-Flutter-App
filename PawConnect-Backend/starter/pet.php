<?php
session_start();
include './connection.php';

if (!isset($_SESSION['login'])) {
    header("Location: login.php");
}

include 'link.php';
include 'sidebar.php';
include 'header.php';

// Toggle status logic
if (isset($_GET['status_id']) && isset($_GET['current_status'])) {
    $id = $_GET['status_id'];
    $new_status = $_GET['current_status'] ? 0 : 1;

    if (mysqli_query($conn, "UPDATE adopt SET status = '$new_status' WHERE id = '$id'")) {
        echo "<script>alert('Status updated successfully..!');window.location='pet.php';</script>";
    } else {
        echo "<script>alert('Unable to update status..!');</script>";
    }
}

// Delete logic
if (isset($_GET['del'])) {
    if (mysqli_query($conn, "DELETE FROM adopt WHERE id = '" . $_GET['id'] . "'")) {
        echo "<script>alert('Pet deleted successfully..!')</script>";
    } else {
        echo "<script>alert('Unable to delete pet..!')</script>";
        echo mysqli_error($conn);
    }
}
?>

<div class="main-content">
    <div class="container-fluid content-top-gap">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb my-breadcrumb">
                <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Pet</li>
            </ol>
        </nav>

        <div class="card card_border py-2 mb-4">
            <div class="cards__heading">
                <h3>Pet Dogs 
                    <a href="add-pet.php">
                        <span class="float-right text-primary"><i class="fa fa-paw"></i> Add pet</span>
                    </a>
                </h3>
            </div>

            <div class="card card_border p-lg-5 p-3 mb-4">
                <div class="card-body py-3 p-0">
                    <div class="row">
                        <table cellpadding="0" cellspacing="0" border="0"
                            class="datatable-1 table table-bordered table-striped display table-hover" width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Gender</th>
                                    <th>City</th>
                                    <th>Breed Name</th>
                                    <th>date</th>
                                    <th>Image</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>

                                <?php 
                                $query = mysqli_query($conn, "SELECT * FROM adopt ORDER BY id DESC");
                                $cnt = 1;
                                while ($row = mysqli_fetch_array($query)) { ?>									
                                    <tr>
                                        <td><?php echo htmlentities($cnt); ?></td>
                                        <td><?php echo htmlentities($row['animal_name']); ?></td>
                                        <td><?php echo htmlentities($row['gender']); ?></td>
                                        <td><?php echo htmlentities($row['city']); ?></td>
                                        <td><?php echo htmlentities($row['breed_name']); ?></td>
                                        <td><?php echo htmlentities($row['date']); ?></td>
                                        <td><img src="../<?php echo $row['image']; ?>" height="50" width="50"/></td>
                                        <td>
                                            <a href="pet.php?status_id=<?php echo $row['id']; ?>&current_status=<?php echo $row['status']; ?>"
                                               class="btn btn-sm <?php echo $row['status'] ? 'btn-success' : 'btn-danger'; ?>">
                                               <?php echo $row['status'] ? 'Available' : 'Not Available'; ?>
                                            </a>
                                        </td>
                                        <td>
                                            <a href="pet.php?id=<?php echo $row['id'] ?>&del=delete"
                                               onClick="return confirm('Are you sure you want to delete?')">
                                               <i class="fa fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <?php $cnt = $cnt + 1;
                                } ?>
                            </tbody>			
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include 'footer.php'; ?>
