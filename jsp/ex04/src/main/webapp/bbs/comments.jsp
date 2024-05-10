<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	#imgCphoto{
		border-radius:50%;
		border : 1px solid black;
	}
	#delete,#update{
	 	cursor:pointer;
	 	font-size:25px;
	}
</style>

<div class="mt-5 text-end" id="div_insert">
	<textarea id="contents" rows="5" class="form-control" placeholder="댓글 내용을 입력하세요."></textarea>
	<button class="btn btn-dark px-5 mt-2 insert">등록</button>
</div>
<div class="mt-5" id="div_login">
	<button class="btn btn-success w-100">로그인</button>
</div>

<div class="card-body">
	<div id= "div_comments"></div>
</div>
<div id="pagination" class="pagination justify-content-center mt-5"></div>

<script id="temp_comments" type="x-handlebars-template">

	{{#each .}}
		<div class="row mt-5">
			<div class="col-2">
				<img id="imgCphoto" width=80 height=80 src="{{photo}}"/>
			</div>
			<div class="col-10">
				<div class="row">
					<div class="col">
						<span><b>{{cid}}</b> :</span>
						<span>{{writer}}</span>
						<span>{{cdate}}</span>
					</div>
					<div class="col text-end"></span>
						<span><i class="bi bi-pencil-square update" style="{{update writer}}"></i>	
						<span><i class="bi bi-trash3 ms-3 delete" style="{{delete writer}}" cid="{{cid}}"></i></span>
					</div>
				</div>
				<div class="row mt-3">
					<div class="mb-3 ellipsis2">:{{contents}}</div>
				</div>
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("delete",function(writer){
		if(uid!=writer){
			return "display:none";
		}
	});
	
	Handlebars.registerHelper("update",function(writer){
		if(uid!=writer){
			return "display:none";
		}
	});
</script>

<script>
	const bid= "${bbs.bid}";
	let page=1;
	let size=3;
	if(uid){
		$("#div_insert").show();
		$("#div_login").hide();		
	}else{
		$("#div_insert").hide();
		$("#div_login").show();	
	}
	//수정 버튼을 클릭한 경우
	$("#div_comments").on("click",".update",function(){
		$.ajax({
			type:"get",
			url:"/com/read",
			success:function(){
				alert("1111");
			}
		})
		
		
	})
	
	//삭제 버튼을 클릭한 경우
	$("#div_comments").on("click",".delete", function(){
		const cid=$(this).attr("cid");
		if(confirm(cid+ " 번 댓글을 삭제하실래요?")){
			$.ajax({
				type:"post",
				url:"/com/delete",
				data:{cid},
				success:function(){
					alert("삭제완료!")
					getTotal();
				}
			})
		}
	})
	
	//로그인 버튼을 클릭한 경우
	$("#div_login").on("click",function(){
		sessionStorage.setItem("target", "/bbs/read?bid=" + bid);
		location.href="/user/login";
	})
	
	// 등록 버튼을 클릭한 경우
	
	$("#div_insert").on("click", ".insert", function(){
		const contents=$("#contents").val();
		if(contents==""){
			alert("댓글내용을 입력하세요!");
			$("#contents").focus();
			return;
		}else{
		$.ajax({
			type:"post",
			url:"/com/insert",
			data:{bid, contents, uid},
			success:function(){
				page=1;
				getTotal();
				contents=$("#contents").val("");
			}	
		})
	}
	})

	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/com/list.json",
			data:{bid, page, size},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_comments").html());
				$("#div_comments").html(temp(data));
			}
		})
	}
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			data:{bid},
			url:"/com/total",
			success:function(data){
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				$("#total").html("댓글수:" + data + "건")
				}
		});
	}
	
	 $('#pagination').twbsPagination({
	      totalPages:100, 
	      visiblePages: 5, 
	      startPage : 1,
	      initiateStartPageClick: false, 
	      first:'<i class="bi bi-chevron-double-left text-dark"></i>', 
	      prev :'<i class="bi bi-chevron-left text-dark"></i>',
	      next :'<i class="bi bi-chevron-right text-dark"></i>',
	      last :'<i class="bi bi-chevron-double-right text-dark"></i>',
	      onPageClick: function (event, clickPage) {
	          page=clickPage; 
	          getData();
	      }
	   });
</script>