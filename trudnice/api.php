<?php

    $con=pg_connect("host=localhost dbname=trudnice user=postgres password=vaša_lozinka_ide_ovdje port=5432");

    if($_GET["facility_id"]){  
        $doctor = pg_query($con,"SELECT * FROM doctor where facility_id = " . $_GET["facility_id"]);     
        $result= pg_fetch_all($doctor);
        echo json_encode($result);
    }
    else if($_GET["date"]){
        $appointment = pg_query($con,"SELECT * FROM appointment where datetime like '" . $_GET["date"] . "%' and doctor_id = " . $_GET["doctor_id"]);     
        $appointmentFetch= pg_fetch_all($appointment);
        echo json_encode($appointmentFetch);
    }
    /*else if($_GET["hours"]){
        $array  = $_GET["hours"];
        $pieces = explode("-", $array);
        $start = $pieces[0]; 
        $end = $pieces[1]; 
        $hours = pg_query($con,"SELECT * FROM doctor where id = " . $_GET["doctor_id"]);     
        $hoursFetch= pg_fetch_assoc($hours);
        $begin_time = $hoursFetch["begin_time"]; 
        $end_time = $hoursFetch["end_time"]; 

        $counter = false;
        if($counter <= $end_time){
            $begin_time = $begin_time 
        }
        echo json_encode($hoursFetch);
    }*/
    else{
        echo "Error!";
    }

?>