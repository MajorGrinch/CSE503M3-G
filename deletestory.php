<?php
session_start();
if (!isset($_SESSION['userid'])) {
    header("Location: index.php");
    exit;
}
require 'database.php';
if (isset($_GET['story_id'])) {
    $is_delete = false;
    $story_id  = (int)$_GET['story_id'];
    $uid       = $_SESSION['userid'];
    $stmt      = $mysqli->prepare("select userid from stories where story_id=?");
    if (!$stmt) {
        printf("Query Prep Failed1: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param('i', $story_id);
    $stmt->execute();
    $stmt->bind_result($userid);
    $stmt->fetch();
    $stmt->close();
    if ($uid !== $userid) {
        $stmt->close();
        echo "Get out! You attacker!";
        exit;
    }
    $stmt = $mysqli->prepare("delete from stories where story_id=?");
    if (!$stmt) {
        printf("Query Prep Failed2: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param('i', $story_id);
    if ($stmt->execute()) {
        $is_delete = true;
    }
    if ($is_delete) {
        echo "<script language=\"JavaScript\">
        alert(\"Delete successfully!!!\");
        window.location.href=\"index.php\";
        </script>";
    }
    $stmt->close();
}
