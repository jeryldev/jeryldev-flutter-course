<?php

	include 'connection.php';

	$id = $_POST['id'];
	$title = $_POST['title'];
	$description = $_POST['description'];
	$downloadURL = $_POST['downloadURL'];
	$author = $_POST['author'];

	$conn->query("UPDATE researchpapers SET title='".$title."', description='".$description."', downloadURL='".$downloadURL."', author='".$author."' WHERE id='".$id."'");

?>