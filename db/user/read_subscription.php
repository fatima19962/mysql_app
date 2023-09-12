<?php
include '../connection.php';
//get variables
$userId=$_POST['user_id'];
$deviceId=$_POST['device_id'];

//sql part
$sqlQuery="SELECT * FROM subscription_table WHERE
    user_id='$userId' AND device_id='$deviceId'
    ";

$resultOfQuery=$connectNow->query($sqlQuery);

if($resultOfQuery->num_rows >0)
{

    $subsRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc()){
        $subsRecord[]=$rowFound;
    }
    if($subsRecord[0]["device_id"]==$deviceId){
    echo json_encode(
        array(
            "success"=>true,
            "isDevice"=>true,
            "subsData"=>$subsRecord[0],
        ));
    }
    else{
        echo json_encode(array("isDevice"=>false));
    }
}
else
{
    echo json_encode(array("success"=>false));
}







// <?php
// include '../connection.php';
// //get variables
// $userId=$_POST['user_id'];
// $deviceId=$_POST['device_id'];

// //sql part
// $sqlQuery="SELECT * FROM subscription_table WHERE
//     user_id='$userId' AND device_id='$deviceId'
//     ";

// $resultOfQuery=$connectNow->query($sqlQuery);

// if($resultOfQuery->num_rows >0)
// {

//     $subsRecord = array();
//     while($rowFound = $resultOfQuery->fetch_assoc()){
//         $subsRecord[]=$rowFound;
//     }
//     echo json_encode(
//         array(
//             "success"=>true,
//             "subsData"=>$subsRecord[0],
//         ));
// }
// else
// {
//     echo json_encode(array("success"=>false));
// }