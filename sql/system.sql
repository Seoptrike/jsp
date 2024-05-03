/*사용자 생성
create user java identified by pass;*/

/*사용자 삭제
drop user java;*/

create user java identified by pass;

/*권한 부여*/
grant connect, resource, dba to java;

create user product identified by pass;
grant connect, resource, dba to product;