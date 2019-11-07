<?php

	include 'connection.php';
	
	$id = $_POST['id'];
	$item_code = $_POST['item_code'];
	$item_name = $_POST['item_name'];
	$price = $_POST['price'];
	$stock= $_POST['stock'];
	
	$connection->query("UPDATE mystore SET item_code='".$item_code."', item_name='".$item_name."', price='".$price."', stock='".$stock."' WHERE id='".$id."'");

?>