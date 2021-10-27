/* 1.请创建一个教师表teacher 其中包括教师号tno char(3)，教师名tname char(8)，教师性别tsex char(2)，教师系tdept char(20)，教师职称tglass char(10)，教师出生日期tcsrq date，要求，教师号为唯一。 */
CREATE TABLE teacher (
	tno CHAR (3) UNIQUE,
	tname char(8),
	tsex char(2),
	tdept char(20),
	tglass char(10),
	tcsrq DATE,
	PRIMARY KEY (tno)
);

/* 2.用定义语句创建“宿舍表”sushe,要求宿舍号ssh 文本3 ,宿舍类别sslb文本2,床位数cws 数字整型,宿舍长ssz 文本10位, 宿舍号，宿舍号为主键，并且不为空 */
CREATE TABLE sushe(
	ssh CHAR(3) PRIMARY KEY NOT NULL,
	sslb CHAR(2),
	cws INTEGER,
	ssz CHAR(10)
);

/* 3.在课程表course中增加一列教师号tno 文本3 ,缺省值 000 */
alter table
	course
add
	tno char(3) default '000';

/* 4.将教师表teacher所属系（tdept）长度改为50,约束条件为不为空 ，缺省值为计算机系 */
alter table
	teacher alter tdept char(50) not null default '计算机系';

/* 5.创建一个名字为v_stu视图，将计算机系平均成绩大于等于80的同学的姓名及平均成绩放入该视图中。（注该视图只有名字和平均成绩两个字段，平均成绩要用pjgrade)表示　	 */
CREATE VIEW v_stu AS
SELECT
	student.sname,
	avg(grade) AS pjgrade
FROM
	student,
	sc
WHERE
	student.sno = sc.sno
	AND sdept = '计算机系'
GROUP BY
	sname
HAVING
	avg(grade) >= 80;

/* 6.以SC表创建一个索引文件idx_sc1，要求按CNO降降序，GRADE升序 　	 */
create index idx_sc1 on sc(cno desc, grade asc);

/* 7.请创建一个视图文件sss，要求其中包括计算机系所有成绩大于65分课程的学生姓名，课程名，成绩，系名，任课教师姓名。 */
CREATE VIEW SSS AS
SELECT
	student.sname,
	cname,
	sc.grade,
	sdept,
	tname
FROM
	student,
	course,
	sc,
	teacher
WHERE
	student.sno = sc.sno
	AND sc.cno = course.cno
	AND course.tno = teacher.tno
	AND sdept = '计算机系'
	AND sc.grade > 65;

/* 8.用视图sss再建另一视图sss1，要求其中包含每个人的姓名，平均成绩，最高成绩，最低成绩等字段，并用中文（姓名，平均成绩，最高成绩，最低成绩表示出来） */
CREATE VIEW sss1 AS
SELECT
	sname AS '姓名',
	avg(grade) AS '平均成绩',
	max(grade) AS '最高成绩',
	min(grade) AS '最低成绩'
FROM
	sss
GROUP BY
	sname;

/* 9.请将course表中的tno列删除 */
ALTER TABLE
	course DROP COLUMN tno;

/* 10.删除索引文件idx_sc1 */
DROP INDEX idx_sc1 ON sc;