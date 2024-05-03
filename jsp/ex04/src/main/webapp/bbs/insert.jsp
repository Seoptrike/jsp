<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row justify-content-center">
	<div class="col-10">
		<h1>글쓰기</h1>
		<form name="frm" method="post">
			<input name="writer" value="${user.uid}" type="hidden">
			<input name="title" placeholder="제목을 입력하세요." class="form-control mb-2">
			<textarea name="contents" rows="15" class="form-control" placeholder="내용을 입력하세요."></textarea>
			<div class= "text-center mt-2">
				<button type="submit" class="btn btn-success px-5">저장</button>
				<button type="reset" class="btn btn-warning px-5">취소</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		const title=$(frm.title).val();
		if(title==""){
			alert("제목을 입력하세요!");
			$(frm.title).focus();
		}else{
			if(!confirm("저장하실래요?")) return; 
			frm.submit();
		}
	});
</script>