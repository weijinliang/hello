create table USERS/*用户表*/(
  ID number(4) primary key not null,--用户编码
  NAME nvarchar2(50) not null,--用户名
  PASSWORD nvarchar2(50),--密码
  TELEPHONE nvarchar2(15),--电话
  USERNAME nvarchar2(50),--用户姓名
  ISADMIN nvarchar2(5)--是否是管理员
);

create table TYPE/*房屋类型表*/(
  ID number(4) primary key not null,--类型编号
  NAME nvarchar2(50) not null--类型名称
);

create table DISTRICT/*区县表*/
(
  ID number(4) primary key not null,
  NAME nvarchar2(50) not null
);

create table STREET/*街道表*/
(
  ID number(4) primary key not null,--街道编号
  NAME nvarchar2(50) not null,--街道名称
  DISTRICT_ID number(4) --所属区县编号 外键，引入区县表主键
);

create table HOUSE/*房屋信息表*/
(
  ID number(6) primary key not null,--房屋信息编号
  TITLE nvarchar2(50),--标题
  DESCRIPTION nvarchar2(2000),--描述
  PRICE number(6),--出租价格
  PUBDATE DATE,--发布时间
  FLOORAGE number(4),--面积
  CONTACT Nvarchar2(100),---联系人
  USER_ID number(4),--外键 引入用户表的主键
  TYPE_ID number(4),--外键 引入类型表的主键
  STREET_ID number(4)--外键 引入街道表的主键
);
