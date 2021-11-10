-- 4.	查询student_info表的所有记录
SELECT
    *
FROM
    student_info;

-- 5.	查询student_info表的第3条到5条记录
SELECT
    *
FROM
    student_info
LIMIT
    2, 3;

-- 6.	从student_info表查询所有学生的学号（Student_No）、姓名（name）和院系（depart）的信息
SELECT
    student_no,
    name,
    depart
FROM
    student_info;

-- 7.	从student_info表中查询计算机系和英语系的学生的信息
SELECT
    *
FROM
    student_info
WHERE
    depart = '计算机系'
    OR depart = '英语系';

-- 8.	从student_info表中查询年龄19~22岁且性别为男的学生信息
SELECT
    *
FROM
    student_info
WHERE
    sex = '男'
    AND age BETWEEN 19
    AND 22;

-- 9.	查询地址在“三门”的学生信息
SELECT
    *
FROM
    student_info
WHERE
    addr LIKE '%三门%';

-- 10.	统计每个系的男女生人数
SELECT
    depart,
    COUNT(*),
    sex
FROM
    student_info
GROUP BY
    depart,
    sex;

-- 11.	统计人数在2人以上的系
SELECT
    depart
FROM
    student_info
GROUP BY
    depart
HAVING
    COUNT(depart) > 2;

-- 12.	从fenshu_info表中查询每个科目的最高分
SELECT
    c_name,
    MAX(fenshu)
FROM
    fenshu_info
GROUP BY
    c_name;

-- 13.	查询每个科目的最高分的学生姓名及成绩
SELECT
    c_name,
    name,
    max(fenshu)
FROM
    student_info,
    fenshu_info
WHERE
    student_no = student_id
GROUP BY
    c_name;

SELECT
    c_name,
    b.name,
    fenshu
FROM
    fenshu_info AS a,
    student_info AS b
WHERE
    fenshu IN (
        SELECT
            MAX(fenshu)
        FROM
            fenshu_info
        GROUP BY
            c_name
    )
    AND a.student_id = b.student_no;

-- 14.	查询西门人的考试科目和成绩
SELECT
    c_name,
    fenshu
FROM
    fenshu_info
WHERE
    student_id = (
        SELECT
            student_no
        FROM
            student_info
        WHERE
            name = '西门人'
    );

-- 15.	统计每个学生（包括学生姓名）的总成绩
SELECT
    name,
    SUM(fenshu)
FROM
    fenshu_info
    LEFT JOIN student_info ON student_id = student_no
GROUP BY
    name;

-- 16.	计算每个考试科目的平均成绩
SELECT
    c_name,
    AVG(fenshu)
FROM
    fenshu_info
GROUP BY
    c_name;

-- 17. 查询同时参加数据库和英语考试的学生的信息
SELECT
    *
FROM
    student_info
WHERE
    student_no = ANY (
        SELECT
            student_id
        FROM
            fenshu_info
        WHERE
            student_id IN (
                SELECT
                    student_id
                FROM
                    fenshu_info
                WHERE
                    c_name = '数据库'
            )
            AND c_name = '英语'
    );

-- 18. 查询姓李同学的姓名、院系和考试科目及成绩
SELECT
    name,
    depart,
    c_name,
    fenshu
FROM
    student_info,
    fenshu_info
WHERE
    (name LIKE '李%')
    AND student_no = student_id;

-- 19.将数据库考试成绩按从高到低进行排序
SELECT
    *
FROM
    fenshu_info
WHERE
    c_name = '数据库'
ORDER BY
    fenshu DESC;

-- 20．请导出实验用数据库