<?php

include '../connection.php';

$userEmail=$_POST["user_email"];

$sqlQuery="SELECT * FROM wp_users WHERE user_email='$userEmail'";

$resultOfQuery=$connectNow->query($sqlQuery);

if($resultOfQuery->num_rows >0)
{
    //num rows length==1 --- email already exists---error
    echo json_encode(array("exists"=>true));
}
else
{
    //num rows length==0 --- user will allowed to signUp successfully
    echo json_encode(array("exists"=>false));
}