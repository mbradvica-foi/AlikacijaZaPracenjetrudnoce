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
                <h3>Please Login or Register</h3><br><br>
                <input type="text" name="email" placeholder="Please enter your email address"/><br><br>
                <input type="password" name="password" placeholder="Please enter your password"/><br><br>
                <button type="submit" name="login">Login</button><br><br>
                <h6>Don't have account! <a href="register.php">Register now!</a></h6>
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
if(isset($_POST['login'])){
    $email = $_POST['email'];
    $password = $_POST['password'];
    setcookie('email',$email ,time()+10000);

    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");
    $login = pg_query($con,"SELECT * FROM users WHERE email = '".$email."' AND password = '" . $password ."'");      
    $loginFetch= pg_fetch_assoc($login);

    if($loginFetch["info"] == "0"){
        header('location:start.php');
    }else if($loginFetch["info"] == "1"){
        header('location:main.php');
    }else{
        echo '<script>alert("Prijava nije uspjela! Provjerite podatke!")</script>';
    }
}
?>