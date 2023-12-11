<!DOCTYPE html>
<html style="font-size: 16px;" lang="ru">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Авторизация</title>
    <link rel="stylesheet" type="text/css" href="../static/css/style.css" media="screen">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=PT+Sans&display=swap" rel="stylesheet">
    
    <!-- <meta name="http-equiv=&quot;Content-Type&quot;" content="text/html; charset=utf-8"> -->
</head>
<body>
    <main>
        
        <?php
        session_start();
        $_SESSION["user_id"] = null;
        if (isset($_POST['login']) && isset($_POST['password'])){
            include 'connectDB.php';
//            $query = "SELECT * FROM users WHERE user_id = ".$_POST['login']." and  password =".$_POST['password']."";
            $query = "SELECT * FROM users WHERE login = ?";
            $stmt = mysqli_prepare($mysql ,$query);
            mysqli_stmt_bind_param($stmt, 's', $_POST['login']);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            if (mysqli_num_rows($result) > 0){
                $row = mysqli_fetch_assoc($result);
                if(password_verify($_POST["password"], $row["password"])){
                    $_SESSION["user_id"] = $row['user_id'];
                    header("Location: index.php");
                } else{
                    echo '<p>Неверный логин или пароль</p>';
                }
            } else {
                echo '<p>Неверный логин или пароль</p>';
            }
        }

        ?>


        <form method="POST">
            <input type="text" name="login"  class="input" placeholder="Логин">
            <input type="password" name="password"  class="input" placeholder="Пароль">
            <input type="submit" class="btn" value="Войти">
        </form>
    
    </main>


</body>
<script>
    </script>