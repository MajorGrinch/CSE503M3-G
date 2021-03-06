<?php
session_start();
require 'database.php';
require 'fieocheck.php';
$is_publish = false;
if (!isset($_SESSION['userid'])) {
    header("Location: index.php");
}
if(!hash_equals($_SESSION['token'], $_POST['token'])){
    die("Request forgery detected");
}
if (isset($_POST['story_title']) && isset($_POST['story_content'])) {
    $title = $_POST['story_title'];
    $content = $_POST['story_content'];
    if(!content_check($content) || !content_check($title)){
        echo "<script language=\"JavaScript\">
            alert(\"Publish failed! Check the input!\");
            window.location.href=\"index.php\";
            </script>";
        exit;
    }
    $userid = (int)$_SESSION['userid'];
    $stmt = $mysqli->prepare("insert into stories (title, userid, content) values (?, ?, ?)");
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param("sis", $title, $userid, $content);
    if ($stmt->execute()) {
        $is_publish = true;
    }
    $stmt->close();
    if ($is_publish) {
        header("Location: index.php");
    } else {
        echo "<script language=\"JavaScript\">
        alert(\"Publish failed!\");
        window.location.href=\"index.php\";
        </script>";
    }
}
