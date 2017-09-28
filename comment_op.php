<?php
session_start();
require 'database.php';
if ($_POST['comment_input']&&$_POST['story_id']) {
    $comment_input = $_POST['comment_input'];
    $userid = (int)$_SESSION['userid'];
    $story_id = (int)$_POST['story_id'];
    $stmt = $mysqli->prepare("insert into comments 
                             (content,userid,type,story_id) 
                             values (?, ?, 0, ?)");
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param("sii", $comment_input, $userid, $story_id);
    $stmt->execute();
    $stmt->close();
    header("Location: showStory.php?id=$story_id");
}
