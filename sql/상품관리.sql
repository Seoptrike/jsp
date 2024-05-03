create table product(
    code char(3) not null/*null�� ���� �ȵȴ�*/ primary key,
    name varchar(100) not null,
    price int default 0
);
drop table product;

desc product; /* ���̺� Ȯ���ϱ� */

insert into product(code,name,price)
values('101','�����',3500000);
insert into product values('102','��Ź��',2300000);
insert into product values('103','��Ÿ�Ϸ�',1700000);
insert into product values('104','�����',1200000);

select * from product;

create table sale(
    seq int,
    code char(3) not null,
    sale_date date default sysdate,
    qnt int default 1,
    primary key (code,sale_date), /*code�� saledate�� ���ļ� primaykey�� �ȴ�*/
    foreign key (code) references product(code)
);

desc sale;

insert into sale values(1,'101','2024/04/01',12);
insert into sale values(2,'102','2024/04/01',5);
insert into sale values(3,'103','2024/04/02',6);
insert into sale values(4,'101','2024/04/03',15);

select * from sale order by sale_date;

drop SEQUENCE seq_sale;
create sequence seq_sale increment by 1 start with 5;

insert into sale values (seq_sale.nextval,'103','2024/04/05',10);

delete from sale where seq=5;

update sale set qnt = 12 where seq=6;

select * from sale;

create view view_sale as
select s.code,p.name, p.price, s.sale_date, s.qnt
from product p, sale s /* table�̸� �����*/
where p.code = s.code; 

select * from view_sale;

select max(code)+1 as code from product;

select * from product
commit;