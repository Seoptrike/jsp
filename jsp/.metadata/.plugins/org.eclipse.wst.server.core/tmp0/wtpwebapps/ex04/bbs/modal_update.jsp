<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal fade" id="modalUpdate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel1">댓글 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <div class="modal-body w-100">
        
        
        	<form name="frm">
        		<input name="cid" value="${comment.cid}" type="hidden">
     			<input id="mWriter" class="form-control mb-2" placeholder="이름" value="${user.uid}">	
       			<textarea id="mContents" rows="5" class="form-control">${comment.contents}</textarea>
       			<div class="modal-footer">
      				<button type="button" type="submit" class="btn btn-primary">수정하기</button>
       				<button type="button" type="reset" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
     			</div>
       		</form>
      </div>
    </div>
  </div>
</div>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		const contents=$(frm.contents).val();
		int cid=$(frm.cid).val();
		if(contents==""){
			alert("내용을 입력하세요!");
			$(frm.title).focus();
		}else{
			if(!confirm("수정하시겠습니까?")) return; 
			$.ajax({
				type:"post",
				url:"/com/update",
				data:{cid,contents},
				success:function(){
				alert("수정 완료!")
				}
			})
		}
	});
</script>