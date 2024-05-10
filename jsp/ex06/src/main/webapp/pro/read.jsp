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
			<h1>교수 정보</h1>
		</div>
		<table class="table table-bordered mt-3">
			<tr>
				<td class="title">교수번호</td>
				<td class="value">${pro.pcode}</td>
				<td class="title">교수이름</td>
				<td class="value">${pro.pname}</td>
				<td class="title">교수학과</td>
				<td class="value">${pro.dept}</td>
			</tr>
			<tr>
				<td class="title">임용일자</td>
				<td class="value">${pro.hiredate}</td>
				<td class="title">교수직급</td>
				<td class="value">${pro.title}</td>
				<td class="title">교수급여</td>
				<td><fmt:formatNumber pattern="#,###" value="${pro.salary}"/></td>
			</tr>
		</table>
		<div class="text-center my-5">
			<button class="btn btn-success" id="update">정보수정</button>
			<button class="btn btn-secondary" id="delete">정보삭제</button>
		</div>
	</div>
</div>

<script>
	//수정버튼
	$("#update").on("click",function(){
		const pcode="${pro.pcode}";
		location.href="/pro/update?pcode="+pcode;
		
	});
	
	//삭제버튼
	$("#delete").on("click",function(){
		const pcode="${pro.pcode}";
		if(confirm(pcode + " 번 교수를 삭제하시겠습니까?")){
			//교수삭제
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{pcode},
				success:function(data){
					if(data==1){
					alert("삭제완료!");
					location.href="/pro/list";
				}else{
					alert("삭제 실패!")
					}
				}
			})
		}
	})
</script>