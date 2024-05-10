<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.input-group span{
		width: 150px;
	}
</style>
<div class="row my-5 justify-content-center">
	<div class="col-10 col-md-8">
		<div class="card">
			<div class="card-header text-bg-dark">
				<h3 class="text-center ">강좌 수정</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">강좌번호</span>
						<input name="lcode" class="form-control" value="${cou.lcode}">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">학생학과</span>
						<select class="form-select" name="dept">
							<option value="전산">컴퓨터정보공학과</option>
							<option value="전자">전자공학과</option>
							<option value="건축">건축공학과</option>
						</select>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">강좌이름</span>
						<input name="lname" class="form-control" value="${cou.lname}">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">담당교수</span>
						<input value="${cou.instructor}" name="instructor" class="form-control me-1" placeholder="교수번호" readonly>
						<input value="${cou.pname}" name="pname" class="form-control" placeholder="교수이름" readonly>
						<button class="btn btn-primary" type="button" id="search">검색</button>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">최대수강인원</span>
						<input value="${cou.capacity}" name="capacity" class="form-control" value="30" type="number">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">강의실</span>
						<input value="${cou.room}" name="room" class="form-control" value="203">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">강의시간</span>
						<input value="${cou.hours}" name="hours" class="form-control" value="2" type="number">
					</div>
					<div class="text-center mt-3">
						<button class="btn btn-primary">강의등록</button>
						<button class="btn btn-secondary" type="reset">등록취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="modal.jsp"/>

<script>

	//검색버튼을 클릭한 경우
	$("#search").on("click", function(){
		$("#modalCou").modal("show");	
	});
	
	$(frm.instructor).on("click", function(){
		$("#modalCou").modal("show");	
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const lname=$(frm.lname).val();
		const instructor=$(frm.instructor).val();
		if(lname=="" || instructor==""){
			alert("강좌이름과 담당교수를 입력하세요!");
			$(frm.lname).focus();
			return;
		}
		if(confirm("강좌를 수정하시겠습니까?")){
			frm.method="post";
			frm.submit();
		}
	});
</script>