<?php
include './connection.php';
if (isset($_GET['del'])) {
  if (mysqli_query($conn, "delete from user where id = '" . $_GET['id'] . "'")) {
    echo "<script>alert('User deleted successfully..!')</script>";
  } else {
    echo "<script>alert('Unable to delete user..!')</script>";
    echo mysqli_error($conn);
  }
}
?>

<!-- main content start -->
<div class="main-content">

  <!-- content -->
  <div class="container-fluid content-top-gap">

    <nav aria-label="breadcrumb">
      <ol class="breadcrumb my-breadcrumb">
        <li class="breadcrumb-item"><a href="index.html">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
      </ol>
    </nav>
    <div class="welcome-msg pt-3 pb-4">
      <h1>Hi <span class="text-primary">Admin</span>, Welcome back</h1>
    </div>

    <!-- statistics data -->
    <div class="statistics">
      <div class="row">
        <div class="col-xl-9 card">

          <div class="row p-4">
            <table cellpadding="0" cellspacing="0" border="0"
              class="datatable-1 table table-bordered table-striped	 display table-hover" width="100%">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Full Name</th>
                  <th>Email</th>
                  <th>Contact no</th>
                  <th>Status</th>
                  <th>Date</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>

                <?php
                $query = mysqli_query($conn, "select id, name, email, contact, created_date, status from user order by id desc");
                $cnt = 1;
                while ($row = mysqli_fetch_array($query)) { ?>
                  <tr>
                    <td><?php echo htmlentities($cnt); ?></td>
                    <td><?php echo htmlentities($row['name']); ?></td>
                    <td><?php echo htmlentities($row['email']); ?></td>
                    <td> <?php echo htmlentities($row['contact']); ?></td>
                    <td> <?php if ($row['status']) {
                      echo 'Active';
                    } else {
                      echo 'In-Active';
                    } ?></td>
                    <td> <?php echo htmlentities($row['created_date']); ?></td>
                    <td>
                      <a href="user-list.php?id=<?php echo $row['id'] ?>&del=delete"
                        onClick="return confirm('Are you sure you want to delete?')"><i class="fa fa-trash"></i></a>
                    </td>
                  </tr>
                  <?php $cnt = $cnt + 1;
                } ?>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-xl-3">
          <img src="image/admin.png" alt="" class="img-fluid rounded" />
        </div>
      </div>
    </div>
    <!-- //statistics data -->
  </div>
  <!-- //content -->
</div>
<!-- main content end-->