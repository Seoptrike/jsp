<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#modalInfo{
		top:30%;
	}
</style>

<div class="modal fade" id="modalInfo" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-center" id="staticBackdropLabel">정보수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body w-100">
     	<input id="uname" class="form-control mb-2" placeholder="이름" value="${user.uname}">	
       	<input id="phone" class="form-control mb-2" placeholder="전화번호" value="${user.phone}">
       	<div class="input-group mb-1">
       		<input id= address1 class="form-control" value="${user.address1}">
       		<button id="btnSearch" class= "btn btn-success">검색</button>
       	</div>
       	<input id=address2 class="form-control" placeholder="상세주소" value="${user.address2}">
      </div>
      
       <div class="text-center mb-5">
        <button id= "btnSave"  class="btn btn-primary">변경완료</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
      </div>
      
    </div>
  </div>
</div>
<script>
	$("#btnSearch").on("click", function(){
	    new daum.Postcode({
	          oncomplete:function(data){
	              console.log(data);
	              const building=data.buildingName;
	              let address="";
	              if(building!=""){
	                  address=data.address + "(" + building + ")";
	              }else{
	                  address=data.address;
	              }
	              $("#address1").val(address);
	          }
	      }).open();
	 });

	$("#modalInfo").on("click","#btnSave",function(){
		const uname=$("#uname").val();
		const phone=$("#phone").val();
		const address1=$("#address1").val();
		const address2=$("#address2").val();
		console.log(uname,phone,address1,address2,uid);
		
		if(confirm("수정하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/user/update",
				data:{uid,uname,phone,address1,address2},
				success:function(){
					alert("수정이 완료되었습니다.")
					location.href="/user/mypage";
				}
			})
		}
		
	})
</script>