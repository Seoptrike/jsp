<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<Style>
	#page-link { color: black ; }
</Style>    
    
<div>
	<h1>자유게시판</h1> 
	
		
<div class="row mt-2">
    <div class="col-6 col-md-4">
        <form name="frm">
            <div class="input-group">
                <select class="mx-1" name="key" id="select">
                    <option value="title">제목</option>
                    <option value="contents">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <input class="form-control" id="query" name="query" placeholder="검색어를 입력하세요"><button class="mx-1 btn btn-success">검색</button>
            </div>
        </form>
    </div>
    <div class="col text-end mb-3" id="div_write" style="display: none">
        <a href="/bbs/insert"><button class="btn btn-success">글쓰기</button></a>
    </div>
</div>
	<div id="div_bbs"></div>
	
	
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>

<script id= "temp_bbs" type="x-handlebars=template">
	<table class="table table-striped table-bordered mt-3">
		<tr class="table-dark" >
			<td>ID</td>
			<td>Title</td>
			<td>Writer</td>
			<td>Date</td>
		</tr>
		{{#each .}}
			<tr>
				<td>{{bid}}</td>
				<td><a href="/bbs/read?bid={{bid}}">{{title}}</a</td>
				<td>{{writer}}({{uname}})</td>
				<td>{{bdate}}</td>
			</tr>
		{{/each}}
</script>

<script>
	if(uid){
		$("#div_write").show();
	}else{
		$("#div_write").hide();
	}
	let page=1;
	const size=10;
	
	let query = $(frm.query).val();
	let key = $(frm.key).val();
	
	getData();

	function getData(){
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			dataType:"json",
			data:{ query, page, size },
			success:function(data){
				const temp=Handlebars.compile($("#temp_bbs").html());
				$("#div_bbs").html(temp(data));
				
			}
		});
	}
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/bbs/total",
			data:{query},
			success:function(data){
				if(data ==0) {
					alert("검색내용이 없습니다.");
					$(frm.query).val("");
				}else{
					const totalPage=Math.ceil(data/size);
					$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					$("#total").html("검색수:" + data + "건")
				}
			}
		});
	}
	
	$("#next").on("click", function () {
	        page++;
	        getData();
	    })
	    $("#prev").on("click", function () {
	        page--;
	        getData();
	    })

	
	$(frm).on("submit", function(e){
        e.preventDefault();
        query = $(frm.query).val();
        key = $(frm.key).val();
        getTotal();
        page=1;
	});
	
	//페이지네이션 출력
	   $('#pagination').twbsPagination({
      totalPages:100, 
      visiblePages: 10, 
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

