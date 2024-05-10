<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="div_stu"></div>

<script id="temp_stu" type="x-handlebars-tempelate">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>학생번호</td>
			<td>학생이름</td>
			<td>학생학과</td>
			<td>학생학년</td>
			<td>신청일</td>
			<td>점수</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{scode}}</td>
			<td><a href="/stu/read?scode={{scode}}">{{sname}}</a></td>
			<td>{{sdept}}</td>
			<td>{{year}}학년</td>
			<td>{{edate}}</td>
			<td><input value="{{grade}}" size=3></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
let lcode="${cou.lcode}"
getData();

function getData(){
	$.ajax({
		type:"get",
		url:"/enroll/slist.json",
		dataType:"json",
		data:{lcode},
		success:function(data){
			console.log(data);
			const temp=Handlebars.compile($("#temp_stu").html());
			$("#div_stu").html(temp(data));
		}
	})
}
</script>