/*����� ����
create user java identified by pass;*/

/*����� ����
drop user java;*/

create user java identified by pass;

/*���� �ο�*/
grant connect, resource, dba to java;

create user product identified by pass;
grant connect, resource, dba to product;