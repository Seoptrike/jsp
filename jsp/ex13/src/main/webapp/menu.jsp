<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-sm bg-secondary navbar-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="#">Logo</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/">HOME</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/cart/list" id="cart-item">장바구니</a></li>
					<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/order/list" id="order-item">주문목록</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/goods/search" id="search-item" >상품검색</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/goods/list" id="list-item">상품목록</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/admin/order/list" id="admin_order-item">주문관리</a></li>
			</ul>
			<ul class="navbar-nav mb-2 mb-lg-0 text-end">
				<li class="nav-item" id="login"><a class="nav-link active"
					aria-current="page" href="/user/login">LOG IN</a></li>
					
				<li class="nav-item fs-8" id="uid">
				<a class="nav-link active" aria-current="page" href="/user/mypage"></a>
				</li>
					
				<li class="nav-item" id="logout"><a class="nav-link active"
					aria-current="page" href="#">LOG OUT</a></li>
					
			</ul>
		</div>
	</div>
</nav>

<script>
	const uid= sessionStorage.getItem("uid");
	if(uid){
		$("#login").hide();
		$("#logout").show();
		$("#cart-item").show();
		$("#order-item").show();
		$("#uid a").html(uid + " 님 환영합니다");
	}else{
		$("#login").show();
		$("#logout").hide();
		$("#cart-item").hide();
		$("#order-item").hide();
		$("#uid").hide()
	}
	
	$("#logout").on("click","a",function(e){
		e.preventDefault();
		if(confirm("로그아웃 하시겠습니까?")){
			sessionStorage.clear();
			location.href="/user/logout";
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
	
	if(uid=="admin"){
		$("#list-item").show();
		$("#search-item").show();
		$("#admin_order-item").show();
		$("#cart-item").hide();
	}else{
		$("#list-item").hide();
		$("#search-item").hide();
		$("#admin_order-item").hide();
	}
</script>