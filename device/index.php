<?php
session_start();
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
} else {
    if ($_SESSION["user_id"] == null) {
        header("Location: login.php");
    }
}


//--------------------------Настройки подключения к БД-----------------------
include 'connectDB.php';
//-----------------Получаем из БД все данные об устройстве-------------------

$result = getDevice($mysql);
$blocked_deviceForUser = deviceIsBlockedForUser($mysql);
$blocked_device = deviceIsBlocked($mysql);

if (mysqli_num_rows($result) > 0) { //Если в БД есть данные об устройстве
    $title = "Все устройства";
    $content = "";


    while ($device = mysqli_fetch_assoc($result)) {
        $id = $device['DEVICE_ID'];
        $device_name = $device['NAME'];
        $temperature = $device['TEMP'] / 10;
        $temperature_dt = $device['TEMP_DATETIME'];
        $out_state = $device['OUT_STATE'];
        $out_state_dt = $device['OUT_STATE_DATETIME'];

        if (isset($blocked_deviceForUser[$id]) && $blocked_deviceForUser[$id] == 1){
            $device_name .= ' Устройство для вас заблокированно';
            $temperature = '?';
            $temperature_dt = '?';
            $out_state = '?';
            $out_state_dt = '?';
            $id = '?';
        } else if (isset($blocked_device[$id]) && $blocked_device[$id] == 1){
            $device_name .= ' Устройство ведет себя подозрительно';

        }


        include 'paternIOT.php';


        $content .= $patern;
    }
} else { //Если в БД нет данных об устройстве
    echo '
    <form action="login.php">
    <input type="submit" value="Exit">
</form>';
    echo "В базе данных нет устройств.";
    exit;
}

//----------------------------------------------------------------------------------------

//------Проверяем данные, полученные от пользователя---------------------
$id = 1;

if (isset($_POST['button_on'])) {
    $id = $_POST['button_on'];
    $date_today = date("Y-m-d H:i:s");
    $query = "INSERT COMMAND_TABLE SET user_id = ?, DEVICE_ID= ?, COMMAND='1', DATE_TIME='$date_today'";
    $stmt = mysqli_prepare($mysql, $query);
    mysqli_stmt_bind_param($stmt, 'ii', $_SESSION["user_id"], $id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

}

if (isset($_POST['button_off'])) {
    $id = $_POST['button_off'];
    $date_today = date("Y-m-d H:i:s");
    $query = "INSERT COMMAND_TABLE SET user_id = ?, DEVICE_ID= ?, COMMAND='0', DATE_TIME='$date_today'";
    $stmt = mysqli_prepare($mysql, $query);
    mysqli_stmt_bind_param($stmt, 'ii', $_SESSION["user_id"], $id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
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
<form action="login.php">
    <input type="submit" value="Exit">
</form>
<h1>' . $title . '</h1>
' . $content . '
</body>
</html>';
//----------------------------------------------------------------------


function getDevice($mysql)
{
    $query = "SELECT D.DEVICE_ID as DEVICE_ID, D.NAME as NAME, T.TEMPERATURE as TEMP, T.DATE_TIME as TEMP_DATETIME, S.OUT_STATE as OUT_STATE, S.DATE_TIME as OUT_STATE_DATETIME FROM DEVICE_TABLE D
JOIN user_device U_D USING (device_id)
JOIN TEMPERATURE_TABLE T USING(DEVICE_ID)
JOIN OUT_STATE_TABLE S USING(DEVICE_ID)
WHERE user_id = ? ";

    $stmt = mysqli_prepare($mysql, $query);
    mysqli_stmt_bind_param($stmt, 'i', $_SESSION['user_id']);
    mysqli_stmt_execute($stmt);
    return mysqli_stmt_get_result($stmt);
}

function deviceIsBlockedForUser($mysql)
{
    $query = "SELECT device_id,NOW() < end_blocked as isBlocked FROM blocked_user
WHERE user_id = ? and NOW() < end_blocked";
    $stmt = mysqli_prepare($mysql, $query);
    mysqli_stmt_bind_param($stmt, 'i', $_SESSION['user_id']);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $bloced_device = null;
    while ($row = mysqli_fetch_assoc($result)) {
        $bloced_device[$row['device_id']] = ($row['isBlocked'] == 0) ? 0 : 1;
    }
    return $bloced_device;
}
function deviceIsBlocked($mysql)
{
    $query = "SELECT device_id,NOW() < end_blocked as isBlocked FROM blocked_device
WHERE NOW() < end_blocked";
    $stmt = mysqli_prepare($mysql, $query);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $bloced_device = null;
    while ($row = mysqli_fetch_assoc($result)) {
        $bloced_device[$row['device_id']] = ($row['isBlocked'] == 0) ? 0 : 1;
    }
    return $bloced_device;
}

?>