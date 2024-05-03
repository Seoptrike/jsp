<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#modalPass{
		top:30%;
	}
</style>

<div class="modal fade" id="modalPass" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">비밀번호변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
         <input id="upass" placeholder="현재 비밀번호" class="form-control mb-2">
         <input id="npass" placeholder="새 비밀번호" class="form-control mb-2">
         <input id="cpass" placeholder="비밀번호 확인" class="form-control mb-2">
      </div>
      <div class="text-center mb-5">
        <button id= "btnSave"  class="btn btn-primary">변경완료</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
      </div>
    </div>
  </div>
</div>
<script>
	$("#modalPass").on("click","#btnSave",function(){
		const upass = $("#upass").val();
		const npass = $("#npass").val();
		const cpass = $("#cpass").val();
		if(upass==""||npass==""||cpass==""){
			alert("비밀번호를 입력하세요.")
		}else{
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid,upass},
				success:function(data){
					if(data==2){
						alert("현재 비밀번호가 일치하지 않습니다.")
						$("#npass").val("");
						$("#npass").focus();
						$("#cpass").val("");
						$("#cpass").focus();
						$("#upass").val("");
						$("#upass").focus();
					}else{
						if(npass!=cpass){
							alert("새 비밀번호가 일치하지 않습니다.")
							$("#npass").val("");
							$("#npass").focus();
							$("#cpass").val("");
							$("#cpass").focus();
							$("#upass").val("");
							$("#upass").focus();
							
						}else if(npass==upass){
							alert("기존 비밀번호와 다르게 설정해주십시오.")	
							$("#npass").val("");
							$("#npass").focus();
							$("#cpass").val("");
							$("#cpass").focus();
							$("#upass").val("");
							$("#upass").focus();
						}else{
							if(!confirm("비밀번호를 변경하실래요?"))return;
							$.ajax({
								type:"post",
								url:"/user/update/pass",
								data:{uid, npass},
								success:function(){
									alert("비밀번호가 변경되었습니다.");
									location.href="/user/logout";
								}
							})
						}
					}
				}
			})
		}
	})
</script>