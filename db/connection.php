<?php
$serverHost="localhost";
$database="mlggra_first_host";
$user = 'mlggra_mlg199968';
$pass ='MLG_grand1999';
try{
$connectNow=new mysqli($serverHost,$user,$pass,$database);


}
catch(PDOException $e){

$error=$e->getMessage();
echo $error;
}