<?php
include 'connectDB.php';

if (isset($_GET["ID"])) { //Если запрос от устройства содержит идентификатор
    if (isset($_GET['login']) && isset($_GET["password"])) {
        $query = "SELECT * FROM DEVICE_TABLE WHERE DEVICE_ID= ? AND device_login= ?";
        $stmt = mysqli_prepare($mysql, $query);
        mysqli_stmt_bind_param($stmt, 'is', $_GET["ID"], $_GET['login']);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        if (mysqli_num_rows($result) == 1 && password_verify($_GET["password"],mysqli_fetch_assoc($result)['DEVICE_PASSWORD'])) { //Если найдено устройство с таким ID в БД

            if (isset($_GET['Rele'])) { //Если устройство передало новое состояние реле
//проверяем есть ли в БД предыдущее значение этого параметра
                $date_today = date("Y-m-d H:i:s"); //текущее время
                $query = "SELECT OUT_STATE FROM OUT_STATE_TABLE WHERE DEVICE_ID = ?";
                $stmt = mysqli_prepare($mysql, $query);
                mysqli_stmt_bind_param($stmt, 'i', $_GET["ID"]);
                mysqli_stmt_execute($stmt);
                $result = mysqli_stmt_get_result($stmt);

                if (mysqli_num_rows($result) == 1) {
                    $query = "UPDATE OUT_STATE_TABLE SET OUT_STATE= ?, DATE_TIME='$date_today' WHERE DEVICE_ID = ?";
                    $stmt = mysqli_prepare($mysql, $query);
                    mysqli_stmt_bind_param($stmt, 'ii', $_GET["Rele"], $_GET["ID"]);
                    mysqli_stmt_execute($stmt);
                } else {
                    $query = "INSERT OUT_STATE_TABLE SET DEVICE_ID= ?, OUT_STATE= ?, DATE_TIME='$date_today'";
                    $stmt = mysqli_prepare($mysql, $query);
                    mysqli_stmt_bind_param($stmt, 'ii', $_GET["ID"], $_GET["Rele"]);
                    mysqli_stmt_execute($stmt);
                }
            }

            if (isset($_GET['Temp'])) { //Если устройство передало новое значение температуры
//проверяем есть ли в БД предыдущее значение этого параметра
                $query = "SELECT TEMPERATURE FROM TEMPERATURE_TABLE WHERE DEVICE_ID= ?";
                $stmt = mysqli_prepare($mysql, $query);
                mysqli_stmt_bind_param($stmt, 'i', $_GET["ID"]);
                mysqli_stmt_execute($stmt);
                $result = mysqli_stmt_get_result($stmt);
                if (mysqli_num_rows($result) == 1) {
                    $query = "UPDATE TEMPERATURE_TABLE SET TEMPERATURE= ?, DATE_TIME='$date_today' WHERE DEVICE_ID = ?";
                    $stmt = mysqli_prepare($mysql, $query);
                    mysqli_stmt_bind_param($stmt, 'ii', $_GET["Temp"], $_GET["ID"]);
                    mysqli_stmt_execute($stmt);
                } else {
                    $date_today = date("Y-m-d H:i:s"); //текущее время
                    $query = "INSERT TEMPERATURE_TABLE SET DEVICE_ID= ?, TEMPERATURE= ?, DATE_TIME='$date_today'";
                    $stmt = mysqli_prepare($mysql, $query);
                    mysqli_stmt_bind_param($stmt, 'ii', $_GET["ID"], $_GET["Temp"]);
                    mysqli_stmt_execute($stmt);
                }
            }

//Достаём из БД текущую команду управления реле
            $query = "SELECT * FROM command_table
                        WHERE DEVICE_ID = ?
                        ORDER BY DATE_TIME DESC, id DESC
                        LIMIT 1;";
            $stmt = mysqli_prepare($mysql, $query);
            mysqli_stmt_bind_param($stmt, 'i', $_GET["ID"]);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            $Command = -1;
            if (mysqli_num_rows($result) == 1) { //Если в таблице есть данные для этого устройства
                $Arr = mysqli_fetch_array($result);
                $Command = $Arr['COMMAND'];
            }

//Отвечаем на запрос текущей командой
            if ($Command != -1) //Есть данные для этого устройства
            {
                echo "COMMAND $Command EOC";
            } else {
                echo "COMMAND ? EOC";
            }
        } else {
            echo "Устройство не найдено или логин/пароль не верен";
        }
    } else {
        echo "Нету логина и пароля устройства!";
    }

}
mysqli_close($mysql);

?>