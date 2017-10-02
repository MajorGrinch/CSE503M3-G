<?php
session_start();
require 'database.php';
require 'fieocheck.php';
function csrf_check()
{
    if (!hash_equals($_SESSION['token'], $_POST['token'])) {
        die("Request forgery detected");
    }
}

if (isset($_POST['comment_input']) && isset($_POST['story_id'])) {
    csrf_check();
    $comment_input = $_POST['comment_input'];
    if(!content_check($comment_input)){
        echo "<script language=\"JavaScript\">
            alert(\"Comment failed! Check the input!\");
            window.history.go(-1);
            </script>";
        exit;
    }
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
    csrf_check();
    $comment_id = (int) $_POST['comment_id'];
    $op         = $_POST['op'];
    if ($op === 'delete') {
        csrf_check();
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
    }
    if ($op === 'edit') {
        csrf_check();
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
    if ($op === 'agree') {
        csrf_check();
        $userid = $_SESSION['userid'];

        $check_dup = $mysqli->prepare("select count(*) from agreetb where comment_id=? and userid=?");
        if (!$check_dup) {
            printf("Query prep failed: %s", $mysqli->error);
        }
        $check_dup->bind_param("ii", $comment_id, $userid);
        $check_dup->execute();
        $check_dup->bind_result($record_num);
        $check_dup->fetch();
        if ($record_num === 1) {
            print(-1);
            $check_dup->close();
            exit;
        }
        $check_dup->close();

        $pre_stmt = $mysqli->prepare("insert into agreetb (comment_id, userid, agreed) values (?, ?, 1)");
        if (!$pre_stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $pre_stmt->bind_param("ii", $comment_id, $userid);
        $pre_stmt->execute();
        $pre_stmt->close();

        $stmt = $mysqli->prepare("update comments set agree=agree+1 where comment_id=?");

        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $stmt->bind_param("i", $comment_id);
        if ($stmt->execute()) {
            $stmt_new = $mysqli->prepare("select agree from comments where comment_id=?");
            if (!$stmt_new) {
                printf("Query Prep Failed: %s\n", $mysqli->error);
            }
            $stmt_new->bind_param("i", $comment_id);
            $stmt_new->execute();
            $stmt_new->bind_result($agree);
            $stmt_new->fetch();
            print($agree);
            $stmt_new->close();
        } else {
            print('Failed to agree');
        }
    }
    if ($op === 'oppose') {

        $userid = $_SESSION['userid'];
        csrf_check();
        $check_dup = $mysqli->prepare("select count(*) from agreetb where comment_id=? and userid=?");
        if (!$check_dup) {
            printf("Query prep failed: %s", $mysqli->error);
        }
        $check_dup->bind_param("ii", $comment_id, $userid);
        $check_dup->execute();
        $check_dup->bind_result($record_num);
        $check_dup->fetch();
        if ($record_num === 1) {
            print(-1);
            $check_dup->close();
            exit;
        }
        $check_dup->close();

        $pre_stmt = $mysqli->prepare("insert into agreetb (comment_id, userid, agreed) values (?, ?, 0)");
        if (!$pre_stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $pre_stmt->bind_param("ii", $comment_id, $userid);
        $pre_stmt->execute();
        $pre_stmt->close();

        $stmt = $mysqli->prepare("update comments set oppose=oppose+1 where comment_id=?");

        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $stmt->bind_param("i", $comment_id);
        if ($stmt->execute()) {
            $stmt_new = $mysqli->prepare("select oppose from comments where comment_id=?");
            if (!$stmt_new) {
                printf("Query Prep Failed: %s\n", $mysqli->error);
            }
            $stmt_new->bind_param("i", $comment_id);
            $stmt_new->execute();
            $stmt_new->bind_result($oppose);
            $stmt_new->fetch();
            print($oppose);
            $stmt_new->close();
        } else {
            print('Failed to oppose');
        }
    }

    if ($op === 'check_record') {
        // csrf_check();
        $userid = (int) $_POST['userid'];
        $stmt   = $mysqli->prepare("select count(*) from agreetb where comment_id=? and userid=?");
        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $stmt->bind_param("ii", $comment_id, $userid);
        $stmt->execute();
        $stmt->bind_result($record_num);
        $stmt->fetch();
        print($record_num);
    }

    if ($op === 'reply_comment') {
        csrf_check();
        if (!isset($_SESSION['userid'])) {
            print(-1);
            exit;
        }
        $content = $_POST['content'];
        if(!content_check($content)){
            die("invalid input");
            exit;
    }
        $userid  = $_SESSION['userid'];
        $stmt    = $mysqli->prepare("insert into comments (content, userid, type, link_comment)
                                    values (?,?, 1, ?)");
        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $stmt->bind_param("sii", $content, $userid, $comment_id);
        if ($stmt->execute()) {

            $stmt_new = $mysqli->prepare("select count(*) from comments where link_comment=?");
            if (!$stmt_new) {
                printf("Query Prep Failed: %s\n", $mysqli->error);
            }
            $stmt_new->bind_param("i", $comment_id);
            $stmt_new->execute();
            $stmt_new->bind_result($record_num);
            $stmt_new->fetch();
            print($record_num);
            $stmt_new->close();
        }
    }
    if ($op === 'check_reply_num') {
        $stmt = $mysqli->prepare("select count(*) from comments where link_comment=?");
        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $stmt->bind_param("i", $comment_id);
        $stmt->execute();
        $stmt->bind_result($record_num);
        $stmt->fetch();
        print($record_num);
    }

    if ($op === 'get_replies') {
        csrf_check();
        $stmt = $mysqli->prepare("select username, content, comment_date from comments join users on comments.userid=users.userid where link_comment=?");
        if (!$stmt) {
            printf("Query Prep Failed: %s\n", $mysqli->error);
        }
        $stmt->bind_param("i", $comment_id);
        $stmt->execute();
        $result_array = array();
        $result       = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            array_push($result_array, $row);
        }
        print(json_encode($result_array));
    }
    $stmt->close();
}
