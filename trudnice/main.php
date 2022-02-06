<?php
$con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");

$userId = pg_query($con, "SELECT id FROM users where email =  '".$_COOKIE['email']."'");
$userIdFetch = pg_fetch_assoc($userId);
$user = $userIdFetch["id"];

$birth_date = pg_query($con, "SELECT birth_date, conception_date FROM conception_info where user_id =  ".$user);
$dateFetch= pg_fetch_assoc($birth_date);
$endDate = $dateFetch["birth_date"];
$startDate = $dateFetch["conception_date"];

$now = time(); 
$your_date = strtotime($endDate);
$datediff = $now - $your_date;

$daysUntil = abs(round($datediff / (60 * 60 * 24))); 

// WEEKS
$conception_date = strtotime($startDate);
$datediffW = $conception_date -$now;

$week = abs(round(($datediffW / (60 * 60 * 24)/7))); 


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trudnice</title>
</head>
<body>
<a href="index.php">LOGOUT</a>
    <div id="main">
        <div class="grid-container">
            <div class="grid-item">
                <h3>Days left: <?php echo $daysUntil;?></h3>
                <h3>Current Week: <?php echo $week;?></h3>
            </div>
            <div class="grid-item">
                <a href="appointment.php">Schedule an doctor appointment</a><br><br>
                <a href="appointmentList.php">See all appointments</a>
            </div>
            <div class="grid-item">
                <a href="history.php">See history of newborns</a>
            </div>  
        </div>
    </div>
    
</body>
</html>

<style>
    .grid-container {
        font-family: Arial;
        text-align: left;
        display: grid;
        grid-gap: 50px;
        grid-template-columns: auto auto auto;
        background-color: red;
        padding: 10px;
    }

    .grid-item {
        background-color: pink;
        border: 1px solid rgba(0, 0, 0, 0.8);
        padding: 20px;
    }
    #loginContainer{
        text-align: left;   
    }
    input{
        width: 300px;
    }
</style>


