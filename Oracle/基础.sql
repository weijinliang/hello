/*--Oracle中的伪列
1.ROWID:唯一标识数据库中的一行
  重要用途：
    01.能以快速的方式访问表中的一行
    02.能显示表的行是如何储存的
    03.可以作为表中行的唯一标识
--*/
--如：
  select * from Rowid,eName
   from SCOTT.emp
  where eName='SMITH';
/*--
2.ROWNUM:控制显示的行数
--*/
--如：
  select emp.*,ROWNUM
   from SCOTT.emp
  where ROWNUM<11;

--创建学员信息表
create table Stuinfo
(
  stuNo char(6) not null,--学号 非空
  stuName varchar2(20) not null,--学员姓名
  stuAge number(3,0) not null, --年龄
  stuID number(18,0),--身份证号，代表18为数字 小数为0
  stuSeat number(2,0)--座位号
);

--删除表：只能删除表中的数据 不能删除表结构
truncate table stuinfo;
--添加多条信息
select a.*,rowid from Stuinfo a;
--添加单条数据
insert into stuinfo(stuNo,stuname,stuage,stuid,stuseat)
values ('1','张三',18,'111111111111111111',1);
--查询信息
select * from Stuinfo
--查询不重复的行 按姓名 年龄查询信息
select Distinct stuName,stuAge
from Stuinfo
--按姓名升序排序 如果姓名相同 则按年龄降序排序
select stuNo,stuName,stuage
from Stuinfo
where stuage>17
Order by stuName asc,stuage desc;
--使用别名显示姓名 年龄和身份证号列
select stuName as "姓 名",stuAge as "年 龄",stuID as 身份证号
from Stuinfo;
--将现有的表创建新的表
create table newstuInfo /*--新表名--*/
  as
select * from Stuinfo;
--查询表中的总行
select Count(1) from Stuinfo;
--取出stuName stuAge 列不重复的数据记录
select stuName,stuAge
from Stuinfo
group by stuName,stuAge
Having(Count(stuName||stuage)<2);
--删除stuName、stuAge列重复的行（保留一行）
delete
 from Stuinfo
 where ROWID not in(
                 select Max(ROWID)
                  from Stuinfo
                    group by stuName,stuAge
                  having (count(stuName||stuAge)>1)
                   union
                  select max(rowid)
                      from stuinfo
                   group by stuName,stuAge
                   having (count(stuName||stuAge)=1)
  );
--查看当前用户所有数据量大于100万的表信息
select table_name
 from user_all_tables a
where a.num_rows>1000000;

--事务控制
 --执行步骤一：创建dept表
create table dapt
(
  depnon number(2) primary key,--部门编号 主键
  dname varchar2(14),--部门名称
  loc varchar2(13)--地址
);
 --执行步骤二：插入数据
insert into dapt values (10,'ACCOUNTING','NEW YORK');
insert into dapt values (20,'RESEARCH','DALLAS');
insert into dapt values (30,'SALES','CHICAGO');
insert into dapt values (40,'OPERATIONS','BOSTON');
commit;
 --执行步骤三：操作dept表
insert into dapt values(50,'a',null);
insert into dapt values(60,'b',null);
savepoint a;
insert into dapt values(70,'c',null);
rollback to savepoint a;
 --执行步骤四：查看dept表，有50 ，60 号部门
select * from dept;
 --执行步骤五：回滚
rollback;--没有部门 50 ，60 号部门
 --执行步骤六：查看dept表
select * from dapt;

--第一章 上机练习二
create table employee /*-- 创建员工信息表--*/
( empno number(4) not null,--员工编号
  ename varchar2(10),--员工姓名
  job varchar2(9),--员工工种
  mgr number(4),--上级经理编号
  hiredate date,--受雇日期
  sal number(7,2),--员工薪水
  comm number(7,2),--福利
  deptno number(2)--部门编号
 );
 --添加数据
insert into employee select * from SCOTT.emp;
--添加约束 员工编号作为主键 部门编号作为外键与部门表关联
alter table employee
  add constraint FK_deptno foreign key(deptno) references dapt(depnon);
  
--在employee表添加 empTel_no和 empAddress两列
alter table employee
  add(empTel_no varchar2(12),--电话号码
      empAddress varchar2(20));--储存地址
select * from employee;
--删除empTel_no和 empAddress两列
ALTER TABLE employee DROP COLUMN empTel_no;
alter table employee drop column empAddress;
--按照薪水从高到底显示数据
select * from employee order by sal desc;
--上机三 实现分页查询
 --2 对员工表倒序排序并生成临时结果集A

--使用UNION操作符获得所有公司工作的员工编号
select empno from employee
 union
select rempno from retireEmp;

