<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <style>
 	td{
 		display: table-cell;
 	 	vertical-align: middle;
  }
 </style>     
    
<div>
	<h1>상품목록</h1>
	<div id="div_shop"></div>
</div>

<script id="temp_shop" type="x-handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td><input type="checkbox" id="all"></td>
			<td>아이디</td><td colspan=2>상품명</td><td>상품가격</td><td>저장</td>
		</tr>
		{{#each .}}
		<tr>
			<td class="text-center"><input type="checkbox" class="chk"></td>
			<td class="text-center">{{gid}}</td>
			<td><img src={{image}} width="50"></td>
			<td class="text-center">
				<div class="ellipsis">{{{title}}}</div>
				<div>{{regDate}}</div>
			</td>
			<td class="text-center">{{price}}</td>
			<td class="text-center"><button class="btn btn-danger btn-sm delete" gid="{{gid}}">삭제</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	getData();
	
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
						getData();
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
			success:function(data){
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
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
</script>