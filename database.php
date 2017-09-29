<?php

$mysqli = new mysqli('127.0.0.1', 'root', 'Aptx4869!!', 'news');

if ($mysqli->connect_errno) {
    printf("Connection Failed: %s\n", $mysqli->connect_error);
    exit;
}
