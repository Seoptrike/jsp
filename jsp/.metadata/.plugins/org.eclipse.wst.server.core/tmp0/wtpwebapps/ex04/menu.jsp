<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-sm bg-success navbar-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="#">Navbar</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/">회사소개</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/user/list">유저목록</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/bbs/list">자유게시판</a></li>
			</ul>
			<ul class="navbar-nav mb-2 mb-lg-0 text-end">
				<li class="nav-item" id="login"><a class="nav-link active"
					aria-current="page" href="/user/login">LOG IN</a></li>
					
				<li class="nav-item fs-8" id="uid">
				<a class="nav-link active" aria-current="page" href="/user/mypage"></a>
				</li>
					
				<li class="nav-item" id="logout"><a class="nav-link active"
					aria-current="page" href="/user/logout">LOG OUT</a></li>
					
			</ul>
		</div>
	</div>
</nav>

<script>
	const uname="${user.uname}";
	const uid = "${user.uid}";
	if(uid){
		$("#login").hide();
		$("#logout").show();
		$("#uid a").html( uname +" 님 환영합니다.");
	}else{
		$("#login").show();
		$("#logout").hide();
	}
	
	$("logout").on("click","a",function(e){
		e.preventDefault();
		if(confirm("로그아웃 하실래요?")){
			location.href="/user/logout";
		}
	})
</script>