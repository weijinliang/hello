/*--Oracle�е�α��
1.ROWID:Ψһ��ʶ���ݿ��е�һ��
  ��Ҫ��;��
    01.���Կ��ٵķ�ʽ���ʱ��е�һ��
    02.����ʾ���������δ����
    03.������Ϊ�����е�Ψһ��ʶ
--*/
--�磺
  select * from Rowid,eName
   from SCOTT.emp
  where eName='SMITH';
/*--
2.ROWNUM:������ʾ������
--*/
--�磺
  select emp.*,ROWNUM
   from SCOTT.emp
  where ROWNUM<11;

--����ѧԱ��Ϣ��
create table Stuinfo
(
  stuNo char(6) not null,--ѧ�� �ǿ�
  stuName varchar2(20) not null,--ѧԱ����
  stuAge number(3,0) not null, --����
  stuID number(18,0),--���֤�ţ�����18Ϊ���� С��Ϊ0
  stuSeat number(2,0)--��λ��
);

--ɾ����ֻ��ɾ�����е����� ����ɾ����ṹ
truncate table stuinfo;
--��Ӷ�����Ϣ
select a.*,rowid from Stuinfo a;
--��ӵ�������
insert into stuinfo(stuNo,stuname,stuage,stuid,stuseat)
values ('1','����',18,'111111111111111111',1);
--��ѯ��Ϣ
select * from Stuinfo
--��ѯ���ظ����� ������ �����ѯ��Ϣ
select Distinct stuName,stuAge
from Stuinfo
--�������������� ���������ͬ �����併������
select stuNo,stuName,stuage
from Stuinfo
where stuage>17
Order by stuName asc,stuage desc;
--ʹ�ñ�����ʾ���� ��������֤����
select stuName as "�� ��",stuAge as "�� ��",stuID as ���֤��
from Stuinfo;
--�����еı����µı�
create table newstuInfo /*--�±���--*/
  as
select * from Stuinfo;
--��ѯ���е�����
select Count(1) from Stuinfo;
--ȡ��stuName stuAge �в��ظ������ݼ�¼
select stuName,stuAge
from Stuinfo
group by stuName,stuAge
Having(Count(stuName||stuage)<2);
--ɾ��stuName��stuAge���ظ����У�����һ�У�
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
--�鿴��ǰ�û���������������100��ı���Ϣ
select table_name
 from user_all_tables a
where a.num_rows>1000000;

--�������
 --ִ�в���һ������dept��
create table dapt
(
  depnon number(2) primary key,--���ű�� ����
  dname varchar2(14),--��������
  loc varchar2(13)--��ַ
);
 --ִ�в��������������
insert into dapt values (10,'ACCOUNTING','NEW YORK');
insert into dapt values (20,'RESEARCH','DALLAS');
insert into dapt values (30,'SALES','CHICAGO');
insert into dapt values (40,'OPERATIONS','BOSTON');
commit;
 --ִ�в�����������dept��
insert into dapt values(50,'a',null);
insert into dapt values(60,'b',null);
savepoint a;
insert into dapt values(70,'c',null);
rollback to savepoint a;
 --ִ�в����ģ��鿴dept����50 ��60 �Ų���
select * from dept;
 --ִ�в����壺�ع�
rollback;--û�в��� 50 ��60 �Ų���
 --ִ�в��������鿴dept��
select * from dapt;

--��һ�� �ϻ���ϰ��
create table employee /*-- ����Ա����Ϣ��--*/
( empno number(4) not null,--Ա�����
  ename varchar2(10),--Ա������
  job varchar2(9),--Ա������
  mgr number(4),--�ϼ�������
  hiredate date,--�ܹ�����
  sal number(7,2),--Ա��нˮ
  comm number(7,2),--����
  deptno number(2)--���ű��
 );
 --�������
insert into employee select * from SCOTT.emp;
--���Լ�� Ա�������Ϊ���� ���ű����Ϊ����벿�ű����
alter table employee
  add constraint FK_deptno foreign key(deptno) references dapt(depnon);
  
--��employee����� empTel_no�� empAddress����
alter table employee
  add(empTel_no varchar2(12),--�绰����
      empAddress varchar2(20));--�����ַ
select * from employee;
--ɾ��empTel_no�� empAddress����
ALTER TABLE employee DROP COLUMN empTel_no;
alter table employee drop column empAddress;
--����нˮ�Ӹߵ�����ʾ����
select * from employee order by sal desc;
--�ϻ��� ʵ�ַ�ҳ��ѯ
 --2 ��Ա����������������ʱ�����A

--ʹ��UNION������������й�˾������Ա�����
select empno from employee
 union
select rempno from retireEmp;

