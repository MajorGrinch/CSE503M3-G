<?php
session_start();
require 'database.php';
if(!hash_equals($_SESSION['token'], $_POST['token'])){
    die("Request forgery detected");
}
if(isset($_POST['story_id'])&&isset($_POST['story_title'])&&isset($_POST['story_content'])){
	$is_edit = false;
	$title = $_POST['story_title'];
    $content = $_POST['story_content'];
    $story_id = (int)$_POST['story_id'];
    $stmt = $mysqli->prepare("update stories set title=?, content=? where story_id=?");
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param("ssi", $title, $content, $story_id);
    if ($stmt->execute()) {
        $is_edit = true;
    }
    $stmt->close();
    if ($is_edit) {
        header("Location: showStory.php?id=$story_id");
    } else {
        die("Edit failed");
    }
}