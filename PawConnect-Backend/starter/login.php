
<?php 
    session_start();
    if(isset($_SESSION['login']))
    {
      header ("Location: index.php");
    } 
    else if(isset($_POST['submit']))
    {
      if($_POST['uname']=='admin' && $_POST['password']=='admin@123')
      {
        $_SESSION['login']=true;
        header("Location: index.php");
      }
      else
      {
        echo "<script>alert('Invalid Credentials..');</script>";
      }
    }

    include 'link.php';
?>
<div class="row mt-5">
  <div class="col-lg-4"></div>
  <div class="col-lg-4 card shadow p-5 mt-5">
    <form action="#" method="post">
      <h2 class="text-center">Log in</h2>       
      <div class="form-group mt-3">
          <input type="text" class="form-control" placeholder="Username" required="required" name="uname">
      </div>
      <div class="form-group">
          <input type="password" class="form-control" placeholder="Password" required="required" name="password">
      </div>
      <div class="form-group">
          <button type="submit" class="btn btn-primary btn-block" name="submit">Log in</button>
      </div>       
    </form>
  </div>
  <div class="col-lg-4"></div>
</div>
<?php
    include 'footer.php';
?>

