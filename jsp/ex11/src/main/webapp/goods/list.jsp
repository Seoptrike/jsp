<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <style>
 	td{
 		display: table-cell;
 	 	vertical-align: middle;
  	}
  	
  	#div_shop img{
  		cursor:pointer;
  	}
 </style>     
    
<div>
	<h1>상품목록</h1>
	<div class="row mb-2">
		<div class="col">
			<button class="btn btn-warning" id="delete">선택삭제</button>
		</div>
		<div class="col-4">
			<form name="frm">
			<div class="input-group">
				<span id="total" class="mt-2 me-3"></span>
				<input placeholder="검색어" class="form-control" name="word">
				<button class="btn btn-success">검색</button>
			</div>
			</form>
		</div>
	</div>
		<div id="div_shop"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>

<script id="temp_shop" type="x-handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td><input type="checkbox" id="all"></td>
			<td>아이디</td><td colspan=2>상품명</td><td>상품가격</td><td>저장</td>
		</tr>
		{{#each .}}
		<tr>
			<td class="text-center"><input type="checkbox" class="chk" gid={{gid}}></td>
			<td class="text-center">{{gid}}</td>
			<td><img src={{image}} width="50" index="{{@index}}"></td>
			<td class="text-center">
				<div class="ellipsis">{{{title}}}</div>
				<div>{{regDate}}</div>
			</td>
			<td class="text-center">{{price}}</td>
			<td class="text-center">
				<button class="btn btn-danger btn-sm delete" gid="{{gid}}">삭제</button>
				<jsp:include page="modal_image.jsp"/>
			</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let page=1;
	let size=5;
	let word="";
	
	//이미지를 클릭했을때
	$("#div_shop").on("click","img", function(){
		const index= $(this).attr("index");
		$("#modal"+index).modal("show");	
	});
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		word=$(frm.word).val();
		page=1;
		getTotal();
	})
	
	getTotal();
	//선택삭제 버튼을 눌렀을때
	$("#delete").on("click",function(){
		const chk=$("#div_shop .chk:checked").length;
		if(chk==0){
			alert("삭제할 상품을 선택해주세요");
			return;
		}
		if(!confirm(chk+" 개 상품을 삭제하시겠습니까?")) return;
		
		let cnt=0;
		let success=0;
		$("#div_shop .chk:checked").each(function(){
			const gid = $(this).attr("gid");
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid},
				success:function(data){
					cnt++;
					if(data=="true") success++;
					if(cnt==chk){
						alert(success + " 개 상품이 삭제되었습니다");
						getTotal();
					}
				}
			})
		})
	})
	
	
	//삭제버튼을 눌렀을때
	$("#div_shop").on("click",".delete",function(){
		const gid=$(this).attr("gid");
		if(confirm(gid + "번 상품을 삭제하시겠습니까?")){
			//삭제하기
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid},
				success:function(data){
					if(data=="true"){
						alert("삭제성공!");
						getTotal();
					}else{
						alert("삭제실패!");
					}
				}
			});
		}
	});
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			dataType:"json",
			data:{word,size,page},
			success:function(data){
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		})
	}
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{word},
			success:function(data){
				const total= parseInt(data);
				if(total==0){
					alert("검색 내용이 없습니다!");
					$(frm.word).val("");
					return;
				}
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total>size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
				$("#total").html("검색수: " + total);
			}
		})
	}
	
	$("#div_shop").on("click","#all",function(){
		if($(this).is(":checked")){
			$("#div_shop .chk").each(function(){
				$(this).prop("checked",true);
			})
		}else{
			$("#div_shop .chk").each(function(){
				$(this).prop("checked",false);
			})
		}
	})
	
		//각 행의 체크박스를 클릭한 경우
	$("#div_shop").on("click", ".chk",function(){
		let all=$("#div_shop .chk").length;
		let chk=$("#div_shop .chk:checked").length;
		if(all==chk){
			$("#div_shop #all").prop("checked",true);
		}else{
			$("#div_shop #all").prop("checked",false);
		}
	})
	
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