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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</head>
<body>
    
    <div id="header">
        <?php if (isset($_SESSION['user'])) : ?>
        <div id="welcome"><h1 class="display-3">Welcome, <?php echo $_SESSION['user'] ?></h1></div>
        <?php else : ?>
        <div id="welcome"><h1 class="display-3">Welcome to Kevin and Miao's News Forum</h1></div>
        <?php endif; ?>
    </div>

    <div id="content" class="container-fluid">
        <div id="sidebar">
            <?php if (!isset($_SESSION['user'])) :  ?>
                <form action="login.php" method="post">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" name="username" class="form-control" id="username" placeholder="username">
                    </div>
                    <div class="form-group">
                        <label for="passwordInput">Password</label>
                        <input type="password" name="password" class="form-control" id="passwordInput" placeholder="Password">
                    </div>
                    <button type="submit" class="btn btn-primary">Sign in</button>
                </form>
                <button type="button" class="btn btn-secondary" onclick="signup()">Sign up</button>
            <?php else : ?>
                <div id="account_mgr">
                    <ul id="mgr_list">
                        <li><?php echo $_SESSION['user']; ?></li>
                        <li><button id="mgr_item">My Stories</button></li>
                        <li><button id="mgr_item">Write A Story</button></li>
                    </ul>
                    <form action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>" method="get" align="center">
                        <input type="submit" name="logout" value="logout" class="btn btn-primary"/>
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
            $stmt = $mysqli->prepare("select story_id, title, issue_date, username, left(content,200) as depiction from stories join users on stories.userid=users.userid");
            if (!$stmt) {
                printf("Query Prep Failed: %s\n", $mysqli->error);
                exit;
            }
            $stmt->execute();
            $result = $stmt->get_result();
            while ($row = $result->fetch_assoc()) { ?>
                <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><?php echo $row["title"] ?></h4>
                    <h6 class="card-subtitle mb-2 text-muted"><?php echo $row["username"] ?></h6>
                    <h6 class="card-subtitle mb-2 text-muted"><?php echo $row["issue_date"] ?></h6>
                    <p><?php echo $row["depiction"]."..." ?></p>
                </div>
              </div>
            <?php
            }
                $stmt->close();
            ?>

        </div>
    </div>
    <div id="signup_page" display>
        <input type="text" name="username"/>
        <input type="password" name="password"/>
        <input type="submit" value="Sign up">
    </div>
    <script type="text/javascript">
        function signup(){
            $("#signup_page").css('visibility', 'visible');
        }
        $("#signup").keyup(function(event){ 
            if(event.which=='27'){ 
                $("#signup_page").css('visibility', 'hidden');
            } 
        });
    </script>
</body>
</html>