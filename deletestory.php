<?php
session_start();
if (!isset($_SESSION['userid'])) {
    header("Location: index.php");
    exit;
}
require 'database.php';
if (!hash_equals($_SESSION['token'], $_POST['token'])) {
    die("Request forgery detected");
}
if (isset($_POST['story_id'])) {
    
    $story_id  = (int)$_POST['story_id'];
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
        print("Delete successfully");
    }
    $stmt->close();
}
