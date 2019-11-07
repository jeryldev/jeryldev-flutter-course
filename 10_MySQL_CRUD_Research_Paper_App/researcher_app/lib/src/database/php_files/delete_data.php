<?php
	require 'connection.php';
	$id=$_POST['id'];
	$conn->query("DELETE FROM researchpapers WHERE id='".$id."'");

?>