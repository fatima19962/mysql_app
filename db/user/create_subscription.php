<?php
include '../connection.php';
//get variables
$userId=$_POST['user_id'];
$userObj=$_POST['user'];
$startDate=$_POST['start_date'];
$payAmount=$_POST['pay_amount'];
$refId=$_POST['ref_id'];
$email=$_POST['email'];
$phoneNumber=$_POST['phone_number'];
$level=$_POST['level'];
$description=$_POST['description'];
$deviceId=$_POST['device_id'];

//sql part
$sqlQuery="INSERT INTO subscription_table SET
    user_id='$userId',
    user_info='$userObj',
    email='$email',
    ref_id='$refId',
    phone='$phoneNumber',
    start_date='$startDate',
    amount='$payAmount',
    level='$level',
    description='$description',
    device_id='$deviceId'
    ";

$resultOfQuery=$connectNow->query($sqlQuery);

if($resultOfQuery)
{
    echo json_encode(array("success"=>true));
}
else
{
    echo json_encode(array("success"=>false));
}