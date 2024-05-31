<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 	td{
 		display: table-cell;
 	 	vertical-align: middle;
  }
 </style>   
   
<div>
	<h1 class="mb-2">네이버 상품검색</h1>
<div class="row mb-2">
		<div class="col">
			<button class="btn btn-success" id="save">선택저장</button>
		</div>
		<form name="frm" class="col-8 col-md-5">
			<div class="input-group">
				<input name="query" class="form-control" value="쇼파">
				<button class="btn btn-primary">검색</button>
			</div>
		</form>
	</div>
	<div id="div_shop"></div>
	<div class="text-center">
		<button id="prev" class="btn btn-primary">이전</button>
		<span id="page" class="mx-3">1</span>
		<button id="next" class="btn btn-primary">다음</button>
	</div>
</div>

<script id="temp_shop" type="x-handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td><input type="checkbox" id="all"></td>
			<td>아이디</td><td colspan=2>상품명</td><td>상품가격</td><td>저장</td>
		</tr>
		{{#each items}}
		<tr gid="{{productId}}" img="{{image}}" title="{{title}}" brand="{{brand}}" price="{{lprice}}">
			<td class="text-center"><input type="checkbox" class="chk"></td>
			<td class="text-center">{{productId}}</td>
			<td><img src={{image}} width="50"></td>
			<td><div class="ellipsis text-center"">{{{title}}}</div></td>
			<td class="text-center">{{lprice}}</td>
			<td class="text-center"><button class="btn btn-warning btn-sm insert">저장</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let query=$(frm.query).val();
	let page=1;
	let size=50;
	
	//선택저장 버튼을 클릭한 경우
	$("#save").on("click", function(){
		let chk=$("#div_shop .chk:checked").length;
		if(chk==0){
			alert("저장할 상품들을 선택하세요!");
			return;
		}
		if(!confirm(chk + "개 상품을 등록하실래요?")) return;
		//상품등록
		let cnt=0;
		let success=0;
		$("#div_shop .chk:checked").each(function(){
			let tr=$(this).parent().parent();
			let gid=tr.attr("gid");
			let title=tr.attr("title");
			let image=tr.attr("img");
			let price=tr.attr("price");
			let brand=tr.attr("brand");
			console.log(gid, title, image, price, brand);
			$.ajax({
				type:"post",
				url:"/goods/insert",
				data:{gid, title, image, price, brand},
				success:function(data){
					cnt++;
					if(data=="true") success++;
					if(chk==cnt){
						alert(success + "개 상품 등록성공!");
						getData();
					}
				}
			});
		});
	});

	$("#div_shop").on("click",".insert",function(){
		let tr=$(this).parent().parent();
		let gid=tr.attr("gid");
		let title=tr.attr("title");
		let image=tr.attr("img");
		let price=tr.attr("price");
		let brand=tr.attr("brand");
		$.ajax({
			type:"post",
			url:"/goods/insert",
			data:{gid,title,brand,image,price},
			success:function(data){
				if(data=="true"){
					alert("입력성공!");
				}else{
					alert("이미 등록된 상품입니다!");
				}
			}
		})	
	})
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		query=$(frm.query).val();
		getData();
	});
	$("#next").on("click",function(){
		page++;
		getData();
	})
	
	$("#prev").on("click",function(){
		page--;
		getData();
	})
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/search.json",
			dataType:"json",
			data:{query,size,page},
			success:function(data){
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
				
				$("#page").html(page);
				if(page==1){
					$("prev").attr("disabled",true);
				}else{
					$("prev").attr("disabled",false);
				}
				if(page==10){
					$("next").attr("disabled",true);
				}else{
					$("next").attr("disabled",false);
				}
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