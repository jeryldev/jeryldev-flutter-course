<?php
	require 'connection.php';
	$id=$_POST['id'];
	$connection->query("DELETE FROM mystore WHERE id='".$id."'");

?>