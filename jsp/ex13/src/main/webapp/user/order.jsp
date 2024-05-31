<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<H1>주문목록</H1>
	<div id="div_pur"></div>
	<jsp:include page="modal_orders.jsp"/>
</div>

<script id="temp_pur" type="x=handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>주문번호</td>
			<td>전화</td>
			<td>주문일</td>
			<td>금액</td>
			<td>상태</td>
			<td>주문상품</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{pid}}</td>
			<td>{{phone}}</td>
			<td>{{pdate}}</td>
			<td>{{fmtsum sum}}</td>
			<td>{{status status}}</td>
			<td><button class="btn btn-primary btn-sm orders" 
					pid="{{pid}}" raddress1="{{raddress1}}" raddress2="{{raddress2}}">주문상품</button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	Handlebars.registerHelper("status", function(status){
		switch(status){
		case 0:
			return "결제대기";
		case 1:	
			return "결제확인";
		case 2:
			return "배송준비";
		case 3:
			return "배송완료";
		case 4:
			return "주문완료";
		}
	})
</script>
<script>
	Handlebars.registerHelper("fmtsum",function(sum){
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	})
</script>

<script>
	getData();

	//주문상품 버튼을 클릭한 경우
	$("#div_pur").on("click", ".orders", function(){
		const pid=$(this).attr("pid");
		const raddress1=$(this).attr("raddress1");
		const raddress2=$(this).attr("raddress2");
		$("#modalOrders").modal("show");
		$("#pid").html("주문번호:" + pid);
		$("#address").html("배송지: " + raddress1 + " " + raddress2);
		getOrders(pid);
	});
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/pur/list.json",
			data:{uid},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_pur").html());
				$("#div_pur").html(temp(data));
			}
		})
	};
</script>