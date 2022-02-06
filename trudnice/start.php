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
                <h3>Please enter estimated date of conception!</h3><br><br>
                <input type="date" name="conception"/><br><br>
                <button type="submit" name="submit">Submit</button>
            </form>

        </div>
    </div>
</body>
</html>

<style>
    #loginContainer{
        text-align: center;  
    }
    button{
        width: 200px;
    }
    input{
        width: 300px;
    }
</style>

<?php
if(isset($_POST['submit'])){
    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");

    $userId = pg_query($con, "SELECT id FROM users where email =  '".$_COOKIE['email']."'");
    $userIdFetch = pg_fetch_assoc($userId);
    $user = $userIdFetch["id"];
    $conception = $_POST['conception'];

    $input =pg_query($con,"insert into conception_info (id, conception_date, birth_date, user_id) values (default,'" . $conception . "'::date, default, " . $user . " )");

    if($input){
        $update =pg_query($con,"update users set info = 1 where id = " . $user);
        header('location:main.php');
    }else{
        echo '<script>alert("Došlo je do pogreške!")</script>';
    }
}
?>