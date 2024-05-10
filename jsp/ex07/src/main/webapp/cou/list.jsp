<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 #size{
 	width:100;
 	float:right;
 }
  
 .page-link{
	color:black; 
 }
  
 a{text-decoration-line: none;}
 </style>       
<div> 
	<h1 class="my-3">강좌관리</h1> 
	<div class="row mt-4 mb-3">
		<form name="frm" class="col-10 col-md-6">
			<div class="input-group">
				<select name="key" class="form-select me-3">
					<option value="lcode"> 강좌번호</option>
					<option value="lname" selected>강좌이름</option>
					<option value="pname">담당교수</option>
					<option value="room">강의실</option>
				</select>
				<input placeholder="검색어" class="form-control" name="word">
				<button class="btn btn-success">검색</button>
				<span id="total" class="mt-2 ms-3"></span>
			</div>
		</form>
		<div class="col-4"></div>
		<div class="col-2" >
			<select class="form-select text-end" id="size">
				<option value="2">2개씩 보기</option>
				<option value="3">3개씩 보기</option>
				<option value="4">4개씩 보기</option>
				<option value="5" selected>5개씩 보기</option>
			</select>
		</div>
	</div>
	<div id="div_cou"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>
<script id="temp_cou" type="x-handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>강좌번호</td>
			<td>강좌이름</td>
			<td>강의시간</td>
			<td>강의실</td>
			<td>신청인원</td>
			<td>담당교수</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td>{{hours}} 시간</td>
			<td>{{room}} 호</td>
			<td>{{persons}}명/{{capacity}}명</td>
			<td>{{pname}}({{instructor}})</td>
		</tr>		
		{{/each}}
	</table>
</script>
<script>
	let page=1;
	let size=5;
	let key="lname";
	let word="";
	
	//검색버튼을 눌렀을 경우
	$(frm).on("submit",function(e){
		e.preventDefault();
		page=1;
		key=$(frm.key).val();
		word=$(frm.word).val();
		size=$("#size").val();
		getData();
	})
	
	$("#size").on("change", function(){
		size=$("#size").val();
		page=1;
		getTotal();
	});
	
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			dataType:"json",
			data:{page,size,key,word},
			success:function(data){
				const temp=Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		})
	}

	function getTotal(){
		$.ajax({
			type:"get",
			url:"/cou/total",
			data:{key,word},
			success:function(data){
				let total= parseInt(data);
				$("#total").html("검색수:<b>"+total+"</b>")
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