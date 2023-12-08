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
        
        if (isset($_POST['login']) && isset($_POST['password'])){
            include 'connectDB.php';
            $query = "SELECT * FROM users
            WHERE user_id = ".$_POST['login']." and  password =".$_POST['password']."";
            $result = mysqli_query($mysql, $query);
            if (mysqli_num_rows($result) > 0){
                session_start();
                $row = mysqli_fetch_assoc($result);
                $_SESSION["user_id"] = $row['user_id'];
                header("Location: index.php");
            } else {
                echo '<p>Неверный логин или пароль</p>';
            }
        }

        ?>


        <form>
            <input type="text" name="login"  class="input" placeholder="Логин">
            <input type="password" name="password"  class="input" placeholder="Пароль">
            <input type="submit" class="btn" value="Войти">
            <input type="button" class="btn" id='reg' onClick="register();" value="Зарегистрироваться">
        </form>
    
    </main>


</body>
<script>


function register(){
    
    window.location.replace('registration.php');;
}
    </script>