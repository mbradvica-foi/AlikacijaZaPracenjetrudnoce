<?php
    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");
    $facility = pg_query($con,"SELECT * FROM facility");     
    $facilityFetch= pg_fetch_all($facility);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">¸
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Trudnice</title>
</head>
<body>
<a href="main.php">Home<br><br>
<a href="index.php">LOGOUT</a>
    <div id="main">
        <div id="loginContainer">
            <form method="post">
                <h3>Schedule an appointment!</h3><br><br>
                <select name="facility" id="facility">
                    <option value="0" disabled selected>Please select facility</option>
                    <?php foreach($facilityFetch as $d){?>
                    <option value="<?php echo $d["id"] ?>"><?php echo $d["name"];?></option>
                    <?php } ?>
                </select><br><br>
                <select name="doctor" id="doctor" style="display: none">
                    <option value="0" disabled selected>Please select doctor!</option>
                </select><br><br>
                <label for="date">Date of an appointment</label><br>
                <input type="datetime-local" name="date" id="date"/><br><br> 
                <button type="submit" name="appoint">Appoint</button><br><br> 
            </form>
        </div>
    </div>
    
</body>
</html>

<style>
    #loginContainer{
        text-align: center;
    }
    select, input, button{
        width: 300px;
        height: 50px;
    }
</style>
<script>
    var facility_id = false;
    var date = false;
    var datetime = false;
    var doctor_id = false;
    $('#facility').on('change', function() {
        facility_id = this.value;
        $('#doctor').find('option').remove().end();
        $.getJSON('http://localhost/trudnice/api.php?facility_id=' + facility_id , function(res) {
            for (var key in res) {
                $('#doctor').append($('<option>', {
                    value: res[key]["id"],
                    text: 'dr. ' + res[key]["name"] + res[key]["surname"]
                }));
            }
        }); 
        $("#doctor").show();
    });

    $('#doctor').on('change', function() {
        doctor_id = this.value; 
        $("#date").show();
        $("#time").show();
    });



</script>

<?php
if(isset($_POST['appoint'])){
    $doctor = $_POST['doctor'];
    $date = $_POST['date'];
    //$time = $_POST['time'];
    $role_id = 2;
    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");
    $userId = pg_query($con, "SELECT id FROM users where email =  '".$_COOKIE['email']."'");
    $userIdFetch = pg_fetch_assoc($userId);
    $user = $userIdFetch["id"];

    $inputAppoint = pg_query($con,"insert into appointment(doctor_id,user_id,datetime) 
    values (".$doctor.", ".$user.", '".$date."')");

    if($inputAppoint == TRUE){
        echo '<script>alert("Uspješno ste rezervirali termin")</script>';
        header('location:main.php');
    }
    else{
        echo '<script>alert("Triger je aktiviran! Termin je već zauzet!")</script>';
    }
    
}
?>