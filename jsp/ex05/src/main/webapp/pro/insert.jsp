<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	.input-group span{
		width:150px;
	}
</style>    
    
<div class="row my-5 justify-content-center">
	<div class="col-10 col-md-8">
		<div class="card">
			<div class="card-header">
				<h3> 교수 등록 </h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수번호</span>
						<input class="form-control" name="pcode" value="${code}" readonly>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수이름</span>
						<input class="form-control" name="pname">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수학과</span>
						<select class="form-select" name="dept">
							<option value="전산">컴퓨터정보공학과</option>
							<option value="전기">전기공학과</option>
							<option value="건축">건축공학과</option>
						</select>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수직급</span>
						<div class="form-check m-2">
							<input class="form-check-input" name="title" id="정교수" type="radio" value="정교수">
							<label class= form-check-label for="정교수">정교수</label>
						</div>	
						<div class="form-check m-2">
							<input class="form-check-input" name="title" id="부교수" type="radio" value="부교수">
							<label class= form-check-label for="부교수">부교수</label>
						</div>
						<div class="form-check m-2">
							<input class="form-check-input" name="title" id="조교수" type="radio" value="조교수">
							<label class= form-check-label for="조교수">조교수</label>
						</div>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">교수급여</span>
						<input name="salary" class="form-control" type="number" value="0" step="1000000">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">임용일자</span>
						<input name="hiredate" class="form-control" type="date">
					</div>
					
					<div class="text-center mt-3">
						<button class="btn btn-success">교수등록</button>
						<button class="btn btn-secondary" type="reset">등록취소</button>
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
	
	if(confirm("새로룬 교수를 등록하시겠습니까?")){
		frm.method="post";
		frm.submit();
	}
})
</script>
