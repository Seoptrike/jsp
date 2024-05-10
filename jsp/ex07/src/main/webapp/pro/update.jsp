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
			<div class="card-header">
				<h3 class="text-center"> 정보 수정 </h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수번호</span>
						<input class="form-control" name="pcode" value="${pro.pcode}" readonly>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수이름</span>
						<input class="form-control" value="${pro.pname}" name="pname">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수학과</span>
						<select class="form-select" name="dept">
							<option value="전산"<c:out value="${pro.dept=='전산'?'selected':''}"/>>컴퓨터정보공학과</option>
							<option value="전자"<c:out value="${pro.dept=='전자'?'selected':''}"/>>전자공학과</option>
							<option value="건축"<c:out value="${pro.dept=='건축'?'selected':''}"/>>건축공학과</option>
						</select>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수직급</span>
						<div class="form-check m-2">
							<input <c:out value="${pro.title=='정교수'?'checked':''}"/> class="form-check-input" name="title" id="정교수" type="radio" value="정교수" >
							<label class= form-check-label for="정교수">정교수</label>
						</div>	
						<div class="form-check m-2">
							<input <c:out value="${pro.title=='부교수'?'checked':''}"/> class="form-check-input" name="title" id="부교수" type="radio" value="부교수">
							<label class= form-check-label for="부교수">부교수</label>
						</div>
						<div class="form-check m-2">
							<input <c:out value="${pro.title=='조교수'?'checked':''}"/> class="form-check-input" name="title" id="조교수" type="radio" value="조교수">
							<label class= form-check-label for="조교수">조교수</label>
						</div>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수급여</span>
						<input name="salary" class="form-control" type="number" value="${pro.salary}" step="1000000">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">임용일자</span>
						<input name="hiredate" class="form-control" value="${pro.hiredate}" type="date">
					</div>
					
					<div class="text-center mt-3">
						<button class="btn btn-success">정보수정</button>
						<button class="btn btn-secondary" type="reset">수정취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
$(frm).on("submit",function(e){
	e.preventDefault();
	const pname=$(frm.pname).val();
	if(pname==""){
		alert("교수이름을 입력하세요!")
		$(frm.pname).focus();
		return;
	}
	
	if(confirm("교수 정보를 수정하시겠습니까?")){
		frm.method="post";
		frm.submit();
	}
})
</script>
