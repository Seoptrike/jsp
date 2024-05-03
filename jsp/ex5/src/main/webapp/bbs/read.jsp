<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>게시글정보</h1>
	<div class="text-end mb-2" id="div_update">
		<a href="/bbs/update?bid=${bbs.bid}" class="btn btn-success btn-sm px-3">수정</a>
		<button class="btn btn-warning btn-sm px-3 delete">삭제</button>
	</div>
	<div class="card">
		<div class="card-body">
			<div>[${bbs.bid}] ${bbs.title}</div>
			<hr>
			<div>${bbs.contents}</div>
		</div>
		<div class="card-footer text-muted text-end" style="font-size:12px;">
			<span>${bbs.bdate}</span>
			<span>${bbs.uname}(${bbs.writer})</span>
		</div>
	</div>
</div>

<script>
	const writer="${bbs.writer}";
	if(uid==writer){
		$("#div_update").show();
	}else{
		$("#div_update").hide();
	}
	
	$("#div_update").on("click",".delete",function(){
		const bid="${bbs.bid}";
		if(confirm(bid+"  번 게시글을 삭제하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/bbs/delete",
				data:{bid},
				success:function(){
					alert("삭제완료!");
					location.href="/bbs/list"
				}
			})
		}
	})
</script>