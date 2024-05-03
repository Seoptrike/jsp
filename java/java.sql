create table professors(
    pcode char(3) primary key, /* 자릿수가 정해져있을때 사용한다*/
    pname varchar(15),
    dept varchar(30),
    hiredate date,
    title varchar(15),
    salary int
); /*table을 만들때는 꼭 primary key 가 있어야 잘 만든 코드이다*/

drop table professors;

insert into professors(pcode,pname,dept,hiredate,title,salary)
values('221','이병렬','전산','75/04/03','정교수',3000000);
insert into professors(pcode,pname,dept,hiredate,title,salary)
values('228','이재광','전산','91/09/19','부교수',2500000);
insert into professors(pcode,pname,dept,hiredate,title,salary)
values('311','강승일','전자','94/06/09','부교수',2300000);
insert into professors(pcode,pname,dept,hiredate,title,salary)
values('509','오문환','건축','92/10/14','조교수',2000000);

select*from professors; /* *는 모든 colum 을 다 보겠다.*/

select pcode, pname from professors;

delete from professors where pcode is not null;

/* 221 교수의 이름을 김병렬로 수정하기*/



