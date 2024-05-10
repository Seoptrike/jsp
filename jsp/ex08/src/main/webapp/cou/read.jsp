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
			<h1>강좌 정보</h1>
		</div>
		<div class="text-end mt-1">
			<button class="btn btn-success" id="update">수정</button>
			<button class="btn btn-secondary" id="delete">삭제</button>
		</div>
		<table class="table table-bordered mt-3">
			<tr>
				<td class="title">강좌번호</td>
				<td class="value">${cou.lcode}</td>
				<td class="title">소속학과</td>
				<td class="value">${cou.dept}</td>
				<td class="title">강좌이름</td>
				<td class="value" colspan="3">${cou.lname}</td>
				
				
			</tr>
			<tr>
				<td class="title">신청인원</td>
				<td class="value">${cou.persons}/${cou.capacity}</td>
				<td class="title">담당교수</td>
				<td class="value">${cou.pname}(${cou.instructor})</td>
				<td class="title">강의시간</td>
				<td class="value">${cou.hours}</td>
				<td class="title">강의실</td>
				<td class="value">${cou.room}</td>
			</tr>
		</table>
		
	</div>
</div>
<jsp:include page="/cou/info.jsp"/>
<script>
	//수정버튼
	$("#update").on("click",function(){
		const lcode="${cou.lcode}";
		location.href="/cou/update?lcode="+lcode;
		
	});
	
	//삭제버튼
	$("#delete").on("click",function(){
		const lcode="${cou.lcode}";
		const lname="${cou.lname}";
		if(confirm( lname + " 강좌를 삭제하시겠습니까?")){
			//교수삭제
			$.ajax({
				type:"post",
				url:"/cou/delete",
				data:{lcode},
				success:function(data){
					if(data=="true"){
					alert("삭제완료!");
					location.href="/cou/list";
				}else{
					alert("학생들이 신청한 수강내역이 있습니다.")
					}
				}
			})
		}
	})
</script>