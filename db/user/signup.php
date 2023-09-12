<?php
include '../connection.php';
//get variables
$userName=$_POST['display_name'];
$userEmail=$_POST['user_email'];
$userPass=md5($_POST['user_pass']);
//sql part
$sqlQuery="INSERT INTO wp_users SET  user_login='$userEmail', display_name='$userName', user_email='$userEmail', user_pass='$userPass'";

$resultOfQuery=$connectNow->query($sqlQuery);

if($resultOfQuery)
{
    //************************************************* */
    $sqlQuerySearch="SELECT * FROM wp_users WHERE user_email='$userEmail' AND user_pass='$userPass'";

$resultOfQuerySearch=$connectNow->query($sqlQuerySearch);

if($resultOfQuerySearch->num_rows >0)
{
    $userRecord = array();
    while($rowFound = $resultOfQuerySearch->fetch_assoc()){
        $userRecord[]=$rowFound;
    }
    echo json_encode(
        array(
            "success"=>true,
            "userData"=>$userRecord[0],
        ));
}
//************************************ */
}
else
{
    echo json_encode(array("success"=>false));
}



// <?php
// include '../connection.php';
// //get variables
// $userName=$_POST['display_name'];
// $userEmail=$_POST['user_email'];
// $userPass=md5($_POST['user_pass']);
// //sql part
// $sqlQuery="INSERT INTO wp_users SET  user_login='$userEmail', display_name='$userName', user_email='$userEmail', user_pass='$userPass'";

// $resultOfQuery=$connectNow->query($sqlQuery);

// if($resultOfQuery)
// {
//     echo json_encode(array("success"=>true));
// }
// else
// {
//     echo json_encode(array("success"=>false));
// }