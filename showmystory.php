<?php
session_start();
require 'database.php';
if(isset($_POST['userid'])) {
    $userid = (int) $_POST['userid'];
    $stmt   = $mysqli->prepare("select story_id, title, issue_date, username, left(content,200) as depiction from stories join users on stories.userid=users.userid where stories.userid=? order by issue_date desc");
    $stmt->bind_param("i", $userid);
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->execute();
    $stmt->bind_result($story_id, $title, $issue_date, $username, $depiction);
    while ($stmt->fetch()) {
        printf('<div class="card">
                        <div class="card-body">
                            <a href="showStory.php?id=%s"><h4 class="card-title">%s</h4></a>
                            <h6 class="card-subtitle mb-2 text-muted">%s</h6>
                            <h6 class="card-subtitle mb-2 text-muted">%s</h6>
                            <p>%s...</p>
                        </div>
                      </div>', htmlspecialchars($story_id), htmlspecialchars($title),
            htmlspecialchars($issue_date), htmlspecialchars($username), htmlspecialchars($depiction));
    }
}
