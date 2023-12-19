<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href = "style.css" type="text/css">
    <title>MyApp</title>
</head>

<?php
session_start();
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
} else {
    if ($_SESSION["user_id"] == null) {
        header("Location: login.php");
    }
}


include 'connectDB.php';
if (isset($_POST["history"])) {
    $query = "CALL returnHistory(?, ?)";
    $stmt = mysqli_prepare($mysql, $query);
    mysqli_stmt_bind_param($stmt, 'ii', $_POST["history"], $_SESSION["user_id"]);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    echo "<table>
    <thead>
        <tr>
            <th>Тип</th>
            <th>Значение</th>
            <th>Дата и время</th>
            <th>Исполнитель</th>
            <th>Наименование исполнителя</th>
        </tr>
    </thead>
    <tbody>


";
    mysqli_stmt_execute()
    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr>
            <td>" .$row['type']. "</td>
            <td>" .$row['value']. "</td>
            <td>" .$row['dateTime']. "</td>
            <td>" .$row['user']. "</td>
            <td>" .$row['userName']. "</td>
            </tr>
";
    }
    echo "</tbody>";
    echo '
    <form action="index.php">
    <input type="submit" value="Назад">
</form>
    
    ';
}

























?>

</html>
