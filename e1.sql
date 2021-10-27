-- 1.查询选修了1号课或3号课成绩都大于80分的的学生的学号和成绩; 
SELECT
    sno,
    grade
FROM
    sc
WHERE
    grade > 80
    AND (
        cno = '1'
        OR cno = '3'
    );

-- 2.查询管理系1990年以前出生的女生姓名、系和出生日期;
SELECT
    sname,
    sdept,
    csrq
FROM
    student
WHERE
    sdept = '管理系'
    AND YEAR(csrq) < 1990
    AND sex = '女';

-- 3.查询信息系所有女生年龄大于21的姓名,及所在系及年龄(当前年2010，年龄用age表示); 
SELECT
    sname,
    sdept,
    2010 - YEAR(csrq) AS age
FROM
    student
WHERE
    sex = '女'
    AND 2010 - YEAR(csrq) > 21
    AND sdept = '信息系';

-- 4.查询课程名含有数据两个字的，先行课程号不为0,学分大于2的的课程的课程号、课程名和学分;
SELECT
    cno,
    cname,
    ccredit
FROM
    course
WHERE
    cname LIKE '%数据%'
    AND cpno <> '0'
    AND ccredit > 2;

-- 5.查询计算机系或信息系中年龄介于20与23之间的同学情况，不含20与23.(设当前年为2010年,提示用当前年减去出生年再与20岁，23岁比较);
SELECT
    *
FROM
    student
WHERE
    sdept IN ('计算机系', '信息系')
    AND 2010 - YEAR(csrq) > 20
    AND 2010 - YEAR(csrq) < 23;

-- 6.查询名字中第3个字为玲4月4号出生的学生的姓名和学号;
SELECT
    sname,
    sno
FROM
    student
WHERE
    sname LIKE '__玲%'
    AND MONTH(csrq) = 4
    AND DAY(csrq) = 4;

-- 7.查询所有名字中含有“小”的非信息系同学的的姓名和系;
SELECT
    sname,
    sdept
FROM
    student
WHERE
    sname LIKE '%小%'
    AND sdept <> '信息系';

-- 8.查询管理系所有非李姓的2009及2010级同学情况;
SELECT
    *
FROM
    student
WHERE
    sdept = '管理系'
    AND sname NOT LIKE '李%'
    AND (
        sno LIKE '2009%'
        OR sno LIKE '2010%'
    );

-- 9.查询所有出生为90后的计算机系的两字李姓同学及管理系的两字王姓同学的情况;
SELECT
    *
FROM
    student
WHERE
    YEAR(csrq) >= 1990
    AND (
        sdept = '计算机系'
        AND sname LIKE '李_'
    )
    OR (
        sdept = '管理系'
        AND sname LIKE '王_'
    );

-- 10.请查询计算机系或文传系2011级90后4月出生的女生情况。
SELECT
    *
FROM
    student
WHERE
    sdept IN ('计算机系', '文传系')
    AND sno LIKE '2011%'
    AND YEAR(csrq) >= 1990
    AND MONTH(csrq) = 4
    AND sex = '女';