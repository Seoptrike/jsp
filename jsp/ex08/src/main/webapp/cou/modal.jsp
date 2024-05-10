<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	#modalCou{
		top:10%;
	}
</style>    
    
<div class="modal fade" id="modalCou" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 justify-content-center" id="staticBackdropLabel">교수 검색</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       	<div id="div_pro"></div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-success">선택완료</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
      </div>
    </div>
  </div>
</div>

<script id="temp_pro" type="x-handlebars-tempelate">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>교수번호</td>
			<td>교수이름</td>
			<td>교수학과</td>
		</tr>
		{{#each .}}
		<tr class="text-center trtr" pcode="{{pcode}}" pname="{{pname}}" style="cursor:pointer">
			<td>{{pcode}}</td>
			<td>{{pname}}</td>
			<td>{{dept}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let page=1;
	let size=100;
	let key="dept";
	let word=$(frm.dept).val();
	
	$(frm.dept).on("change", function(){
		word=$(frm.dept).val();
		getData();
	});
	
	getData();
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
	
	//각행의 tr를 클릭한경우
	$("#div_pro").on("click", ".trtr", function(){
		const pcode=$(this).attr("pcode");
		const pname=$(this).attr("pname");
		//alert(pcode + pname);
		$(frm.instructor).val(pcode);
		$(frm.pname).val(pname);
		$("#modalCou").modal("hide");
	});
</script>