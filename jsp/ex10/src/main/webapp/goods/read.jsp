<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>       
<div>
	<div class="row my-5">
		<div class="col">
			<img src="${goods.image}" width="90%">
		</div>
		<div class="col my-5">
			<h3> ${goods.title} </h3>
			<hr>
			<div>가격: <fmt:formatNumber pattern="#,###" value="${goods.price}"/></div>
			<div>제조사: ${goods.brand}</div>
			<div>등록일: ${goods.regDate}</div>
			<div>배송정보: 우체국택배</div>
			<div>배송일: 3~5일 소요</div>
			<div>카드할인: 하나카드 무이자 최대 12개월</div>
			
			<div class="my-3 text-center">
				<button class="btn btn-danger">성인인증</button>
				<button class="btn btn-primary"> 바로구매</button>
				<button class="btn btn-success" id="cart"><i class="bi bi-cart4"> 장바구니</i></button>
			</div>
		</div>
	</div>
</div>

<script>
	const gid = "${goods.gid}"
	$("#cart").on("click",function(){
		if(uid){
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{gid,uid},
				success:function(data){
					if(data=="true"){
						alert("장바구니에 넣었습니다!")
					}else{
						alert("장바구니에 존재하는 상품입니다.")
					}
				}
			})
		}else{
			sessionStorage.setItem("target","/goods/read?gid="+gid);
			location.href="/user/login";
		}
	})
</script>