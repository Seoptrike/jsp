<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<style>
	.input-group span{
		width:150px;
	}
</style>    
    
<div class="row my-5 justify-content-center">
	<div class="col-10 col-md-8">
		<div class="card">
			<div class="card-header text-center text-bg-dark">
				<h3> 정보 수정 </h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">학생번호</span>
						<input class="form-control" name="scode" value="${stu.scode}" readonly>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">학생이름</span>
						<input class="form-control" name="sname" value="${stu.sname}">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">학생학과</span>
						<select class="form-select" name="dept">
							<option value="전산"<c:out value="${stu.sdept=='전산'?'selected':''}"/>>컴퓨터정보공학과</option>
							<option value="전자"<c:out value="${stu.sdept=='전자'?'selected':''}"/>>전자공학과</option>
							<option value="건축"<c:out value="${stu.sdept=='건축'?'selected':''}"/>>건축공학과</option>
						</select>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">학생학년</span>
						<div class="form-check m-2">
							<input <c:out value="${stu.year=='1'?'checked':''}"/> class="form-check-input" name="year" id="year1" type="radio" value="1" checked>
							<label class= form-check-label for="year1">1학년</label>
						</div>	
						<div class="form-check m-2">
							<input <c:out value="${stu.year=='2'?'checked':''}"/> class="form-check-input" name="year" id="year2" type="radio" value="2">
							<label class= form-check-label for="year2">2학년</label>
						</div>
						<div class="form-check m-2">
							<input <c:out value="${stu.year=='3'?'checked':''}"/> class="form-check-input" name="year" id="year3" type="radio" value="3">
							<label class= form-check-label for="year3">3학년</label>
						</div>
						<div class="form-check m-2">
							<input <c:out value="${stu.year=='4'?'checked':''}"/> class="form-check-input" name="year" id="year4" type="radio" value="4">
							<label class= form-check-label for="year4">4학년</label>
						</div>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">지도교수</span>
						<input value="${stu.advisor}" name="advisor" class="form-control" readonly>
						<input value="${stu.pname}" name="pname" class="form-control" readonly>
						<button class="btn btn-success" type="button" id="search">검색</button>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">생년월일</span>
						<input value="${stu.birthday}" name="birthday" class="form-control" type="date" value="2005-01-01">
					</div>
					
					<div class="text-center mt-3">
						<button class="btn btn-success">수정하기</button>
						<button class="btn btn-secondary" type="reset">수정취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="modal.jsp"></jsp:include>

<script>
$("#search").on("click",function(){
	$("#modalPro").modal("show");
});

$(frm).on("submit",function(e){
	e.preventDefault();
	const pname=$(frm.pname).val();
	const advisor=$(frm.advisor).val();
	if(pname==""|| advisor==""){
		alert("학생이름을 입력하세요!")
		$(frm.sname).focus();
		return;
	}
	
	if(confirm("학생 정보를 수정하시겠습니까?")){
		frm.method="post";
		frm.submit();
	}
})
</script>
