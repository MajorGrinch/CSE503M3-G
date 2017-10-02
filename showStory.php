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
                $id   = (int) $_GET['id'];
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
                    <h1 class="card-title"><?php printf($title);?></h1>
                    <br/>
                    <h6 class="card-subtitle mb-2 text-muted" id="author">Author: <?php printf($username);?></h6>
                    <h6 class="card-subtitle mb-2 text-muted" id="issue_date">Issue date: <?php printf($issue_date);?></h6>
                    <br/><br/>
                    <p class="card-text"><?php print(htmlspecialchars($content));?></p>
                    <div align="center">
                        <a href="index.php" class="card-link"><b>Home</b></a>
                        <?php
                        if (isset($_SESSION['userid'])) {
                            if ($userid === $_SESSION['userid']) {?>
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
                    <input type="hidden" name="token" value="<?php echo $_SESSION['token'];?>" />
                    <div class="form-group">
                        <textarea class="form-control" name="comment_input" rows="5"></textarea>
                        <input name="story_id" value="<?php echo $id; ?>" id="storyid_input" />
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
            <div id="comment_body">
                <?php
                $stmt = $mysqli->prepare("select comment_id, username, content, agree, oppose, comments.userid from comments join users on comments.userid=users.userid where story_id=?");
                if (!$stmt) {
                    printf("Query Prep Failed: %s\n", $mysqli->error);
                    exit;
                }
                $stmt->bind_param('i', $id);
                $stmt->execute();
                $stmt->bind_result($comment_id, $username, $content, $agree, $oppose, $comment_uid);
                while ($stmt->fetch()) {
                ?>
                <div class="card" id="comment_item" val="<?php echo $comment_id ?>">
                    <div class="card-body">
                        <h5 class="card-title"><?php printf(htmlspecialchars($username));?></h5>
                        <?php
                        if (isset($_SESSION['userid'])) {
                            if (($userid === $_SESSION['userid']) || ($comment_uid === $_SESSION['userid'])) {?>
                                <a href="" class="card-link" id="comment_delete">Delete</a>
                            <?php
                            }
                        }
                        ?>
                        <?php
                        if (isset($_SESSION['userid'])) {
                            if ($comment_uid === $_SESSION['userid']) {?>
                                <a href="#/" class="card-link" id="comment_edit">Edit</a>
                        <?php
                            }
                        }
                        ?>
                        <p class="card-text" id="comment_content"><?php printf(htmlspecialchars($content));?></p>
                        <img src="image/agree.png" val="0" alt="agree" id="agree_btn" width="20px" height="20px"/>
                        <label id="agree_num" for="agree_btn"><?php printf(htmlspecialchars($agree));?></label>
                        <img src="image/oppose.png" val="0" alt="oppose" id="oppose_btn" width="20px" height="20px"/>
                        <label id="oppose_num" for="oppose_btn"><?php printf(htmlspecialchars($oppose));?></label>
                        <a href="javascript:void(0);" id="reply_comment_btn">Reply</a>
                        <a href="javascript:void(0)" id="check_all_replies_btn">All Replies</a>
                        <label for="check_all_replies_btn" id="reply_num"></label>
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
        var is_login = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>";
        if( is_login == "-1" ){
            alert("Please sign in to comment!");
        }else{
            $("#my_comment").show();
            var my_comment = $("#my_comment");
            $(window).scrollTop(my_comment.offset().top-300);
        }
    }

    function get_comment_id(node){
        var current_comment_item = node.parents("div[id='comment_item']");
        var comment_id = current_comment_item.attr('val');
        return comment_id;
    }

    $('div[id*="comment_item"]').hover(function(){
        $(this).find("a.card-link").css("visibility", "visible");
        // $(this).find("#reply_num").css("visibility", "visible");
        },function(){
        $(this).find("a.card-link").css("visibility", "hidden");
        // $(this).find("#reply_num").css("visibility", "hidden");
        }
    );
    $('a[id*="comment_delete"]').click(function(){
        var comment_id = get_comment_id($(this));
        $.post("comment_op.php",{ comment_id: comment_id, op:'delete', token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>"})
            .done(function(data){
                alert(data);
            });
    });

    var reply_btn_clicks = 0;
    $('a[id*="reply_comment_btn"]').click(function(){
        if(reply_btn_clicks == 0){
            var is_login = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>";
            if( is_login == "-1" ){
                alert("Please sign in to reply!");
                return;
            }
            var comment_id = get_comment_id($(this));
            var current_comment_item = $(this).parents("div[id='comment_item']");
            var reply_num_label = current_comment_item.find("#reply_num");
            current_comment_item.append('<textarea rows="4" id="reply_content"></textarea>');
            current_comment_item.append('<button class="btn btn-secondary" id="reply_comment_submit">reply</button>');
            current_comment_item.on('click', '#reply_comment_submit', function(){
                $.post("comment_op.php",
                    {comment_id: comment_id, op:'reply_comment', content: current_comment_item.find("textarea").val(), token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>" })
                    .done(function(data){
                        console.log(data);
                        if(data == -1){
                            alert("Please login to reply!");
                        }
                        window.location.href="#/";
                        $("#reply_content").remove();
                        $("#reply_comment_submit").remove();
                        reply_num_label.text(data);
                    });
            });
            reply_btn_clicks++;
        }else{
            reply_btn_clicks = 0;
            $("#reply_content").remove();
            $("#reply_comment_submit").remove();
        }
    });

    $('img[id*="agree_btn"]').click(function(){
        var is_login = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>";
        if( is_login == "-1" ){
            alert("Please sign in to agree!");
            return;
        }
        var val = parseInt($(this).attr('val'));
        if(val == 1){
            return;
        }
        var image = $(this);
        var comment_id = get_comment_id($(this));
        var current_comment_item = $(this).parents("div[id='comment_item']");
        var agree_num_label = current_comment_item.find("#agree_num");
         $.post("comment_op.php", {comment_id: comment_id, op: 'agree',token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>"})
            .done(function(data){
                // alert(agree_num_p);
                if(data==-1){
                    return;
                }
                agree_num_label.text(data);
                image.attr('src', 'image/agreed.png');
            });
    });

    $('img[id*="oppose_btn"]').click(function(){
        var is_login = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>";
        if( is_login == "-1" ){
            alert("Please sign in to oppose!");
            return;
        }
        var val = parseInt($(this).attr('val'));
        if(val == 1){
            return;
        }
        var image = $(this);
        var comment_id = get_comment_id($(this));
        var current_comment_item = $(this).parents("div[id='comment_item']");
        var oppose_num_label = current_comment_item.find("#oppose_num");
         $.post("comment_op.php", {comment_id: comment_id, op: 'oppose',token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>"})
            .done(function(data){
                if(data==-1){
                    return;
                }
                image.attr('src','image/opposed.png');
                oppose_num_label.text(data);
            });
    });

    $('a[id*="comment_edit"]').click(function(){
        var comment_id = get_comment_id($(this));
        var current_comment_item = $(this).parents("div[id='comment_item']");
        var current_comment_content = current_comment_item.find("#comment_content").text();
        current_comment_item.empty();
        current_comment_item.append("<textarea rows='5'>"+current_comment_content+"</textarea>");
        current_comment_item.append('<button class="btn btn-secondary" id="edit_comment_btn">Submit</button>');
        current_comment_item.on('click', '#edit_comment_btn', function(){
            $.post("comment_op.php", {comment_id: comment_id, op: 'edit',
                content: current_comment_item.find("textarea").val(),token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>" })
                .done(function(data){
                    alert(data);
                    window.location.href="";
                });
        });
    });

    var clicks = 0;
    $('a[id*="check_all_replies_btn"]').click(function(){
        if(clicks == 0){
            var is_login = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>";
            if( is_login == "-1" ){
                alert("Please sign in to see all replies!");
                return;
            }
            var comment_id = get_comment_id($(this));
            var current_comment_item = $(this).parents("div[id='comment_item']");
            $.post("comment_op.php", {comment_id: comment_id, op:'get_replies'})
                .done(function(data){
                    // console.log(data);
                    var jsonobj = jQuery.parseJSON(data);
                    // console.log(jsonobj);
                    jsonobj.forEach(function(reply_item){
                        console.log(reply_item);
                        current_comment_item.append('<div class="card"><div class="card-body"><h6 class="card-subtitle mb-2 text-muted">'+reply_item["username"]+'</h6><h6 class="card-subtitle mb-2 text-muted">'+reply_item["comment_date"]+'</h6><p class="card-text">'+ reply_item["content"] +'</p></div></div>');
                    });

                });
            clicks++;
        }else{
            var current_comment_item = $(this).parents("div[id='comment_item']");
            // current_comment_item.find("#reply_comment_item").remove();
            current_comment_item.find("div.card").remove();

            clicks = 0;
        }
        console.log("click = " + clicks);
    });

    $(document).ready(function(){
        $('#comment_body #agree_btn').each(function(){
            var comment_id = get_comment_id($(this));
            var userid = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>";
            var image = $(this);
            $.post("comment_op.php", {comment_id: comment_id, userid: userid, op:'check_record',token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>" })
                .done(function(data){
                    var records_num = parseInt(data);
                    if(records_num == 1){
                        image.attr('src', 'image/agreed.png');
                        image.attr('val', '1');
                    }
                });
            });
        $('#comment_body #oppose_btn').each(function(){
            var comment_id = get_comment_id($(this));
            var userid = "<?php echo isset($_SESSION['userid']) ? $_SESSION['userid'] : -1; ?>";
            var image = $(this);
            $.post("comment_op.php", {comment_id: comment_id, userid: userid, op:'check_record',token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>" })
                .done(function(data){
                    var records_num = parseInt(data);
                    if(records_num == 1){
                        image.attr('src', 'image/opposed.png');
                        image.attr('val', '1');
                    }
                });
            });

        $('#comment_body #reply_num').each(function(){
            // console.log("haha");
            var comment_id = get_comment_id($(this));
            var current_comment_item = $(this).parents("div[id='comment_item']");
            var reply_num_label = current_comment_item.find("#reply_num");
            console.log(comment_id);
            $.post("comment_op.php", {comment_id: comment_id, op: 'check_reply_num',token: "<?php echo isset($_SESSION['token'])?$_SESSION['token']: '';?>" })
                .done(function(data){
                    console.log(data);
                    reply_num_label.text(data);
                });
        });

    });

    </script>

</body>
</html>