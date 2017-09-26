<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kevin Miao Forum</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css"/>
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
</head>
<body>
    
    <div id="header">
        <?php if (isset($_SESSION['user'])) : ?>
        <div id="welcome"><h1>Welcome, <?php echo $_SESSION['user'] ?></h1></div>
        <?php else : ?>
        <div id="welcome"><h1>Welcome to Kevin and Miao's News Forum</h1></div>
        <?php endif; ?>
    </div>

    <div id="content">
        <div id="sidebar">
            <?php if (!isset($_SESSION['user'])) :  ?>
                <form action="login.php" method="post">
                    <input type="text" name="username" placeholder="username" class="sidebarinput"/>
                    <br/><br/>
                    <input type="password" name="password" placeholder="password" class="sidebarinput"/>
                    <br/><br/>
                    <input type="submit" value="Sign in" class="submit"/>
                </form>
            <?php else : ?>
                <div id="account_mgr">
                    <ul id="mgr_list">
                        <li><?php echo $_SESSION['user']; ?></li>
                        <li><button id="mgr_item">My Stories</button></li>
                        <li><button id="mgr_item">Write A Story</button></li>
                    </ul>
                    <form action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>" method="get" align="center">
                        <input type="submit" name="logout" value="logout" class="logout"/>
                    </form>
                </div>
            <?php endif; ?>
            <?php
            if (isset($_GET['logout'])) {
                unset($_SESSION['user']);
                header("Location:index.php");
            }
            ?>
        </div>
        <div id="news_list">
            <?php
            require 'database.php';
            $stmt = $mysqli->prepare("select story_id, title, issue_date, username, left(content,200) from stories join users on stories.userid=users.userid");
            if (!$stmt) {
                printf("Query Prep Failed: %s\n", $mysqli->error);
                exit;
            }
            $stmt->execute();
            $stmt->bind_result($story_id, $title, $issue_date, $username, $content);
            echo "<ul>\n";
            while ($stmt->fetch()) {
                printf("<li>\n
                <div class=\"wrap\">\n
                <a href=\"showStory.php?id=%d\"><h2>%s</h2></a>\n
                <h4>Author: %s &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                &emsp; Date: %s</h4>\n
                <p>%s</p>\n
                </div>\n
                </li>\n", $story_id, htmlspecialchars($title), htmlspecialchars($username),
                    htmlspecialchars($issue_date), htmlspecialchars($content)
                );
            }
            echo "</ul>\n";
            $stmt->close();
            ?>
            <ul>
                <li>
                    <div class="wrap">
                        <h2>Big news!</h2>
                        <h4>Author: Kevin &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Date: 2017-09-20</h4>
                        <p>Israeli police and medical services say an attacker has opened fire at the entrance to a town outside Jerusalem, killing three Israelis.
                        Police spokesman Micky Rosenfeld says the attack took place early on Tuesday just outside the community of Had Adar.
                        There was no word yet on the identity of the attacker but Rosenfeld says it's being treated as a terrorist attack. The Magen David Adom medical service says fourth Israeli is in critical condition...</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>