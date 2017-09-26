<?php

$mysqli = new mysqli('localhost', 'root', 'toor', 'news');

if ($mysqli->connect_errno) {
    printf("Connection Failed: %s\n", $mysqli->connect_error);
    exit;
}
