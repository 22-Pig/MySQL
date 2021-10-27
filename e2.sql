-- 1. 查询选了数学的同学的学号，姓名，成绩，并要求成绩按照由高到低排列出来　	
SELECT
    student.sno,
    student.sname,
    sc.grade
FROM
    sc,
    student
WHERE
    student.sno = sc.sno
    AND sc.cno = (
        SELECT
            cno
        FROM
            course
        WHERE
            cname = '数学'
    )
ORDER BY
    grade DESC;

-- 2. 请将计算机系选了1号课的同学按成绩由高到低排序，如果成绩相同，再按学号由小到大排序，最后显示学号，姓名及成绩	
SELECT
    student.sno,
    student.sname,
    sc.grade
FROM
    student
    LEFT JOIN sc ON student.sno = sc.sno
WHERE
    student.sdept = '计算机系'
    AND sc.cno = '1'
ORDER BY
    sc.grade DESC,
    sc.sno ASC;

-- 3. 查询信息系和管理系选了数学课的成绩达到80分（含80)的同学姓名及成绩
SELECT
    student.sname,
    sc.grade
FROM
    student,
    sc,
    course
WHERE
    student.sno = sc.sno
    AND course.cno = sc.cno
    AND student.sdept IN ('信息系', '管理系')
    AND sc.cno = (
        SELECT
            cno
        FROM
            course
        WHERE
            cname = '数学'
    )
    AND sc.grade >= 80;

-- 4. 查询管理系选了数据库课的成绩大于70并且已在密码表中注册过的同学的姓名及成绩 　	
SELECT
    student.sname,
    sc.grade
FROM
    student,
    sc,
    mm,
    course
WHERE
    student.sno = sc.sno
    AND course.cno = sc.cno
    AND student.sno = mm.sno
    AND student.sdept in('管理系')
    AND course.cname = '数据库'
    AND sc.grade > 70
    AND mm.sno = student.sno;

-- 5. 请将名字中含有叠字的所有学生姓名查询出来（黄婷婷）　	
SELECT
    sname
FROM
    student
WHERE
    RIGHT(sname, 1) = LEFT(RIGHT(sname, 2), 1)
    OR (LEFT(RIGHT(sname, 2), 1) = LEFT(RIGHT(sname, 3), 1))
    AND sname LIKE '___%'
    OR LEFT(sname, 1) = RIGHT(LEFT(sname, 2), 1);

-- 6. 查询密码表中第一位密码和最后一位密码字符相同的1989年出生的同学姓名，密码，出生日期　	
SELECT
    student.sname,
    mm.password1,
    student.csrq
FROM
    mm,
    student
WHERE
    mm.sno = student.sno
    AND LEFT(password1, 1) = RIGHT(password1, 1)
    AND YEAR(student.csrq) = '1989';

-- 7. 查询选了数据库课的管理系同学的最高成绩，最低成绩，及平均成绩（请用最高成绩，最低成绩，及平均成绩表示出来）　	
SELECT
    MAX(grade) AS 最高成绩,
    MIN(grade) AS 最低成绩,
    AVG(grade) AS 平均成绩
FROM
    sc,
    course,
    student
WHERE
    sc.cno = course.cno
    AND cname = '数据库'
    and sdept = '管理系';

-- 8. 查询2009级选了数据库的人数
SELECT
    COUNT(*) AS 人数
FROM
    sc,
    course
WHERE
    sc.cno = course.cno
    AND cname = '数据库'
    AND sc.sno LIKE '2009%';

-- 9. 学校拿出5000元奖励数据库课程中80分以上的同学，请问每个同学平均能拿到多少奖金？（请用平均奖金表示并保留1位小数）　	
SELECT
    ROUND(5000 / COUNT(*), 1) AS 平均奖金
FROM
    student,
    sc,
    course
WHERE
    student.sno = sc.sno
    AND course.cno = sc.cno
    AND cname = '数据库'
    AND grade > 80;

-- 10. 如果将所有选了数据库课程的同学成绩，下调15分，请查询该课程将有多少个不及格同学
SELECT
    COUNT(sc.grade)
FROM
    student,
    sc,
    course
WHERE
    student.sno = sc.sno
    AND course.cno = sc.cno
    AND cname = '数据库'
    AND (sc.grade - 15) < 60;