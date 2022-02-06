<?php
    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");

    $userId = pg_query($con, "SELECT id, name, surname FROM users where email =  '".$_COOKIE['email']."'");
    $userIdFetch = pg_fetch_assoc($userId);
    $user = $userIdFetch["id"];
    $name = $userIdFetch["name"];
    $surname = $userIdFetch["surname"];

    $appointment = pg_query($con,"SELECT * from kids where user_id = " . $user);     
    $appointment= pg_fetch_all($appointment);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<a href="main.php">Home<br><br>
<a href="index.php">LOGOUT</a>
<div>
    <table>
        <tr>
            <th>ID</th>
            <th>Mothers name</th>
            <th>Kids name</th>
            <th>Weight</th>
            <th>Height</th>
            <th>Birth date</th>
            <th></th>
        </tr>
        <?php foreach($appointment as $a){ ?>
            <tr>
                <td><?php echo $a["id"];?></td>
                <td><?php echo $name; echo " "; echo $surname;?></td>
                <td><?php echo $a["name"];?></td>
                <td><?php echo $a["weight"];?></td>
                <td><?php echo $a["height"];?></td>
                <td><?php echo $a["birth_date"];?></td>
                <td><a href="#edit" data-toggle="modal" class="btn btn-outline-secondary btn-sm">Edit baby info</a></td>
            </tr>
        <?php }?>
        </table>
    </div>
    <br><br>
    <form method="post">
                <input type="text" name="id" id="id" placeholder="Enter baby id"/><br><br>
                <input type="text" name="name" id="name" placeholder="Enter baby name"/><br><br>
                <input type="text" name="weight" id="weight" placeholder="Enter baby weight"/><br><br>
                <input type="text" name="height" id="height" placeholder="Enter baby height"/><br><br> 
                <button type="submit" name="edit">Edit baby info</button><br><br> 
    </form>
</body>

</html>

<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>

<style>
    #loginContainer{
        text-align: center;
    }
    select, input, button{
        width: 300px;
        height: 50px;
    }
</style>

<?php
if(isset($_POST['edit'])){
 
    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432"); 
    $id = $_POST['id'];  
    $name = $_POST['name'];
    $weight = $_POST['weight'];
    $height = $_POST['height'];

   // echo "update kids set name = '" . $name . "', weight = '" . $weight . " kg', '" . $height . " cm' where id = " . $id; die;
    $update =pg_query($con,"update kids set name = '" . $name . "', weight = '" . $weight . " kg', height = '" . $height . " cm' where id = " . $id);
    header('location:history.php');

        
}
?>