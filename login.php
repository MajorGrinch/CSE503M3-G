<?php
if (isset($_POST['username']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $mysqli = new mysqli('localhost', 'root', 'toor', 'news');
    $stmt = $mysqli->prepare("select password from users where username=?");
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->bind_result($temp_password);
    $stmt->fetch();
    if ($temp_password === $password) {
        $_SESSION['user'] = $username;
        header("Location: index.php");
    }
    $stmt->close();
}
