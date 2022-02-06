<?php
    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");

    $userId = pg_query($con, "SELECT id FROM users where email =  '".$_COOKIE['email']."'");
    $userIdFetch = pg_fetch_assoc($userId);
    $user = $userIdFetch["id"];

    $appointment = pg_query($con,"select appointment.id as id, doctor.name as doctor_name, doctor.surname as doctor_surname, facility.name as facility_name, appointment.datetime as datetime from appointment left join doctor on doctor.id = appointment.doctor_id left join facility on facility.id = doctor.facility_id where appointment.user_id = " . $user);     
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
            <th>Facility</th>
            <th>Doctor</th>
            <th>Datetime</th>
        </tr>
        <?php foreach($appointment as $a){ ?>
            <tr>
                <td><?php echo $a["id"];?></td>
                <td><?php echo $a["facility_name"];?></td>
                <td><?php echo $a["doctor_name"]; echo $a["doctor_surname"];?></td>
                <td><?php echo $a["datetime"]?></td>
            </tr>
        <?php }?>
        </table>
    </div>
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