<?php
function content_check($content){
	if (preg_match("/(<|>|\/)+/", $content)) {
		return false;
    }
    return true;
}