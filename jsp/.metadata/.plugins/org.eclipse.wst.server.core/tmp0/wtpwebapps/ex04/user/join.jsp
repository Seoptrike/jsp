<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	span{width:100px;}
</style>    
    
  <div class="row  justify-content-center my-5">
	<div class="col-10 col-md-8 col-lg-6">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center mt-2"> 회원가입 </h3>
			</div>
			
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">아이디</span>
						<input id="uid" class="form-control">
						<button id="btnCheck" type="button" class="btn btn-warning"> 중복체크</button>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">비밀번호</span>
						<input id="upass" type="password" class="form-control">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">이름</span>
						<input id="uname" class="form-control">
					</div>
					<div class="text-center">
						<button class="btn btn-success">회원가입</button>
						<button  type="reset" class="btn btn-danger px-4" >취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	let check= false;
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		const uname=$(frm.uname).val();
		if(uid==""||uname==""||upass==""){
			alert("모든 정보를 입력하세요!")
			return;
		}
		if(check==false){
			alert("아이디 중복체크를 하세요!");
			return;
		}
		
		if(confirm("회원가입을 하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/user/join",
				data:{uid,upass,uname},
				success:function(){
					alert("회원가입 완료!");
					location.href="/user/login"
				}
			})
		}
		});
	
	$("#btnCheck").on("click",function(){
		const uid=$(frm.uid).val();
		if(uid==""){
			alert("사용자 아이디를 입력하세요!")
		}else{
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{uid},
			success:function(data){
				if(data==0){
					alert("사용 가능한 아이디 입니다.")
					check=true;
				}else{
					alert(" 이미 사용중인 아이디 입니다.")
				}
			}
		})
		}
	});
	
	// 아이디가 바뀐경우
	$(frm.uid).on("change", function(){
		check=false;
	})
</script>