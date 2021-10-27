-- 1. 查询选修了和王名一样学分数的其它同学姓名　	
select
    sname
from
    student
where
    sno in(
        select
            sno
        from
            sc,
            course
        where
            sc.cno = course.cno
        group by
            sno
        having
            sum(ccredit) =(
                select
                    sum(ccredit)
                from
                    sc,
                    course
                where
                    sc.cno = course.cno
                    and sno in(
                        select
                            sno
                        from
                            student
                        where
                            sname = '王名'
                    )
            )
            and sname <> '王名'
    );

-- 2. 查询选修了1号课并且成绩比全班1号课平均成绩低的同学学号及成绩 　	
SELECT
    sno,
    grade
FROM
    sc
WHERE
    sno IN(
        SELECT
            sno
        FROM
            sc
        WHERE
            cno = '1'
            AND grade < (
                SELECT
                    AVG(grade)
                FROM
                    sc
                WHERE
                    sno IN(
                        SELECT
                            sno
                        FROM
                            sc
                        WHERE
                            cno = '1'
                    )
            )
    );

-- 3. 分别按每年统计出生在1988-1990年三年间的学生人数，平均成绩，（学生人数，平均成绩表示）　	
SELECT
    COUNT(sc.sno) AS 学生人数,
    AVG(grade) AS 平均成绩,
    YEAR(csrq)
FROM
    student,
    sc
WHERE
    student.sno = sc.sno
GROUP BY
    YEAR(csrq)
HAVING
    YEAR(csrq) >= 1988
    AND YEAR(csrq) <= 1990;

-- 4. 查询个人平均成绩比王名同学的最高成绩还要高的同学的账户名和密码。
SELECT
    user1,
    password1
FROM
    mm
WHERE
    sno IN (
        SELECT
            sc.sno
        FROM
            student,
            sc,
            course
        WHERE
            sc.sno = student.sno
            and course.cno = sc.cno
        GROUP BY
            sc.sno
        HAVING
            AVG(grade) > (
                SELECT
                    MAX(grade)
                FROM
                    sc
                WHERE
                    sno IN (
                        SELECT
                            sno
                        FROM
                            student
                        WHERE
                            sname = '王名'
                    )
            )
    );

-- 5. 查询选过课的但没有在MM表中注册的同学姓名　	
SELECT
    sname
FROM
    sc,
    student
WHERE
    sc.sno = student.sno
    AND sc.sno NOT IN (
        SELECT
            sno
        FROM
            mm
    )
GROUP BY
    sname
HAVING
    COUNT(cno) > 0;

-- 6. 查询选修的学分数超过8个学分的同学学号及学分数　	
SELECT
    sno,
    SUM(ccredit)
FROM
    sc,
    course
WHERE
    course.cno = sc.cno
GROUP BY
    sno
HAVING
    SUM(ccredit) > 8;

-- 7. 查询李明，刘晨两位同学的平均成绩，并用学号和平均成绩表示出来　	
SELECT
    student.sno AS 学号,
    AVG(grade) AS 平均成绩
FROM
    sc,
    student
WHERE
    sc.sno = student.sno
    AND sname in ('李明', '刘晨')
GROUP BY
    sc.sno;

-- 8. 查询和李明同一个系，年龄比他大的同学姓名(当前年 2010）　	
SELECT
    sname
FROM
    student
WHERE
    sdept IN(
        SELECT
            sdept
        FROM
            student
        WHERE
            sname = '李明'
    )
    AND 2010 - YEAR(csrq) > ALL(
        SELECT
            2010 - YEAR(csrq)
        FROM
            student
        WHERE
            sname = '李明'
    );

-- 9. 查询数据库和数学这两门课的选课人数，并用课程号和选课人数表示出来　	
SELECT
    sc.cno AS 课程号,
    COUNT(*) AS 选课人数
FROM
    sc,
    course
WHERE
    sc.cno = course.cno
    AND cname IN('数据库', '数学')
GROUP BY
    sc.cno;

-- 10. 查询同时选修了1,2,3号课的同学的姓名及系
SELECT
    sname,
    sdept
FROM
    student
WHERE
    sno IN (
        SELECT
            sno
        FROM
            sc
        WHERE
            sno IN (
                SELECT
                    sno
                FROM
                    sc
                WHERE
                    sno IN (
                        SELECT
                            sno
                        FROM
                            sc
                        WHERE
                            cno = '1'
                    )
                    AND cno = '2'
            )
            AND cno = '3'
    );