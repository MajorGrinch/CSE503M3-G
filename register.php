<?php
session_start();
require 'database.php';
if (isset($_POST['username']) && isset($_POST['password'])) {
    $exc = false;
    $username = $_POST['username'];
    $password = $_POST['password'];
    if (!preg_match("/^(\w)+$/", $username) || !preg_match("/^(\w)+$/", $password)) {
        die("Invalid username or password");
    }
    $stmt = $mysqli->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param("ss", $username, password_hash($password, PASSWORD_BCRYPT));
    if ($stmt->execute()) {
        $exc = true;
    }
    $stmt->close();
    if ($exc) {
        echo "<script language=\"JavaScript\">
        alert(\"Sign up successfully!!!\");
        window.location.href=\"index.php\";
        </script>";
    }
}
