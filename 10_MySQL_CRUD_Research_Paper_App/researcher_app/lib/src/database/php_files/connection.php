<?php

try{
    $conn = new PDO('mysql:host=localhost;dbname=flutterdatabase','root','');
    $conn ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
//    echo "yes success";
}catch(PDOException $exc){
    echo $exc ->getMessage();
    die("no failed");
}

?>