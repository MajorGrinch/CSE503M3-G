<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kevin Miao Forum</title>
    <link rel="stylesheet" type="text/css" href="css/mainstory.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
    <script src="js/jquery-3.2.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>

</head>
<body>
    <div id="container">
        <div id="story">
            <?php
            require 'database.php';
            if (isset($_GET['id'])) {
                $id = (int)$_GET['id'];
                $stmt = $mysqli->prepare("select stories.userid as uid, title, issue_date, username, content 
                    from stories join users on stories.userid=users.userid
                    where story_id=?");
                if (!$stmt) {
                    printf("Query Prep Failed: %s\n", $mysqli->error);
                    exit;
                }
                $stmt->bind_param('i', $id);
                $stmt->execute();
                $stmt->bind_result($userid, $title, $issue_date, $username, $content);
                $stmt->fetch();
                $stmt->close();
            }
            ?>
            <div class="card">
                <div class="card-body">
                    <h1 class="card-title"><?php echo $title; ?></h1>
                    <br/>
                    <h6 class="card-subtitle mb-2 text-muted" id="author">Author: <?php echo $username; ?></h6>
                    <h6 class="card-subtitle mb-2 text-muted" id="issue_date">Issue date: <?php echo $issue_date; ?></h6>
                    <br/><br/>
                    <p class="card-text"><?php echo htmlentities($content); ?></p>
                    <div align="center">
                        <a href="index.php" class="card-link">Home</a>
                        <?php
                        if(isset($_SESSION['userid'])){
                            if($userid === $_SESSION['userid']){ ?>
                            <a href="editstory.php?story_id=<?php echo $id; ?>" class="card-link">Edit</a>
                            <a href="deletestory.php?story_id=<?php echo $id; ?>" class="card-link">Delete</a>
                        <?php
                            }
                        }
                        ?>
                    </div>
                </div>
            </div>
        </div>
        <div id="comment">
            <div id="comment_header">
                <button class="btn btn-primary">Comments</button>
                <button class="btn btn-primary" id="write_comment" onclick="write_comment()">Write My Comment</button>
            </div>
            <div id="my_comment">
                <form action="comment_op.php" method="post">
                    <div class="form-group">
                        <textarea class="form-control" name="comment_input" rows="5"></textarea>
                        <input name="story_id" value="<?php echo $id; ?>" id="storyid_input" />
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
            <div id="comment_body">
                <?php
                $stmt = $mysqli->prepare("select comment_id, username, content, comments.userid from comments join users on comments.userid=users.userid where story_id=?");
                if (!$stmt) {
                    printf("Query Prep Failed: %s\n", $mysqli->error);
                    exit;
                }
                $stmt->bind_param('i', $id);
                $stmt->execute();
                $stmt->bind_result($comment_id,$username, $content, $comment_uid);
                while ($stmt->fetch()) { ?>
                    <div class="card" id="comment_item">
                        <div class="card-body">
                        <h5 class="card-title"><?php echo $username; ?></h5>
                        <?php
                        if(isset($_SESSION['userid'])){
                            if(($userid === $_SESSION['userid']) || ($comment_uid === $_SESSION['userid']) ){ ?>
                            <a href="" class="card-link" id="comment_delete" val="<?php echo $comment_id; ?>">Delete</a>
                        <?php
                            }
                        }
                        ?>
                        <?php
                        if(isset($_SESSION['userid'])){
                            if($comment_uid === $_SESSION['userid']){ ?>
                            <a href="#" class="card-link" id="comment_edit" val="<?php echo $comment_id; ?>">Edit</a>
                        <?php
                            }
                        }
                        ?>
                        <p class="card-text"><?php echo $content; ?></p>
                        </div>
                    </div>
                <?php
                }
                ?>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    function write_comment(){
        var is_login = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1;?>";
        if( is_login == "-1" ){
            alert("Please sign in to comment!");
        }else{
            $("#my_comment").show();
        }
    }

    $('div[id*="comment_item"]').hover(function(){
        $(this).find("a").css("visibility", "visible");
        },function(){
        $(this).find("a").css("visibility", "hidden");
        }
    );
    $('a[id*="comment_delete"]').click(function(){
        var comment_id = $(this).attr('val');
        $.post("comment_op.php",{ comment_id: comment_id, op:'delete'})
            .done(function(data){
                alert(data);
            });
    });

    $('a[id*="comment_edit"]').click(function(){
        var comment_id = $(this).attr('val');
        var current_comment_item = $(this).parents("div[id='comment_item']");
        // current_comment_item.empty();
        var current_comment_content = current_comment_item.find("p").text();
        // alert(current_comment_content);
        current_comment_item.empty();
        current_comment_item.append("<textarea>"+current_comment_content+"</textarea>");
        current_comment_item.append('<button class="btn btn-secondary" id="edit_comment_btn">Submit</button>');
        current_comment_item.on('click', '#edit_comment_btn', function(){
            // alert(current_comment_item.find("textarea").val());
            $.post("comment_op.php", {comment_id: comment_id, op: 'edit', 
                content: current_comment_item.find("textarea").val() })
                .done(function(data){
                    alert(data);
                    window.location.href="";
                });
        });
    });


    </script>

</body>
</html>