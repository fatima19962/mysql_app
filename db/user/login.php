<?php
include '../connection.php';
//get variables
$userEmail=$_POST['user_email'];
$userPass=md5($_POST['user_pass']);
//sql part
$sqlQuery="SELECT * FROM wp_users WHERE user_email='$userEmail' AND user_pass='$userPass'";

$resultOfQuery=$connectNow->query($sqlQuery);

if($resultOfQuery->num_rows >0)
{
    $userRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc()){
        $userRecord[]=$rowFound;
    }
    echo json_encode(
        array(
            "success"=>true,
            "userData"=>$userRecord[0],
        ));
}
else
{
    echo json_encode(array("success"=>false));
}