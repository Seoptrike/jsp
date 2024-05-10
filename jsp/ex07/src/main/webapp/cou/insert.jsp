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
			<div class="card-header text-center text-bg-dark">
				<h3> 강좌 등록 </h3>
			</div>
			<div class="card-body">
				<form name="frm">
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
						<input class="form-control" name="lname">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">강의시간</span>
						<select class="form-select" name="hours">
							<option value=1>1시간</option>
							<option value=2>2시간</option>
							<option value=3>3시간</option>
						</select>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">강의실</span>
						<input class="form-control" type="number" name="room">
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">최대인원</span>
						<input class="ms-3" style="width:350px" type="range" name="capacity" id="capacity" max="120" value="120" onchange="showValue()">
						<span class="ms-2 mt-2" id="range"></span>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">담당교수</span>
						<input class="form-control" name="instructor" placeholder="교수번호" readonly>
						<input name="pname" class="form-control" placeholder="교수이름" readonly>
						<button class="btn btn-success" type="button" id="search">검색</button>
					</div>
					
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center text-bg-secondary">강좌번호</span>
						<input class="form-control" name="lcode" value="${code}" readonly>
					</div>
					
					<div class="text-center mt-3">
						<button class="btn btn-success">강좌등록</button>
						<button class="btn btn-secondary" type="reset">등록취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="modal.jsp"></jsp:include>

<script>
	let key1= $(frm.dept).val();
	
	$("#search").on("click",function(){
		$("#modalCou").modal("show");
	});
	
	$(frm.dept).on("change",function(){
		$(frm.lcode).html($(frm.lcode).val("${code}"));
	})
	showValue()
	function showValue(){
		$("#capacity").val();
		$("#range").html($(frm.capacity).val()+"명");
	}

$(frm).on("submit",function(e){
	e.preventDefault();
	const lname=$(frm.lname).val();
	const instructor=$(frm.instructor).val();
	if(lname==""|| instructor==""){
		alert("강좌이름을 입력하세요!")
		$(frm.lname).focus();
		return;
	}
	
	if(confirm("새로룬 강좌를 등록하시겠습니까?")){
		frm.method="post";
		frm.submit();
	}
})
</script>
