<?php
require 'connection.php';

$makeQuery = "SELECT * FROM mystore";

$statement = $connection -> prepare($makeQuery);

$statement->execute();

$myarray = array();

while ($resultsFrom = $statement -> fetch()){
    array_push(
        $myarray, array(
            'id'=> $resultsFrom['id'],
            'item_code'=> $resultsFrom['item_code'],
            'item_name'=> $resultsFrom['item_name'],
            'price'=> $resultsFrom['price'],
            'stock'=> $resultsFrom['stock']
        )
    );
}

echo json_encode($myarray);
?>
