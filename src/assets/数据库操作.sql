用户:sa
password:123456

use Rsv

create table users
(id int identity(1,1),primary key(id),
username varchar(50),
password varchar(50),
email varchar(50),
role varchar(50),
state int
)


select * from users

insert users values('stu01','123456','226129400@qq.com','Student',1)
insert users values('stu02','123456','326129400@qq.com','Student',1)
insert users values('admin','123456','226129400@qq.com','Admin',1)
insert users values('tea01','123456','226129400@qq.com','Teacher',1)
insert users values('tea02','123456','226129400@qq.com','Teacher',1)

create table Mainmenu
(id int primary key(id),
title varchar(50),
path varchar(50)
)

create table Submenu
(id int primary key(id),
title varchar(50),
path varchar(50),
mid int,
admin int,
student int,
teacher int
)

insert Mainmenu values(100,'系统管理','/admin')
insert into Mainmenu values(200,'师生信息','/TeaAndStu')
insert into Mainmenu values(300,'阅览室篇','/ReadRoom')
insert into Mainmenu values(400,'信用积分','/credit')
insert into Mainmenu values(500,'选座管理','/SeatSelection')
insert Mainmenu values(600,'通知公告','/Notice')
insert Mainmenu values(700,'交流管理','/communication')
insert Mainmenu values(800,'个人信息','/personalInfo')


insert Submenu values(101,'用户管理','/user',100,1,0,0)
insert into Submenu values(201,'教师信息','/teacher',200,1,0,0)
insert into Submenu values(203,'学生信息','/student',200,1,0,0)
insert into Submenu values(301,'阅览室类型','/type',300,1,0,0)
insert into Submenu values(302,'阅览室信息','/formation',300,1,0,0)
insert into Submenu values(303,'阅览室类型','/typeF',300,0,1,1)
insert into Submenu values(304,'阅览室信息','/formationF',300,0,1,1)
insert into Submenu values(401,'举报情况','/jB',400,1,0,0)
insert into Submenu values(402,'积分明细','/details',400,1,0,1)
insert into Submenu values(501,'空余座位','/kongYu',500,0,1,0)
insert into Submenu values(502,'已占座位','/yiZhan',500,1,1,1)
insert into Submenu values(503,'个人已占','/geRenYiZhan',500,0,1,0)
insert Submenu values(601,'通知信息','/noticeInfo',600,1,1,1)
insert Submenu values(701,'信息交流','/infoCommunication',700,1,1,1)
insert Submenu values(801,'个人信息管理','/personalInfoManaOfStudent',800,0,1,0)
insert Submenu values(802,'个人信息管理','/personalInfoManaOfTeacher',800,0,0,1)

select * from Mainmenu

select * from Submenu

select mm.*,sm.id as sid,sm.title as stitle,sm.path as spath from Mainmenu mm,
Submenu sm where mm.id = sm.mid


create table readRoomInfo
(id int identity(1,1),primary key(id),
name varchar(50),
type varchar(50),
row int,
col int,
sum int
)


create table positionInfo
(id int identity(1,1),primary key(id),
num int,
state int,
startTime datetime,
endTime datetime,
mid varchar(50)
)

create table readRoomClass
(id int identity(1,1),primary key(id),
type varchar(50),
limit int
) 

insert readRoomClass values('Ⅲ',90)
insert readRoomClass values('Ⅱ',80)
insert readRoomClass values('Ⅰ',60)

select * from readRoomClass

insert readRoomInfo values('一号阅览室','Ⅰ',2,2,4)
insert readRoomInfo values('二号阅览室','Ⅱ',3,3,9)

insert positionInfo values(1,0,'','','二号阅览室')
insert positionInfo values(2,0,'','','二号阅览室')
insert positionInfo values(3,0,'','','二号阅览室')
insert positionInfo values(4,0,'','','二号阅览室')
insert positionInfo values(5,0,'','','二号阅览室')
insert positionInfo values(6,0,'','','二号阅览室')
insert positionInfo values(7,0,'','','二号阅览室')
insert positionInfo values(8,0,'','','二号阅览室')
insert positionInfo values(9,0,'','','二号阅览室')

insert positionInfo values(1,0,'','','一号阅览室')
insert positionInfo values(2,0,'','','一号阅览室')
insert positionInfo values(3,0,'','','一号阅览室')
insert positionInfo values(4,0,'','','一号阅览室')

select num from positionInfo where mid='二号阅览室' and state=0 
select num from positionInfo where mid='二号阅览室' and state=1 and (startTime not between ''and '') and
(startTime not between ''and '' ) 
select * from readRoomInfo
select * from positionInfo

select * from test where times not between '' and ''
select * from test where (times not between '2009-8-28 14:15:10' and '2021-5-4 16:00:00') and (times not between '1903-8-25 12:15:11' and '1906-8-25 12:15:12')

create table students
(id int identity(1,1),primary key(id),
username varchar(50),
password varchar(50),
sex varchar(50),
classes varchar(50),
email varchar(50),
role varchar(50),
credit int
) 

insert students values('stu01','123456','M','软件一班','226129433@qq.com','Student',100)

create table hasReserv
(id int identity(1,1),primary key(id),
username varchar(50),
readRoom varchar(50),
num int,
startTime datetime,
endTime datetime,
) 

create table Deduction
(id int identity(1,1),primary key(id),
jBusername varchar(50),
bJBusername varchar(50),
dates varchar(50),
content varchar(50),
kf int,
state int
) 

select * from Deduction

insert students values('stu02','123456','M','软件一班','326129400@qq.com','Student',100)

/*update Deduction set kf=0 ,state =0 where id = 1
update students set credit=100 where username = 'stu01'*/

select * from hasReserv
select * from Submenu
select * from Deduction

select * from Students
select * from users

select * from Deduction

delete readRoomClass where id in(4,5,6)

drop table Deduction

select * from readRoomClass

select * from readRoomInfo

select * from positionInfo

select * from students
select * from users

create table teachers
(id int identity(1,1),primary key(id),
username varchar(50),
password varchar(50),
sex varchar(50),
XueYuan varchar(50),
email varchar(50),
role varchar(50),
) 
insert teachers values('tea01','123456','M',
       '软件学院','123456@qq.com','Teacher')

select * from teachers

create table infoCommunication
(id int identity(1,1),primary key(id),
sendUsername varchar(50),
dates varchar(50),
title varchar(50),
) 

create table reply
(id int identity(1,1),primary key(id),
replyUsername varchar(50),
dates varchar(50),
content varchar(550),
mid int
) 

create table notiInfo
(id int identity(1,1),primary key(id),
title varchar(50),
dates varchar(50),
content varchar(550)
) 

select * from notiInfo

insert notiInfo values('关于大数据方向的一些讨论','Tue May 04 11:50:30 CST 2021','大数据的应用是时代发展的必然趋势')
select * from infoCommunication
select * from reply

select * from Submenu
