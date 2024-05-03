<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 	span{width:100px;}
 </style>   
    
<div class= "row my-4 justify-content-center">
	<div class="col-8 col-md-6 col-lg-4">
		<div class="card">
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2 ">
						<span class="input-group-text justify-content-center" >아이디</span>
						<input class="form-control" id="uid">
					</div>	
					<div class="input-group mb-2 ">
						<span class="input-group-text justify-content-center">비밀번호</span>
						<input type="password" class="form-control" id="upass">
					<button class= "btn btn-success w-100 mt-2">LOGIN</button>
					</div>
					<div class="text-center">	
					<span><a href="/">아이디 찾기 </a></span>
					<span><a href="/">비밀번호 찾기</a></span>
					<span><a href="/user/join">회원가입</a></span>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	$(frm).on("submit",function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		if(uid==""){
			alert("아이디를 입력하세요!")
		}else if(upass==""){
			alert("비밀번호를 입력하세요!")
		}else{
			$.ajax({
				type:"post",
				url: "/user/login",
				data:{uid,upass},
				success: function(data){
					if(data==1){
						alert("성공");
						let target=sessionStorage.getItem("target");
						if(target){
							location.href= target ;
						}else{
							location.href="/";
						}
					}else if (data==2){
						alert("비밀번호가 일치하지 않습니다")
						$(frm.upass).val("");
						$(frm.upass).focus();
					}else if(data==0){
						alert("아이디가 존재하지 않습니다.")
						$(frm.uid).val("");
						$(frm.uid).focus();
					}
				}
			})
		}
	})
	
	
</script>