<?php

	require 'connection.php';
	
	$item_code = $_POST['item_code'];
	$item_name = $_POST['item_name'];
	$price = $_POST['price'];
	$stock= $_POST['stock'];
	
	$connection->query("INSERT INTO mystore(item_code,item_name,price,stock) VALUES ('".$item_code."','".$item_name."','".$price."','".$stock."')")

?>