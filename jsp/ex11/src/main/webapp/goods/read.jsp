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
				<button class="btn btn-danger"><span class="bi bi-suit-heart-fill" id="heart" gid="${goods.gid}"> 좋아요 <span id="fcnt"></span></span></button>
				<button class="btn btn-primary"><i class="bi bi-bag-fill"> 바로구매</i></button>
				<button class="btn btn-success" id="cart"><i class="bi bi-cart4"> 장바구니</i></button>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="alert alert-dark text-center">비슷한 상품 추천 받기!</div>
		<div class="row" id="div_slist"></div>
	</div>
	
</div>
	
<script id="temp_slist" type="x=handlebars-template">
	{{#each .}}
		<div class="col-2 col-md-4 col-lg-2 mb-5">
			<div class="mb-2">
				<img gid="{{gid}}" src="{{image}}" width="95%" style="cursor:pointer;">
			</div>
			<div>{{brand}}</div>
			<div class="ellipsis">{{{title}}}</div>
			<div class="mb-2 text-center">
				{{fmtPrice price}}
				<span class="bi {{heart ucnt}} sheart" gid="{{gid}}">
					<span style="font-size:12px;color:red;">{{fcnt}}</span>
				</span>
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("fmtPrice",function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
	})
	
	Handlebars.registerHelper("heart",function(value){
		if(value==0) return "bi-suit-heart";
		else return "bi-suit-heart-fill";
	})

	getDataSlist();
	function getDataSlist(){
		const gid = "${goods.gid}";
		let size=6;
		let page=1;
		let word="위스키";
		console.log(gid+":"+uid);
		$.ajax({
			type:"get",
			url:"/goods/slist.json",
			dataType:"json",
			data:{word,size,page,uid,gid},
			success:function(data){
				const temp=Handlebars.compile($("#temp_slist").html());
				$("#div_slist").html(temp(data));
			}
		})
	}
</script>

<script>
	const gid = "${goods.gid}"; // request.setAttribute "gid" 의 값 불러올떄 
	const ucnt= "${goods.ucnt}"; //  request.getParameters 로 넘어온 값 불러올때는 $(param.)
	const fcnt="${goods.fcnt}";
	
	$("#fcnt").html(fcnt);
	
	if(ucnt==0){
		$("#heart").removeClass("bi-suit-heart-fill");
		$("#heart").addClass("bi-suit-heart");
	}else{
		$("#heart").removeClass("bi-suit-heart");
		$("#heart").addClass("bi-suit-heart-fill");
	}
	//채워진 하트를 클릭한 경우
	$(".bi-suit-heart-fill").on("click",function(){
		const gid=$(this).attr("gid");
		//alert(uid+":"+gid);
		$.ajax({
			type:"post",
			url:"/favorite/delete",
			data:{uid,gid},
			success:function(){
				alert("좋아요! 취소");
				location.reload(true);
			}
		})
	})
	
	//빈 하트를 클릭한 경우
	$(".bi-suit-heart").on("click",function(){
		const gid=$(this).attr("gid");
		if(uid){
			const gid=$(this).attr("gid");
			//alert(uid+":"+gid);
			$.ajax({
				type:"post",
				url:"/favorite/insert",
				data:{uid,gid},
				success:function(){
					alert("좋아요! 등록");
					location.reload(true);
				}
			})
		}else{
			sessionStorage.setItem("target","/goods/read?gid="+ gid);
			location.href="/user/login";
		}
	})
	
	
	$("#cart").on("click",function(){
		if(uid){
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{gid,uid},
				success:function(data){
					let message="";
					if(data=="true"){
						message="장바구니에 넣었습니다";
					}else{
						message="장바구니에 있는 상품입니다!";
					}
					if(confirm(message+ "\n 장바구니로 이동하시겠습니까?")){
						location.href="/cart/list";
					}else{
						location.href="/";
					}
				}
			})
		}else{
			sessionStorage.setItem("target","/goods/read?gid="+gid);
			location.href="/user/login";
		}
	})
</script>