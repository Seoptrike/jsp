<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5 justify-content-start">
	<div>
		<div class="card">
			<div class="card-header text-center">
				<h5>로그인</h5>
			</div>
			<div class="care-body">
				<form name="sidefrm">
					<input class="form-control mb-3" name="uid"
						placeholder="아이디를 입력하세요"> <input class="form-control mb-3"
						name="upass" type="password" placeholder="비밀번호를 입력하세요"> <span><button
							class="btn btn-success w-100">로그인</button></span>
				</form>
			</div>
		</div>
	</div>
</div>


<script>
	$(sidefrm).on("submit",function(e){
		e.preventDefault();
		const uid=$(sidefrm.uid).val();
		const upass=$(sidefrm.upass).val();
		if(uid==""){
			alert("아이디를 입력하세요!")
		}else if(upass==""){
			alert("비밀번호를 입력하세요!")
		}else{
			$.ajax({
				type:"post",
				url: "/user/sidelogin",
				data:{uid,upass},
				success: function(data){
					if(data==1){
						alert("성공");
						location.href="/sidemypage";
					}else if (data==2){
						alert("비밀번호가 일치하지 않습니다")
						$(sidefrm.upass).val("");
						$(sidefrm.upass).focus();
					}else if(data==0){
						alert("아이디가 존재하지 않습니다.")
						$(sidefrm.uid).val("");
						$(sidefrm.uid).focus();
					}
				}
			})
		}
	})
	
	
</script>