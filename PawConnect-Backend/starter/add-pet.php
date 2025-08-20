<?php
    session_start();
    include './connection.php';

    if(!isset($_SESSION['login']))
    {
        header("Location: login.php");
    }
   
    include 'link.php';
    include 'sidebar.php';
    include 'header.php';

    if(isset($_POST['submit']))
    {
        $path = "starter/pet/".$_FILES["file"]["name"];
        $name = $_POST['name'];
        $gander = $_POST['gender'];
        $breed = $_POST['breed'];
        $health = $_POST['health'];
        $description = $_POST['description'];
        $age = $_POST['age'];
        $color = $_POST['color'];
        $city = $_POST['city'];
        $status = $_POST['status'];

       
        if(move_uploaded_file($_FILES["file"]["tmp_name"],"pet/".$_FILES["file"]["name"]))
        {
            if(mysqli_query($conn, "insert into adopt(animal_name, gender, city, status, image, breed_name, helth_condition, description, age, color)values('$name','$gander','$city','$status','$path','$breed','$health', '$description', '$age','$color')"))
            {
                echo "<script>alert('Pet added successfully..!');</script>";
            }
            else
            {
                echo "<script>alert('Unable to add pet..!');</script>";
                // echo mysqli_error($conn);
            }
        }
        else
        {
            echo "<script>alert('Unable to upload file on server..!');</script>";
        }
    }
 

    ?>
    
  <div class="main-content">
    <div class="container-fluid content-top-gap">

        <nav aria-label="breadcrumb">
            <ol class="breadcrumb my-breadcrumb">
            <li class="breadcrumb-item"><a href="index.php">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Add Pet</li>
            </ol>
        </nav>
        
        <div class="cards__heading">
          <h3>Add Pet Dog</h3>
        </div>

        <div class="card card_border p-lg-5 p-3 mb-4">
          <div class="card-body py-3 p-0">
            <div class="row">
              <div class="col-lg-6 align-self pr-lg-4">

            <form class="row g-3" method="post" enctype="multipart/form-data">
              
              <div class="col-md-12">
                <label for="validationDefault01" class="form-label">Name</label>
                <input type="text" class="form-control input-style" name="name" id="validationDefault01" required>
              </div>

              <div class="form-group col-md-4 mt-3">
                  <label for="inputState" class="input__label">Gender</label>
                  <select id="inputState" class="form-control input-style" required name="gender">
                      <option>Choose</option>
                      <option value="Male">Male</option>
                      <option value="Female">Female</option>
                  </select>
              </div>

              <div class="form-group col-md-8 mt-3">
                <label for="validationDefault01" class="form-label">Breed Name</label>
                <input type="text" class="form-control input-style" name="breed" id="validationDefault01" required>
              </div>

              <div class="col-md-12">
                <label for="validationDefault01" class="form-label">Health Condition</label>
                <input type="text" class="form-control input-style" name="health" id="validationDefault01" required>
              </div>

              <div class="col-md-12 mt-3">
                <label for="validationDefault01" class="form-label">Description</label>
                <textarea class="form-control input-style" name="description" id="validationDefault01" required></textarea>
              </div>

              <div class="col-md-6 mt-3">
                <label for="validationDefault01" class="form-label">Age</label>
                <input type="text" class="form-control input-style" name="age" id="validationDefault01" required>
              </div>

              <div class="col-md-6 mt-3">
                <label for="validationDefault01" class="form-label">Color</label>
                <input type="text" class="form-control input-style" name="color" id="validationDefault01" required>
              </div>

              <div class="col-md-6 mt-3">
                <label for="validationDefault01" class="form-label">City</label>
                <input type="text" class="form-control input-style" name="city" id="validationDefault01" required>
              </div>

              <div class="form-group col-md-6 mt-3">
                  <label for="inputState" class="input__label">Status</label>
                  <select id="inputState" class="form-control input-style" required name="status">
                      <option value="">Choose</option>
                      <option value="1">Available</option>
                      <option value="0">Not-Available</option>
                  </select>
              </div>

              <div class="form-group col-md-12 mt-3">
                <label for="validationDefault02" class="input__label">File</label>
                <input type="file" class="form-control input-style" id="validatedCustomFile" name="file" accept="image/*" >
              </div>

              <div class="col-12">
                <button class="btn btn-primary" type="submit" name="submit">Submit form</button>
              </div>
            </form>
            </div>
              <div class="col-lg-6 pl-lg-4 mt-lg-0 mt-4">
                <img src="image/adopt.jpg" alt="" class="img-fluid rounded" />
              </div>
            </div>
          </div>
        </div>

        
    </div>
</div>

<?php
    include 'footer.php';
  ?>
