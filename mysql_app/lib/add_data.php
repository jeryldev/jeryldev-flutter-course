<?php

	require 'connection.php';
	
	$title = $_POST['title'];
	$description= $_POST['description'];
	$downloadURL = $_POST['downloadURL'];
	$author= $_POST['author'];

	$conn->query("INSERT INTO researchpapers (title,description,downloadURL,author) VALUES ('".$title."','".$description."','".$downloadURL."','".$author."')")

?>