<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>주문하기</h1>
	<div id="div_order"></div>
		<table class="table table-striped table-bordered">
			<tr class="table-dark text-end">
					<td id="order_total">총 결제금액 :</td>
			</tr>
		</table>
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
		<tr class="text-center" gid="{{gid}}">
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
	}
</script>