<?php

session_start();

$field = $_POST["types"];

$out = array();

foreach($field as $f) {
    $r = null;
    if(isset($_SESSION[$f])) {
        $r = $_SESSION[$f];
    }
    $out[$f] = $r;
}

echo json_encode($out);

?>