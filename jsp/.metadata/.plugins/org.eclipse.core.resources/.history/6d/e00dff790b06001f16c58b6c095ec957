<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>도서검색</h1>
	
	<div class = "row mb-3 text-end">
		<div class="col-8 col-md-4 col-lg-4">
			<form name="frm">
				<div class="input-group">
					<input class="form=control" name="query" value="jsp" placeholder="검색어를 입력하세요.">
					<button class="btn btn-success">검색</button>
				</div>
			</form>
		</div>
	</div>
	
	<div class="row" id="div_book"></div>
	
	<div class="text-center my-3">
    <button class="btn btn-danger" id="prev">이전</button>
    <span class="mx-3" id="page">1</span>
    <button class="btn btn-primary" id="next">다음</button>
	</div>
</div>

<script id = "temp_book" type= "x-handlebars-template" >
	{{#each documents}}
		<div class="col-6 col-md-4 col-lg-2">
			<div class="card">
				<div class= "card-body">
					<img src="{{check thumbnail}}">
				</div>
				<div class="card-footer">
					<div class="ellipsis">{{title}}</div>
				</div>
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("check",function(thumbnail){
	    if(thumbnail){
	        return thumbnail;
	    }else{
	        return "http://via.placeholder.com/125x175";
	    }
	});
</script>
<script>
	let page=1;
	let query = $(frm.query).val();
	
	getData();
	function getData() {
		$.ajax({
			type : "get",
			data : { "query" : query , page : page , size : 12},
			url : "https://dapi.kakao.com/v3/search/book?target=title",
			headers : {"Authorization":"KakaoAK 6f34b847c930955a9c3b2742745e5a37"},
			dataType : "json",
			success : function(data) {
				console.log(data);
				const temp =Handlebars.compile($("#temp_book").html());
				$("#div_book").html(temp(data));
				
				const lastPage= Math.ceil(data.meta.pageable_count/12) ;
				
				 $("#page").html("<b>" + page + " / " + lastPage + "</b>");
				 
				if(page==1){
					$("#prev").attr("disabled",true)
				}else{
					$("#prev").attr("disabled",false)
				}if(data.meta.is_end){
					$("#next").attr("disabled",true)
				}else{
					$("#next").attr("diabled",false)
				}
			}
		})
	}
	
	//Handlebars.registerHelper("check",functiont(thumbnail){
	//	if(thumbnail){
	//		return thumbnail ;
	//	}else{
	//		return "http://via.placeholder.com/125x175";
	//	}
	// })
		
	
    $(frm).on("submit",function(e){
        query = $(frm.query).val();
        e.preventDefault();
        if(query==""){
            alert("검색어를 입력하세요");
        }else{
            page=1;
            getData();
        }
    })
	
    $("#next").on("click",function(){
    	page++;
    	getData();
    })
    $("#prev").on("click",function(){
    	page=page-1;
    	getData();
    })
    
</script>