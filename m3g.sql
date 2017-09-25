create table users(
	userid int not null auto_increment,
	username varchar(25) not null,
	password char(255) not null,
	primary key (userid)
)engine = InnoDB default character set = utf8 collate = utf8_general_ci;

create table stories(
	story_id int not null auto_increment,
	title varchar(255) not null,
	issue_date datetime not null default CURRENT_TIMESTAMP,
	userid int not null,
	content text not null,
	foreign key (userid) references users (userid),
	primary key (story_id)
)engine = InnoDB default character set = utf8 collate = utf8_general_ci;

create table comments(
	comment_id int not null auto_increment,
	content text not null,
	agree int not null,
	oppose int not null,
	userid int not null,
	type tinyint not null,
	link_comment int,
	story_id int,
	comment_date datetime not null default CURRENT_TIMESTAMP,
	foreign key (userid) references users (userid),
	foreign key (story_id) references stories (story_id),
	primary key (comment_id)
)engine = InnoDB default character set = utf8 collate = utf8_general_ci;