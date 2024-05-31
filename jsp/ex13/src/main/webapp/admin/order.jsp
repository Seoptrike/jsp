<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>주문관리</h1>
	<div id="div_admin_order"></div>
</div>

<script id="temp_admin_order" type="x=handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>주문번호</td>
			<td>주문자</td>
			<td>전화</td>
			<td>주문일</td>
			<td>금액</td>
			<td>상태</td>
			<td>주문상품</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{pid}}</td>
			<td>{{uname}} ({{uid}})</td>
			<td>{{phone}}</td>
			<td>{{pdate}}</td>
			<td>{{fmtsum sum}}</td>
			<td>
				<div class="input-group">
				<select class="form-select status">
						<option value="0" {{selected status 0}}>결제대기</option>
						<option value="1" {{selected status 1}}>결제확인</option>
						<option value="2" {{selected status 2}}>배송준비</option>
						<option value="3" {{selected status 3}}>배송완료</option>
						<option value="4" {{selected status 4}}>주문완료</option>
					</select>
					<button class="btn btn-warning btn-sm update" pid="{{pid}}">변경</button>
				<div>
			</td>
			<td><button class="btn btn-primary btn-sm orders" 
					pid="{{pid}}" raddress1="{{raddress1}}" raddress2="{{raddress2}}">주문상품</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	Handlebars.registerHelper("fmtsum",function(sum){
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	})
	
	Handlebars.registerHelper("selected", function(status, value){
		if(status == value) return "selected"
	});
</script>

<script>
let key="uid";
let word="";
let page=1;
let size=5;

//상태변경 버튼 클릭한 경우
$("#div_admin_order").on("click",".update",function(){
	const pid=$(this).attr("pid");
	const status=$(this).parent().find(".status").val();
	//alert(pid+"........................"+status)
	if(!confirm("주문상태를 변경하시겠습니까?")) return;
	$.ajax({
		type:"post",
		url:"/admin/order/update",
		data:{pid, status},
		success:function(){
			alert("변경완료!");
			getData();
		}
	});
});

getData();
function getData(){
	$.ajax({
		type:"get",
		url:"/admin/order/list.json",
		data:{key,word,page,size},
		dataType:"json",
		success:function(data){
			const temp=Handlebars.compile($("#temp_admin_order").html());
			$("#div_admin_order").html(temp(data));
		}
	})
};
</script>