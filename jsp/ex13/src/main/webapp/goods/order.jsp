<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <style>
 	span{width:100px;}
 </style>   
    
<div>
	<h1>주문하기</h1>
	<div id="div_order"></div>
		<table class="table table-striped table-bordered">
			<tr class="table-primary text-end px-5">
					<td id="order_total">총 결제금액 :</td>
			</tr>
		</table>
	<div class="row justify-content-center">
		<div class="col-10 col-10-8">
			<div class="card">
				<div class="card-header text-bg-dark">
					<h3 class="text-center">주문 정보</h3>
				</div>
				<div class="card-body">
					<form name="frm">
						<div class="input-group mb-2">
							<span class="input-group-text text-bg-secondary">주문자명</span>
							<input name="rname" class="form-control" value="${user.uname}">
						</div>
						<div class="input-group mb-2">
							<span class="input-group-text text-bg-secondary">전화번호</span>
							<input name="rphone" class="form-control" value="${user.phone}">
						</div>
						<div class="input-group mb-2">
							<span class="input-group-text text-bg-secondary">주소</span>
							<input name="raddress1" class="form-control" value="${user.raddress1}">
							<button class="btn btn-success">검색</button>
						</div>
						<div class="input-group mb-2">
							<input name="raddress2" class="form-control" placeholder="상세주소" value="${user.raddress2}">
						</div>
						<div class="input-group mb-2">
							<textarea class="form-control" placeholder="배송시 요청사항"></textarea>
						</div>
						<input name="sum" type="hidden">
						<div class="text-center mt-3">
							<button class="btn btn-warning btn-lg">결제하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script id="temp_order" type="x=handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>상품번호</td>
			<td colspan=2>상품명</td>
			<td>상품가격</td>
			<td>수량</td>
			<td>금액</td>
		
		</tr>
		{{#each .}}
		<tr class="text-cente goods" gid="{{gid}}" price="{{price}}" qnt="{{qnt}}">
			<td>{{gid}}</td>
			<td><img src={{image}} width="50" index="{{@index}}"></td>
			<td>
				<a href="/goods/read?gid={{gid}}">{{{title}}}</a>
			</td>
			<td>{{fmtPrice price}}</td>
			<td>{{qnt}} 개</td>
			<td>{{sum price qnt}}</td>
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
</script>

<script>
	//주문하기 버튼을 누른 경우
	$(frm).on("submit",function(e){
		e.preventDefault();
		const rname=$(frm.rname).val();
		const rphone=$(frm.rphone).val();
		const raddress1=$(frm.raddress1).val();
		const raddress2=$(frm.raddress2).val();
		const sum=$(frm.sum).val();
		//console.log(uid,rname,rphone,raddress1,raddress2,sum);
		const cnt=$("#div_order .goods").length;
		if(!confirm(cnt +"개 상품을 주문하시겠습니까")) return;
		//주문정보 입력
		$.ajax({
			type:"post",
			url:"/pur/insert",
			data:{uid,rname,rphone,raddress1,raddress2,sum},
			success:function(pid){
				//주문상품 등록
				let order_cnt=0;
				$("#div_order .goods").each(function(){
					const gid= $(this).attr("gid");
					const price=$(this).attr("price");
					const qnt =$(this).attr("qnt");
					console.log(pid +":"+ gid +":"+ price +":"+ qnt);
					$.ajax({
						type:"post",
						url:"/order/insert",
						data:{pid,gid,price,qnt},
						success:function(){
							order_cnt++;
							//장바구니 삭제
							$.ajax({
								type:"post",
								url:"/cart/delete",
								data:{uid,gid},
								success:function(){
									if(cnt==order_cnt){
										alert(order_cnt+"개 주문상품 등록완료!")
										location.href="/";
									}
								}
							})
						}
					})
				})
			}
		})
		
	})
	function getOrder(data){
		const temp=Handlebars.compile($("#temp_order").html());
		$("#div_order").html(temp(data));
		let total=0;
		$(data).each(function(){
			//console.log(this.price);
			const price = this.price;
			const qnt = this.qnt;
			const sum = price*qnt;
			total += sum;
		});
		$("#order_total").html("총 결제금액: "+total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+" 원");
		$(frm.sum).val(total);
	}
</script>