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
	<h1>교수관리</h1>
	<div class="row mt-4 mb-3">
		<form name="frm" class="col-10 col-md-6">
			<div class="input-group">
				<select name="key" class="form-select me-3">
					<option value="pcode">번호</option>
					<option value="pname" selected>이름</option>
					<option value="dept">학과</option>
				</select>
				<input placeholder="검색어" class="form-control" name="word">
				<button class="btn btn-success">검색</button>
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
	<div id="div_pro"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>
	

<script id="temp_pro" type="x-handlebars-tempelate">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>교수번호</td>
			<td>교수이름</td>
			<td>교수학과</td>
			<td>교수직함</td>
			<td>교수급여</td>
			<td>임용일자</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{pcode}}</td>
			<td><a href="/pro/read?pcode={{pcode}}">{{pname}}</a></td>
			<td>{{dept}}</td>
			<td>{{title}}</td>
			<td>{{salary}}</td>
			<td>{{hiredate}}</td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	let page=1;
	let size=$("#size").val();
	let key=$(frm.key).val();
	let word=$(frm.word).val();
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		key=$(frm.key).val();
		word=$(frm.word).val();
		size=$("#size").val();
		page=1;
		//getData();
		getTotal();
	});
	
	$("#size").on("change", function(){
		size=$("#size").val();
		page=1;
		getTotal();
	});
	
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_pro").html());
				$("#div_pro").html(temp(data));
			}
		});
	}
	

	function getTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{key,word},
			success:function(data){
				if(data==0){
					alert("검색 내용이 없습니다!");
					$(frm.word).val("");
					return;
				}
				
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(data<size){
					$("#pagination").hide();
				}else{
					$("#pagination").show();
				}
			}
		})
	};
	
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