<!DOCTYPE html>
<html style="font-size: 16px;" lang="ru">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Color</title>
    <link rel="stylesheet" type="text/css" href="main.css" media="screen">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=PT+Sans&display=swap" rel="stylesheet">

</head>
<?php
    include 'connectDB.php';

    $result1 = mysqli_query($mysql, "SELECT * FROM `colors_1` WHERE cluster=1");
    $result2 = mysqli_query($mysql, "SELECT * FROM `colors_1` WHERE cluster=2");
    $result3 = mysqli_query($mysql, "SELECT * FROM `colors_1` WHERE cluster=3");
    $result4 = mysqli_query($mysql, "SELECT * FROM `colors_1` WHERE cluster=4");
    $result5 = mysqli_query($mysql, "SELECT * FROM `colors_1` WHERE cluster=5");
    $result_cluster = mysqli_query($mysql, "SELECT DISTINCT cluster FROM `colors_1` order by cluster");


?>
<body>

<main>
    <table>
        <thead>
            <?php
                while ($name = mysqli_fetch_assoc($result_cluster)){
                    echo '<th scope="col">'.$name["cluster"].'</th>';
                }

            ?>
        </thead>
        <tbody>
            <?php
            $i = 0;
            while ($i <= 68){
                $name1 = mysqli_fetch_assoc($result1);
                $name2 = mysqli_fetch_assoc($result2);
                $name3 = mysqli_fetch_assoc($result3);
                $name4 = mysqli_fetch_assoc($result4);
                $name5 = mysqli_fetch_assoc($result5);
                if(!isset($name1)){
                    $name1["r"] = 255;
                    $name1["g"] = 255;
                    $name1["b"] = 255;
                }
                if(!isset($name2)){
                    $name2["r"] = 255;
                    $name2["g"] = 255;
                    $name2["b"] = 255;
                }
                if(!isset($name3)){
                    $name3["r"] = 255;
                    $name3["g"] = 255;
                    $name3["b"] = 255;
                }
                if(!isset($name4)){
                    $name4["r"] = 255;
                    $name4["g"] = 255;
                    $name4["b"] = 255;
                }
                if(!isset($name5)){
                    $name5["r"] = 255;
                    $name5["g"] = 255;
                    $name5["b"] = 255;
                }
                $i += 1;
                echo '<tr>
//                    <td><div style="background-color: rgb('.$name1["r"].', '.$name1["g"].', '.$name1["b"].'); width: 50px; height: 50px;"></div></td>
//                    <td><div style="background-color: rgb('.$name2["r"].', '.$name2["g"].', '.$name2["b"].'); width: 50px; height: 50px;"></div></td>
//                    <td><div style="background-color: rgb('.$name3["r"].', '.$name3["g"].', '.$name3["b"].'); width: 50px; height: 50px;"></div></td>
//                    <td><div style="background-color: rgb('.$name4["r"].', '.$name4["g"].', '.$name4["b"].'); width: 50px; height: 50px;"></div></td>
//                    <td><div style="background-color: rgb('.$name5["r"].', '.$name5["g"].', '.$name5["b"].'); width: 50px; height: 50px;"></div></td>
                     <td><div style="background-color: rgb('.(0.299*$name1["r"] + 0.587*$name1["g"] + 0.114*$name1["b"]).', '.(0.299*$name1["r"] + 0.587*$name1["g"] + 0.114*$name1["b"]).', '.(0.299*$name1["r"] + 0.587*$name1["g"] + 0.114*$name1["b"]).'); width: 50px; height: 50px;"></div></td>
                    <td><div style="background-color: rgb('.(0.299*$name2["r"] + 0.587*$name2["g"] + 0.114*$name2["b"]).', '.(0.299*$name2["r"] + 0.587*$name2["g"] + 0.114*$name2["b"]).', '.(0.299*$name2["r"] + 0.587*$name2["g"] + 0.114*$name2["b"]).'); width: 50px; height: 50px;"></div></td>
                    <td><div style="background-color: rgb('.(0.299*$name3["r"] + 0.587*$name3["g"] + 0.114*$name3["b"]).', '.(0.299*$name3["r"] + 0.587*$name3["g"] + 0.114*$name3["b"]).', '.(0.299*$name3["r"] + 0.587*$name3["g"] + 0.114*$name3["b"]).'); width: 50px; height: 50px;"></div></td>
                    <td><div style="background-color: rgb('.(0.299*$name4["r"] + 0.587*$name4["g"] + 0.114*$name4["b"]).', '.(0.299*$name4["r"] + 0.587*$name4["g"] + 0.114*$name4["b"]).', '.(0.299*$name4["r"] + 0.587*$name4["g"] + 0.114*$name4["b"]).'); width: 50px; height: 50px;"></div></td>
                    <td><div style="background-color: rgb('.(0.299*$name5["r"] + 0.587*$name5["g"] + 0.114*$name5["b"]).', '.(0.299*$name5["r"] + 0.587*$name5["g"] + 0.114*$name5["b"]).', '.(0.299*$name5["r"] + 0.587*$name5["g"] + 0.114*$name5["b"]).'); width: 50px; height: 50px;"></div></td>
                    
</tr>';
            }

            ?>
        </tbody>
    </table>

</main>

</body>

</html>
