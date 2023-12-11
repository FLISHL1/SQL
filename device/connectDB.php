<?php

$db_host = '192.168.1.20';
$db_user = 'user'; //имя пользователя совпадает с именем БД
$db_password = 'user'; //пароль, указанный при создании БД
$database = 'device'; //имя БД, которое было указано при создании
$mysql = mysqli_connect($db_host, $db_user, $db_password, $database);

date_default_timezone_set("Europe/Moscow")
?>