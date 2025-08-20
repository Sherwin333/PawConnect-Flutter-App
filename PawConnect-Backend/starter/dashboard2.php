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
        <div class="col-xl-6 pr-xl-2">
          <div class="row">
            <div class="col-sm-6 pr-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
                <a href="user-list.php">
                  <i class="fa fa-user" style="color:blue"> </i>
                  <?php include '../connection.php'; $res1 = mysqli_query($conn, "select count(*) as count from user");
                  $row1 = mysqli_fetch_assoc($res1);
                  ?>
                  <h3 class="text-primary number"><?php echo $row1['count'];?></h3>
                  <p class="stat-text">Total Users</p>
                  </a>
              </div>
            </div>
            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="work.php">
                <i class="fa fa-calendar" style="color:green"> </i>
                <?php include '../connection.php'; $res2 = mysqli_query($conn, "select count(*) as count from post");
                  $row2 = mysqli_fetch_assoc($res2);
                  ?>
                  <h3 class="text-primary number"><?php echo $row2['count'];?></h3>
                <p class="stat-text">Total Posts</p>
                </a>
              </div>
            </div>
            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="gallery.php">
                <i class="fa fa-image" style="color:red"> </i>
                <?php include '../connection.php'; $res3 = mysqli_query($conn, "select count(*) as count from gallery");
                  $row3 = mysqli_fetch_assoc($res3);
                  ?>
                  <h3 class="text-primary number"><?php echo $row3['count'];?></h3>
                <p class="stat-text">Gallery</p>
                </a>
              </div>
            </div>
            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="donation.php">
                <i class="fa fa-rupee" style="color:gold"> </i>
                <?php include '../connection.php'; $amt = 0; $res4 = mysqli_query($conn, "select amount from donation");
                  while($row4 = mysqli_fetch_assoc($res4)){$amt = $amt+$row4['amount'];}
                  ?>
                  <h3 class="text-primary number"><?php echo $amt;?></h3>
                <p class="stat-text">Donation</p>
                </a>
              </div>
            </div>

            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="pet.php">
                <i class="fa fa-paw" style="color:blue"> </i>
                <?php include '../connection.php'; $res5 = mysqli_query($conn, "select count(*) as count from adopt");
                  $row5 = mysqli_fetch_assoc($res5);
                  ?>
                  <h3 class="text-primary number"><?php echo $row5['count'];?></h3>
                <p class="stat-text">Pet Dog</p>
                </a>
              </div>
            </div>

            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="adopt_request.php">
                <i class="fa fa-question" style="color:green"> </i>
                <?php include '../connection.php'; $res6 = mysqli_query($conn, "select count(*) as count from adopt_request");
                  $row6 = mysqli_fetch_assoc($res6);
                  ?>
                  <h3 class="text-primary number"><?php echo $row6['count'];?></h3>
                <p class="stat-text">Pet Request</p>
                </a>
              </div>
            </div>

            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="volunteer.php">
                <i class="fa fa-users" style="color:green"> </i>
                <?php include '../connection.php'; $res3 = mysqli_query($conn, "select count(*) as count from volunteer");
                  $row3 = mysqli_fetch_assoc($res3);
                  ?>
                  <h3 class="text-primary number"><?php echo $row3['count'];?></h3>
                <p class="stat-text">Volunteer Request</p>
                </a>
              </div>
            </div>

            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="rescue.php">
                <i class="fa fa-plus-square" style="color:red"> </i>
                <?php include '../connection.php'; $res4 = mysqli_query($conn, "select count(*) as count from rescue");
                  $row4 = mysqli_fetch_assoc($res4);
                  ?>
                  <h3 class="text-primary number"><?php echo $row4['count'];?></h3>
                <p class="stat-text">Rescue Request</p>
                </a>
              </div>
            </div>

            <div class="col-sm-6 pl-sm-2 statistics-grid">
              <div class="card card_border border-primary-top p-4">
              <a href="logout.php">
                <i class="fa fa-power-off" style="color:blue"> </i>
                  <h3 class="text-primary number">Logout</h3>
                  <p class="stat-text">Signout</p>
                </a>
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-6 pl-xl-2">
              <img src="image/admin.png" alt="" class="img-fluid rounded" />
        </div>
      </div>
    </div>
  <!-- //statistics data -->
</div>
<!-- //content -->
</div>
<!-- main content end-->