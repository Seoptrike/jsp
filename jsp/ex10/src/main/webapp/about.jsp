<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<div class="my-5">
	<div class="row mb-3">
		<div class="col-4">
			<form name="frm">
			<div class="input-group">
				<input placeholder="검색어" class="form-control" name="word">
				<button class="btn btn-success">검색</button>
			</div>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-4">
			<img src="/image/ad03.png" width="100%">
		</div>
		<div class="col-8">
			<div class="text-center">
				<h4>지금 떠오르는 위스키</h4>
			</div>
			
			<div id="div_shop" class="row"></div>
		</div>
	</div>
	<div id="div_bed" class="row"></div>
	<div id="pagination" class="pagination justify-content-center"></div>
</div>
<script id="temp_shop" type="x=handlebars-template">
	{{#each .}}
		<div class="col-4">
			<div class="mb-2">
				<a href="/goods/read?gid={{gid}}"><img src="{{image}}" width="90%"></a>
			</div>
			<div>{{brand}}</div>
			<div class="ellipsis">{{{title}}}</div>
			<div class="text-center mb-2">
				{{fmtPrice price}}
			</div>
		</div>
	{{/each}}
</script>
<script id="temp_bed" type="x=handlebars-template">
	{{#each .}}
		<div class="col-2 col-md-4 col-lg-2 mb-5">
			<div class="mb-2">
				<a href="/goods/read?gid={{gid}}"><img src="{{image}}" width="90%"></a>
			</div>
			<div>{{brand}}</div>
			<div class="ellipsis">{{{title}}}</div>
			<div class="text-center mb-2">
				{{fmtPrice price}}
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("fmtPrice",function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
	})
</script>
<script>
	let size=10;
	let page= 1;
	let word="";
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		word=$(frm.word).val();
		page=1;
		getTotal();
	})
	
	getTotal();
	function getData(){
		let size=6;
		let page=1;
		let word="위스키";
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			dataType:"json",
			data:{word,size,page},
			success:function(data){
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		})
	}
	getDataBed();
	function getDataBed(){
		let size=12;
		let page= 1;
		let word="";
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			dataType:"json",
			data:{word,size,page},
			success:function(data){
				const temp=Handlebars.compile($("#temp_bed").html());
				$("#div_bed").html(temp(data));
			}
		})
	}
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{word},
			success:function(data){
				const total= parseInt(data);
				if(total==0){
					alert("검색 내용이 없습니다!");
					$(frm.word).val("");
					return;
				}
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total>size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
				$("#total").html("검색수: " + total);
			}
		})
	}
	
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
</script>