<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="my-5">
	<div class="text-center my-3">
		<button class="btn btn-warning btn-lg" id="insert">리뷰작성</button>
	</div>
	<div id="div_review"></div>
</div>
<div id="pagination" class="pagination justify-content-center mt-5"></div>
<jsp:include page="modal_review.jsp"/>

<script id="temp_review" type="x-handlebars-template">
	{{#each .}}
		<div class="row mb-3">
			<div class="col" style="font-size:15px;">
				<span>{{rid}} . </span>
				<span style="font-weight:bold;">{{uid}}</span> |
				<span style="color:gray;"> {{revDate}}</span>
			</div>
			<div class="col text-end mb-2" style="{{display uid}}" rid="{{rid}}">
				<button class="btn btn-outline-success btn-sm update" content="{{content}}"><i class="bi bi-pencil-square"></i></button>
				<button class="btn btn-outline-danger btn-sm delete"><i class="bi bi-trash3-fill"></i></button>
			</div>
			<div class="ellipsis content" style="cursor:pointer">
				{{breaklines content}}
			</div>
		</div>
		<hr>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("display",function(writer){
		//let gid1="${param.gid}";
		if(uid!=writer) return "display:none";
	})
</script>

<script>
	let page=1;
	let size=5;
	let gid1="${param.gid}";
	
	//삭제 버튼을 클릭한 경우
	$("#div_review").on("click",".delete",function(){
		const rid=$(this).parent().attr("rid");
		if(!confirm(rid+"번 리뷰를 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/review/delete",
			data:{rid},
			success:function(){
				alert("리뷰삭제 성공!")
				getTotal();			
			}
		})
	})
	
	//수정 버튼을 클릭한 경우
	$("#div_review").on("click",".update",function(){
		const rid=$(this).parent().attr("rid");
		const content=$(this).attr("content");
		$("#modalReview").modal("show");
		$("#modalReview #content").val(content);
		$("#rid").val(rid);
		$("#btn-insert").hide();
		$("#btn-update").show();
	})
	
	//모달의 수정버튼을 누른 경우
	$("#btn-update").on("click",function(){
		const content=$("#content").val();
		const rid=$("#rid").val();
		//alert(rid +"\n"+content);
		if(!confirm("리뷰 내용을 수정하시겠습니가?")) return;
		$.ajax({
			type:"post",
			url:"/review/update",
			data:{rid,content},
			success:function(){
				alert("리뷰 수정 성공")
				$("#modalReview").modal("hide");
				getTotal();
			}
		})
	})
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			dataType:"json",
			data:{page,size, gid:gid1},
			success:function(data){
				const temp=Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
			}
		})
	}
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/review/total",
			data:{gid:gid1},
			success:function(data){
				const total= parseInt(data);
				if(total==0){
					getData();
					$("#pagination").hide();
					return;
				}
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total>size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
			}
		})
	}
	
	//일립시스 해제
	$("#div_review").on("click",".content",function(){
		$("#div_review .content").addClass("ellipsis");
		$(this).removeClass("ellipsis");
	})
	//리뷰 쓰기 버튼을 눌렀을대
	$("#insert").on("click",function(){
		if(uid){
			$("#content").val("");
			$("#modalReview").modal("show");
			$("#btn-insert").show();
			$("#btn-update").hide();
		}else{
			const target=window.location.href;
			sessionStorage.setItem("target",target);
			location.href="/user/login";
		}
	})
	
	Handlebars.registerHelper('breaklines', function(text) {
     text = Handlebars.Utils.escapeExpression(text);
     text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
     return new Handlebars.SafeString(text);
   });
	
	$('#pagination').twbsPagination({
	      totalPages:10, 
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