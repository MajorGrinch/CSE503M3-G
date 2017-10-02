<?php
session_start();
require 'database.php';

if (!isset($_SESSION['userid'])) {
    die("Not login");
}
if (!hash_equals($_SESSION['token'], $_POST['token'])) {
    die("Request forgery detected");
}

$userid = $_SESSION['userid'];
$stmt   = $mysqli->prepare("select story_id, title, issue_date, username, left(content,200) as depiction from stories join users on stories.userid=users.userid where stories.userid=? order by issue_date desc");
$stmt->bind_param("i", $userid);
if (!$stmt) {
    printf("Query Prep Failed: %s\n", $mysqli->error);
    exit;
}
$stmt->execute();
$result       = $stmt->get_result();
$result_array = array();
while ($row = $result->fetch_assoc()) {
    array_push($result_array, $row);
}
print(json_encode($result_array));
$stmt->close();
