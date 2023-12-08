<?php

//--------------------------Настройки подключения к БД-----------------------
include 'connectDB.php';

//----------------------------------------------------------------------------------------
//$id = 1;

//-----------------Получаем из БД все данные об устройстве-------------------

$query = "SELECT D.DEVICE_ID as DEVICE_ID, D.NAME as NAME, T.TEMPERATURE as TEMP, T.DATE_TIME as TEMP_DATETIME, S.OUT_STATE as OUT_STATE, S.DATE_TIME as OUT_STATE_DATETIME FROM DEVICE_TABLE D
JOIN TEMPERATURE_TABLE T USING(DEVICE_ID)
JOIN OUT_STATE_TABLE S USING(DEVICE_ID)";

$result = mysqli_query($mysql, $query);

if(mysqli_num_rows($result) > 0)
{ //Если в БД есть данные об устройстве
$title = "Все устройства";
$content = "";


while($device = mysqli_fetch_assoc($result)){
$id = $device['DEVICE_ID'];
$device_name = $device['NAME'];
$temperature = $device['TEMP']/10;
$temperature_dt = $device['TEMP_DATETIME'];
$out_state = $device['OUT_STATE'];
$out_state_dt = $device['OUT_STATE_DATETIME'];
include 'paternIOT.php';



$content .= $patern;
}
} 
else { //Если в БД нет данных об устройстве
echo "В базе данных нет устройств.";
exit;
}

//----------------------------------------------------------------------------------------

//------Проверяем данные, полученные от пользователя---------------------
$id = 1;

if(isset($_POST['button_on'])){
$id = $_POST['button_on'];
$date_today = date("Y-m-d H:i:s");
$query = "UPDATE COMMAND_TABLE SET COMMAND='1', DATE_TIME='$date_today' WHERE DEVICE_ID = '$id'";
$result = mysqli_query($mysql, $query);
if(mysqli_affected_rows($mysql) != 1) //Если не смогли обновить - значит в таблице просто нет данных о команде для этого устройства
{ //вставляем в таблицу строчку с данными о команде для устройства
$query = "INSERT COMMAND_TABLE SET DEVICE_ID='$id', COMMAND='1', DATE_TIME='$date_today'";
$result = mysqli_query($mysql, $query);
}
}

if(isset($_POST['button_off'])){
$id = $_POST['button_off'];
$date_today = date("Y-m-d H:i:s");
$query = "UPDATE COMMAND_TABLE SET COMMAND='0', DATE_TIME='$date_today' WHERE DEVICE_ID = '$id'";
$result = mysqli_query($mysql, $query);
if(mysqli_affected_rows($mysql) != 1) //Если не смогли обновить - значит в таблице просто нет данных о команде для этого устройства
{ //вставляем в таблицу строчку с данными о команде для устройства
$query = "INSERT COMMAND_TABLE SET DEVICE_ID='$id', COMMAND='0', DATE_TIME='$date_today'";
$result = mysqli_query($mysql, $query);
}
}
//-----------------------------------------------------------------------

//-------Формируем интерфейс приложения для браузера---------------------
echo '
<!DOCTYPE HTML>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyApp</title>
</head>
<body>
lklkllklk
<h1>'.$title.'</h1>
'.$content.'
</body>
</html>';
//----------------------------------------------------------------------

?>