  <?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kevin Miao Forum</title>
    <link rel="stylesheet" type="text/css" href="css/mystyle.css"/>
    <!-- <script type="text/javascript" src="js/jquery-3.2.1.js"></script> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
    <script src="js/jquery-3.2.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</head>
<body>

    <div id="header">
        <?php if (isset($_SESSION['user'])): ?>
        <div id="welcome"><h1>Welcome, <?php echo $_SESSION['user'] ?></h1></div>
        <?php else: ?>
        <div id="welcome"><h1>Welcome to Kevin and Miao's News Forum</h1></div>
        <?php endif;?>
    </div>

    <div id="content" class="container-fluid">
        <div id="sidebar">
            <?php if (!isset($_SESSION['user'])): ?>
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
                <button type="button" class="btn btn-secondary" data-toggle="modal" data-target=".bs-example-modal-sm">Sign up</button>
            <?php else: ?>
                <div id="account_mgr" class="btn-group-vertical">
                    <button type="button" class="btn btn-secondary btn-lg" id="writestory">Write A Story</button>
                    <button type="button" class="btn btn-secondary btn-lg" id="allstories">All Stories</button>
                    <button type="button" class="btn btn-secondary btn-lg" id="man_my_stories">My Stories</button>
                    <button type="button" class="btn btn-secondary btn-lg" id="logout">Logout</button>
                </div>
            <?php endif;?>
            <?php
if (isset($_GET['logout'])) {
    unset($_SESSION['user']);
    unset($_SESSION['userid']);
    session_destroy();
    header("Location:index.php");
}
?>
        </div>
        <div id="news_list">
        <?php
require 'database.php';
$stmt = $mysqli->prepare("select story_id, title, issue_date, username, left(content,200) as depiction from stories join users on stories.userid=users.userid order by issue_date desc");

if (!$stmt) {
    printf("Query Prep Failed: %s\n", $mysqli->error);
    exit;
}
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {?>
                        <div class="card">
                        <div class="card-body">
                            <a href="showStory.php?id=<?php echo $row['story_id']; ?>"><h4 class="card-title"><?php echo $row["title"] ?></h4></a>
                            <h6 class="card-subtitle mb-2 text-muted"><?php echo $row["username"] ?></h6>
                            <h6 class="card-subtitle mb-2 text-muted"><?php echo $row["issue_date"] ?></h6>
                            <p><?php echo $row["depiction"] . "..." ?></p>
                        </div>
                      </div>
                    <?php
}
$stmt->close();
?>

        </div>
    </div>
    <div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Registration</h4>
                </div>
                <div class="modal-body">
                    <form name="reg-form" id="signup_form" action="register.php" method="post">
                        <div class="form-group">
                            <label for="username" class="control-label">Username:</label>
                            <input type="text" class="form-control" name="username" id="username"/>
                        </div>
                        <div class="form-group">
                            <label for="password" class="control-label">Password</label>
                            <input type="password" class="form-control" name="password" id="password"/>
                        </div>
                        <div class="form-group">
                            <label for="confirm_pwd" class="control-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirm_pwd" />
                        </div>
                        <div class="alert alert-warning alert-dismissible fade show" role="alert" id="confirmation_error">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                            Please re-enter the same in confirm password
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="signup_btn">Sign up</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        $("#logout").click(function(){
            window.location.href="index.php?logout";
        });
        $("#signup_btn").click( function(){
            if( $("#password").val() === $("#confirm_pwd").val()){
                $("#signup_form").submit();
            }else{
                $('.alert').show();
            }
        });
        $("#writestory").click(function(){
            window.location.href="writestory.php";
        });
        $("#man_my_stories").click(function(){
            var news_list = $("#news_list");
            $("#news_list").empty();
            $.ajax({
                type: "POST",
                url: "showmystory.php",
                data: "userid=" + "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>",
                success : function(data){
                    // $("#news_list").append(data);
                    // console.log(data);
                    var jsonobj = jQuery.parseJSON(data);
                    console.log(jsonobj);
                    jsonobj.forEach(function(news_item){
                        console.log(news_item);
                        news_list.append('<div class="card"><div class="card-body"><a href="showStory.php?id='+news_item['story_id']+'"><h4 class="card-title">'+news_item['title']+'</h4></a><h6 class="card-subtitle mb-2 text-muted">'+news_item['issue_date']+'</h6><h6 class="card-subtitle mb-2 text-muted">'+news_item['username']+'</h6><p>'+news_item['depiction']+'...</p></div></div>')
                    });
                }
            });
        });

        $("#allstories").click(function(){
            window.location.href="";
        });

        var sidebar = $("#sidebar");
        var offsetY = sidebar.offset().top;
    </script>
</body>
</html>