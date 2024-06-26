<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>      
<style>
	table .title {
		background:gray;
		color:white;
		text-align:center;
		width:50px;
	}
	.value{
		width:100px;
	}
</style>    
    
<div class="row mt-3">
	<div class="col">
		<div>
			<h1>학생 정보</h1>
		</div>
		<div class="text-end mt-1">
			<button class="btn btn-success" id="update">수정</button>
			<button class="btn btn-secondary" id="delete">삭제</button>
		</div>
		<table class="table table-bordered mt-3">
			<tr>
				<td class="title">학생번호</td>
				<td class="value">${stu.scode}</td>
				<td class="title">학생이름</td>
				<td class="value">${stu.sname}</td>
				<td class="title">학생학과</td>
				<td class="value">${stu.sdept}</td>
			</tr>
			<tr>
				<td class="title">학생학년</td>
				<td class="value">${stu.year}</td>
				<td class="title">생년월일</td>
				<td class="value">${stu.birthday}</td>
				<td class="title">지도교수</td>
				<td class="value">${stu.pname}(${stu.advisor})</td>
			</tr>
		</table>
	</div>
</div>
<jsp:include page="/stu/info.jsp"/>
<script>
	//수정버튼
	$("#update").on("click",function(){
		const scode="${stu.scode}";
		location.href="/stu/update?scode="+scode;
		
	});
	
	//삭제버튼
	$("#delete").on("click",function(){
		const scode="${stu.scode}";
		const sname="${stu.sname}";
		if(confirm( sname + " 학생을 삭제하시겠습니까?")){
			//교수삭제
			$.ajax({
				type:"post",
				url:"/stu/delete",
				data:{scode},
				success:function(data){
					if(data=="true"){
					alert("삭제완료!");
					location.href="/stu/list";
				}else{
					alert("학생이 신청한 수강내역이 있습니다.")
					}
				}
			})
		}
	})
</script>