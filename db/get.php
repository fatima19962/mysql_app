<?php
require_once('connection.php');
$query='SELECT * FROM users_table';
$stm = $db->prepare($query);
$stm->execute();
$row =$stm->fetch(PDO::FETCH_ASSOC);
echo json_encode($row);