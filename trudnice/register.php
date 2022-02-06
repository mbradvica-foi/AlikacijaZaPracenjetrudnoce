<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trudnice</title>
</head>
<body>
    <div id="main">
        <div id="loginContainer">
            <form method="post">
                <h3>Register now</h3><br><br>
                <input type="text" name="name" placeholder="Please enter your name"/><br><br>
                <input type="text" name="surname" placeholder="Please enter your surname"/><br><br>
                <input type="text" name="email" placeholder="Please enter your email address"/><br><br>
                <input type="password" name="password" placeholder="Please enter your password"/><br><br>
                <button type="submit" name="register">Register</button><br><br>
                <h6>Already have account! <a href="index.php">Login now!</a></h6>
            </form>
        </div>
    </div>
    
</body>
</html>

<style>
    #loginContainer{
        display: flex;
        justify-content: center;    
    }
    input{
        width: 300px;
    }
</style>

<?php
if(isset($_POST['register'])){
    $name = $_POST['name'];
    $surname = $_POST['surname'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $role_id = 2;

    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");

    $inputRegistration =pg_query($con,"insert into users(name,surname,email,password,role_id) 
    values ('".$name."', '".$surname."', '".$email."','".$password."','".$role_id."')");

    if($inputRegistration == TRUE){
        echo '<script>alert("Uspješno ste se registrirali! Sada se možete prijaviti!")</script>';
        header('location:index.php');
    }
    else{
        echo '<script>alert("Email ne sadrži @ znak")</script>';
    }
    
}
?>