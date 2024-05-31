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
    
<div id="page-cart">
	<h1>장바구니</h1>
	<div class="text-end mb-2">
		<button class="btn btn-warning" id="cart-delete">선택삭제</button>
	</div>
	<div id="div_cart"></div>
		<table class="table table-striped table-bordered">
			<tr class="table-dark text-end">
					<td id="div_total">총 결제금액 :</td>
			</tr>
		</table>
	<div class="text-center">
		<button class="btn btn-primary btn-lg px-4" id="btn-order">주문 하기</button>
		<a href="/" class="btn btn-secondary btn-lg" id="return">쇼핑 계속하기</a>
	</div>
</div>
<div id="page-order" style="display:none;">
	<jsp:include page="order.jsp"></jsp:include>
</div>
<script id="temp_cart" type="x=handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td><input type="checkbox" id="all"></td>
			<td>상품번호</td>
			<td colspan=2>상품명</td>
			<td>상품가격</td>
			<td>수량</td>
			<td>금액</td>
			<td>삭제</td>
		</tr>
		{{#each .}}
		<tr class="text-center" gid="{{gid}}">
			<td><input type="checkbox" class="chk" goods="{{toString @this}}"></td>
			<td>{{gid}}</td>
			<td><img src={{image}} width="50" index="{{@index}}"></td>
			<td>
				<a href="/goods/read?gid={{gid}}">{{{title}}}</a>
			</td>
			<td>{{fmtPrice price}}</td>
			<td>
				<button class="btn btn-primary btn-sm" id="btn-down"><i class="bi bi-caret-left-fill"></i></button>
				<input class="qnt text-center" value="{{qnt}}" size=2>
				<button class="btn btn-primary btn-sm" id="btn-up"><i class="bi bi-caret-right-fill"></i></button>
			</td>
			<td>{{sum price qnt}}</td>
			<td>
				<button class="btn btn-danger btn-sm delete"><i class="bi bi-trash3-fill"></i></button>
			</td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	Handlebars.registerHelper("fmtPrice",function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	})
	
	Handlebars.registerHelper("sum",function(price,qnt){
		const sum= price*qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	})
	
	Handlebars.registerHelper("toString",function(goods){
		return JSON.stringify(goods);
	})
</script>
<script>
getData();
	//주문하기 버튼을 클릭한 경우
	$("#btn-order").on("click",function(){
		const chk=$("#div_cart .chk:checked").length;
		if(chk==0){
			alert("주문할 상품을 선택하세요!");
			return;
		}
		//체크된 상품정보를 data배열에 저장
		let data=[];
		$("#div_cart .chk:checked").each(function(){
			const goods=$(this).attr("goods");
			data.push(JSON.parse(goods));
		});
		console.log(data);
		getOrder(data);
		$("#page-cart").hide();
		$("#page-order").show();
	});

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
				const temp=Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
				let total=0;
				$(data).each(function(){
					//console.log(this.price);
					const price = this.price;
					const qnt = this.qnt;
					const sum = price*qnt;
					total += sum;
				});
				console.log(total);
				$("#div_total").html("총 결제금액: "+total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+" 원");
			}
		})
	}
	
	//수량 변경 버튼
	$("#div_cart").on("click", "#btn-up", function(){
		const exqnt= parseInt( $(this).parent().find(".qnt").val() );
		const qnt= exqnt+1;
		const gid=$(this).parent().parent().attr("gid");
		//alert(uid+":"+qnt+":"+gid);
		$.ajax({
			type:"post",
			url:"/cart/update",
			data:{gid,uid,qnt},
			success:function(){
				getData();
			}
		})
	})
	
	$("#div_cart").on("click", "#btn-down", function(){
		const exqnt=  $(this).parent().find(".qnt").val();
		const qnt= exqnt-1;
		const gid=$(this).parent().parent().attr("gid");
		//alert(uid+":"+qnt+":"+gid);
		if(exqnt=="1"){
			$("#btn-down").attr("disabled", true);
		}else{
			$.ajax({
				type:"post",
				url:"/cart/update",
				data:{gid,uid,qnt},
				success:function(){
					getData();
				}
			})
		}
	})

	//선택삭제 버튼을 눌렀을때
	$("#cart-delete").on("click",function(){
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
		const gid=$(this).parent().parent().attr("gid");
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
	