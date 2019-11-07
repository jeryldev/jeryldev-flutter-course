<?php
require 'connection.php';

$makeQuery = "SELECT * FROM researchpapers";

$statement = $conn -> prepare($makeQuery);

$statement->execute();

$myarray= array();

while ($resultsFrom = $statement -> fetch()){
    array_push(
        $myarray, array(
            'id'=> $resultsFrom['id'],
            'title'=> $resultsFrom['title'],
            'description'=> $resultsFrom['description'],
            'downloadURL'=> $resultsFrom['downloadURL'],
            'author'=> $resultsFrom['author'],
        )
    );
}

echo json_encode($myarray);
?>
