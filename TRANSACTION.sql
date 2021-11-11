-- 开启事务
START TRANSACTION;
-- Alex减少100元
UPDATE sh_user SET money = money - 100 WHERE name = 'Alex';
-- Bill增加100元
UPDATE sh_user SET money = money + 100 WHERE name = 'Bill';
-- 提交事务
COMMIT;

-- 开启事务
START TRANSACTION;
-- Bill扣除100元
UPDATE sh_user SET money = money - 100 WHERE name = 'Bill';
-- 查询Bill的金额
SELECT name, money FROM sh_user WHERE name = 'Bill';
-- 回滚事务
ROLLBACK;
-- 查看Bill的金额
SELECT name, money FROM sh_user WHERE name = 'Bill';

-- 脏读
-- 设置客户端B的隔离级别，允许脏读
# 客户端B
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- 查看Bill的金额
# 客户端B
SELECT name, money FROM sh_user WHERE name = 'Bill';
-- 客户端A开启事务并转账
# 客户端A
START TRANSACTION;
UPDATE sh_user SET money = money - 100 WHERE name = 'Alex';
UPDATE sh_user SET money = money + 100 WHERE name = 'Bill';
-- 客户端A未提交事务，客户端B查询金额
# 客户端B
SELECT name, money FROM sh_user WHERE name = 'Bill';
-- 提高隔离级别，解决脏读问题
# 客户端B
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- 实验结束，回滚客户端A的事务
# 客户端A
ROLLBACK;




-- 设置隔离级别，查询Alex的金额
# 客户端B
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT name, money FROM sh_user WHERE name = 'Alex';
-- Alex取出100元，再次查询Alex金额
# 客户端A
UPDATE sh_user SET money = money - 100 WHERE name = 'Alex';
# 客户端B
SELECT name, money FROM sh_user WHERE name = 'Alex';
# 客户端B
COMMIT;
-- 更改隔离级别，避免客户端B的不可重复读
# 客户端B
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT name, money FROM sh_user WHERE name = 'Alex';



