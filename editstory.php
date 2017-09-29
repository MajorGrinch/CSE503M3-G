<?php
session_start();
if (!isset($_SESSION['userid'])) {
    header("Location: index.php");
}
require 'database.php';
$userid = $_SESSION['userid'];
if (isset($_GET['story_id'])) {
    $id = (int)$_GET['story_id'];
    $stmt = $mysqli->prepare("select title, content from stories where story_id=?");
    if (!$stmt) {
        printf("Query Prep Failed: %s\n", $mysqli->error);
        exit;
    }
    $stmt->bind_param('i', $id);
    $stmt->execute();
    $stmt->bind_result($title, $content);
    $stmt->fetch();
    $stmt->close();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kevin Miao Forum</title>
    <link rel="stylesheet" type="text/css" href="css/editstory.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>

</head>
<body>
    <div id="container">
        <div id="wrap-header">
            <h2>Edit your story</h2>
        </div>
        <div id="wrap-main">
        <form action="editstory_op.php" method="post">
            <div class="form-group">
                <label for="story_title">Title</label>
                <input type="text" name="story_title" class="form-control" id="story_title" value="<?php echo $title; ?>">
            </div>
            <div class="form-group">
                <label for="story_content">Content</label>
                <textarea class="form-control" name="story_content" id="story_content" rows="30"><?php echo $content; ?></textarea>
            </div>
            <input type="number" name="story_id" id="story_id" value="<?php echo $id ?>">
            <button type="submit" class="btn btn-primary">Confirm Edit</button>
        </form>
        <button class="btn btn-secondary" id="backtoindex">Back</button>
        </div>
    </div>
    <script type="text/javascript">
    $("#backtoindex").click(function(){
        window.location.href="index.php";
    });
    </script>
</body>
</html>