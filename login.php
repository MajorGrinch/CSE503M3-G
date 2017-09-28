<?php
session_start();
require 'database.php';
if (isset($_POST['username']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $stmt = $mysqli->prepare("select userid, password from users where username=?");
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->bind_result($userid, $temp_password);
    $stmt->fetch();
    if ($temp_password === $password) {
        $_SESSION['user'] = $username;
        $_SESSION['userid'] = $userid;
    } else {
        die("password incorrect");
    }
    $stmt->close();
    header("Location: index.php");
}
