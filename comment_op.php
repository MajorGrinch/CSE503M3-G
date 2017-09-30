<?php
session_start();
require 'database.php';
if (isset($_POST['comment_input']) && isset($_POST['story_id'])) {
    $comment_input = $_POST['comment_input'];
    $userid        = (int) $_SESSION['userid'];
    $story_id      = (int) $_POST['story_id'];
    $stmt          = $mysqli->prepare("insert into comments
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

if (isset($_POST['comment_id']) && isset($_POST['op'])) {
    // $delete_comment = false;
    $comment_id = (int) $_POST['comment_id'];
    $op         = $_POST['op'];
    if ($op === 'delete') {
        $stmt = $mysqli->prepare("delete from comments where comment_id=?");
        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
            exit;
        }
        $stmt->bind_param("i", $comment_id);
        if ($stmt->execute()) {
            print("Delete Successfully!!!");
        } else {
            print("Delete Failed!!!");
        }
    } elseif ($op === 'edit') {
        $stmt    = $mysqli->prepare("update comments set content=? where comment_id=?");
        $content = $_POST['content'];
        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
            exit;
        }
        $stmt->bind_param("si", $content, $comment_id);
        if ($stmt->execute()) {
            print("Edit Successfully!!!");
        } else {
            print("Edit Failed!!!");
        }        
    }
    $stmt->close();
}
