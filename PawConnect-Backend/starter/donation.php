<?php
session_start();
include './connection.php';

if (!isset($_SESSION['login'])) {
    header("Location: login.php");
}

include 'link.php';
include 'sidebar.php';
include 'header.php';

// DELETE logic
if (isset($_GET['del'])) {
    $del_id = $_GET['del'];
    if (mysqli_query($conn, "DELETE FROM donation WHERE id = '$del_id'")) {
        echo "<script>alert('Donation record deleted successfully..!'); window.location='donation.php';</script>";
    } else {
        echo "<script>alert('Unable to delete donation..!');</script>";
    }
}
?>

<div class="main-content">
    <div class="container-fluid content-top-gap">

        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb my-breadcrumb bg-white shadow-sm px-3 py-2 rounded">
                <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Donation</li>
            </ol>
        </nav>

        <!-- Page Heading -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary">💰 Donations Received</h4>
            </div>
        </div>

        <!-- Donation Table -->
        <div class="card card_border shadow-sm p-3 mb-5">
            <div class="card-body table-responsive">
                <table class="table table-bordered table-hover table-striped datatable-1">
                    <thead class="thead-light">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Amount</th>
                            <th>Description</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $query = mysqli_query($conn, "SELECT donation.id, user.name, user.contact, donation.amount, donation.description, donation.date FROM donation JOIN user ON user.id = donation.userid ORDER BY donation.id DESC");
                        $cnt = 1;
                        while ($row = mysqli_fetch_array($query)) { ?>
                            <tr>
                                <td><?php echo htmlentities($cnt); ?></td>
                                <td><?php echo htmlentities($row['name']); ?></td>
                                <td><?php echo htmlentities($row['contact']); ?></td>
                                <td><span class="badge badge-success">₹<?php echo htmlentities($row['amount']); ?></span>
                                </td>
                                <td><?php echo htmlentities($row['description']); ?></td>
                                <td><span class="text-muted"><?php echo htmlentities($row['date']); ?></span></td>
                                <td>
                                    <a href="donation.php?del=<?php echo $row['id']; ?>"
                                        onclick="return confirm('Are you sure you want to delete this donation?')"
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