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
	<h1>장바구니</h1>
	<div id="div_cart"></div>
	<div class="text-end">
		<button class="btn btn-warning" id="delete">선택삭제</button>
	</div>
</div>

<script id="temp_cart" type="x=handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td><input type="checkbox" id="all"></td>
			<td>상품번호</td>
			<td colspan=2>상품명</td>
			<td>상품가격</td>
			<td>수량</td>
			<td>삭제</td>
		</tr>
		{{#each .}}
		<tr>
			<td class="text-center"><input type="checkbox" class="chk" gid={{gid}}></td>
			<td class="text-center">{{gid}}</td>
			<td><img src={{image}} width="50" index="{{@index}}"></td>
			<td class="text-center">
				<a href="/goods/read?gid={{gid}}">{{{title}}}</a>
			</td>
			<td class="text-center">{{fmtPrice price}}</td>
			<td class="text-center"><input value="{{qnt}}" size=2></td>
			<td class="text-center">
				<button class="btn btn-danger btn-sm delete" gid="{{gid}}">삭제</button>
			</td>
		</tr>
		{{/each}}
		<tr class="table-dark text-end">
			<td colspan=5>총 결제금액 :</td>
			<td colspan=2><input value="" size=20 readonly></td>
		</tr>
	</table>
</script>
<script>
	Handlebars.registerHelper("fmtPrice",function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
	})
</script>
<script>
getData();
	function getData(){
		let size=10;
		let page= 1;
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			data:{uid},
			success:function(data){
				//console.log(data);
				let total=0;
				$(data).each(function(){
					//console.log(this.price);
					total+=this.price*this.qnt;
				});
				console.log(total);
				const temp=Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
			}
		})
	}
	
	//선택삭제 버튼을 눌렀을때
	$("#delete").on("click",function(){
		const chk=$("#div_cart .chk:checked").length;
		if(chk==0){
			alert("삭제할 상품을 선택해주세요");
			return;
		}
		if(!confirm(chk+" 개 상품을 삭제하시겠습니까?")) return;
		
		let cnt=0;
		let success=0;
		$("#div_cart .chk:checked").each(function(){
			const gid = $(this).attr("gid");
			$.ajax({
				type:"post",
				url:"/cart/delete",
				data:{gid,uid},
				success:function(data){
					cnt++;
					if(data=="true") success++;
					if(cnt==chk){
						alert(success + " 개 상품이 삭제되었습니다");
						getData();
					}
				}
			})
		})
	})
	
	$("#div_cart").on("click",".delete",function(){
		const gid=$(this).attr("gid");
		if(confirm(gid + "번 상품을 삭제하시겠습니까?")){
			//삭제하기
			$.ajax({
				type:"post",
				url:"/cart/delete",
				data:{gid,uid},
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
	

	$("#div_cart").on("click","#all",function(){
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$(this).prop("checked",true);
			})
		}else{
			$("#div_cart .chk").each(function(){
				$(this).prop("checked",false);
			})
		}
	})
	
		//각 행의 체크박스를 클릭한 경우
	$("#div_cart").on("click", ".chk",function(){
		let all=$("#div_cart .chk").length;
		let chk=$("#div_cart .chk:checked").length;
		if(all==chk){
			$("#div_cart #all").prop("checked",true);
		}else{
			$("#div_cart #all").prop("checked",false);
		}
	})
</script>	
	