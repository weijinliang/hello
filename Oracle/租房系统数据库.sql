create table USERS/*�û���*/(
  ID number(4) primary key not null,--�û�����
  NAME nvarchar2(50) not null,--�û���
  PASSWORD nvarchar2(50),--����
  TELEPHONE nvarchar2(15),--�绰
  USERNAME nvarchar2(50),--�û�����
  ISADMIN nvarchar2(5)--�Ƿ��ǹ���Ա
);

create table TYPE/*�������ͱ�*/(
  ID number(4) primary key not null,--���ͱ��
  NAME nvarchar2(50) not null--��������
);

create table DISTRICT/*���ر�*/
(
  ID number(4) primary key not null,
  NAME nvarchar2(50) not null
);

create table STREET/*�ֵ���*/
(
  ID number(4) primary key not null,--�ֵ����
  NAME nvarchar2(50) not null,--�ֵ�����
  DISTRICT_ID number(4) --�������ر�� ������������ر�����
);

create table HOUSE/*������Ϣ��*/
(
  ID number(6) primary key not null,--������Ϣ���
  TITLE nvarchar2(50),--����
  DESCRIPTION nvarchar2(2000),--����
  PRICE number(6),--����۸�
  PUBDATE DATE,--����ʱ��
  FLOORAGE number(4),--���
  CONTACT Nvarchar2(100),---��ϵ��
  USER_ID number(4),--��� �����û��������
  TYPE_ID number(4),--��� �������ͱ������
  STREET_ID number(4)--��� ����ֵ��������
);
