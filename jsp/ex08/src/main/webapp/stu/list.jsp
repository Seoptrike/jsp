<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 .page-link{
	color:black; 
 }
 </style>   
    
<div>
	<h1>학생관리</h1>
	<div class="row mt-4 mb-3">
		<form name="frm" class="col-10 col-md-6">
			<div class="input-group">
				<select name="key" class="form-select me-3">
					<option value="scode">학생번호</option>
					<option value="sname" selected>학생이름</option>
					<option value="dept">학생학과</option>
					<option value="pname">지도교수</option>
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
	<div id="div_stu"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>
<script id="temp_stu" type="x-handlebars-tempelate">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>학생번호</td>
			<td>학생이름</td>
			<td>학생학과</td>
			<td>학생학년</td>
			<td>생년월일</td>
			<td>지도교수</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{scode}}</td>
			<td><a href="/stu/read?scode={{scode}}">{{sname}}</a></td>
			<td>{{sdept}}</td>
			<td>{{year}}학년</td>
			<td>{{birthday}}</td>
			<td>{{pname}}({{advisor}})</td>
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
		getTotal();
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
			url:"/stu/list.json",
			dataType:"json",
			data:{page,size,key,word},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_stu").html());
				$("#div_stu").html(temp(data));
			}
		})
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/stu/total",
			data:{key,word},
			success:function(data){
				let total=parseInt(data);
				if(total==0){
					alert("검색내용이 없습니다.");
					return;
				}else{
					const totalPage= Math.ceil(data/size);
					$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					if(total >size){
						$("#pagination").show();
					}else{
						$("#pagination").hide();
					}
				}
			}
		})
	}
	   $('#pagination').twbsPagination({
		      totalPages:100, 
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