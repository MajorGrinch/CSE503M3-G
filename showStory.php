<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kevin Miao Forum</title>
    <link rel="stylesheet" type="text/css" href="css/mainstory.css"/>
</head>
<body>
    <div id="content">
        <div id="story">
            <?php
            require 'database.php';
            if (isset($_GET['id'])) {
                $id = (int)$_GET['id'];
                $stmt = $mysqli->prepare("select title, issue_date, username, content 
                    from stories join users on stories.userid=users.userid
                    where story_id=?");
                if (!$stmt) {
                    printf("Query Prep Failed: %s\n", $mysqli->error);
                    exit;
                }
                            $stmt->bind_param('i', $id);
                            $stmt->execute();
                            $stmt->bind_result($title, $issue_date, $username, $content);
                            $stmt->fetch();
                            printf("<h1>%s</h1>\n
                        <h4>Author: %s &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                        &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                        &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                        Date: %s</h4>\n
                        <p>%s</p>", $title, $username, $issue_date, $content );
            }
            ?>
        </div>
    </div>

</body>
</html>