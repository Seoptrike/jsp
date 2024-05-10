<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="input-group mb-2">   
	<div id="div_cou"></div>
	<button class="btn btn-warning" id="insert">수강신청</button>
</div>     
	<div id="div_enroll"></div>
<script id="temp_enroll" type="x-handlebars-template">
	<table class="table table-striped table-bordered">
		<tr class="table-dark text-center">
			<td>강좌번호</td>
			<td>수강강좌</td>
			<td>강의시간</td>
			<td>강의실</td>
			<td>신청인원</td>
			<td>담당교수</td>
			<td>신청일</td>
			<td>취소</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{lcode}}</td>
			<td><a href="/cou/read?lcode={{lcode}}">{{lname}}</a></td>
			<td>{{hours}} 시간</td>
			<td>{{room}} 호</td>
			<td>{{persons}}명/{{capacity}}명</td>
			<td>{{pname}}({{pcode}})</td>
			<td>{{edate}}</td>
			<td><button class="btn btn-danger btn-sm delete" lname="{{lname}}" lcode="{{lcode}}">취소</button></td>
		</tr>		
		{{/each}}
	</table>
</script>

<script id="temp_cou" type="x-handlebars-template">
	<select class="form-select" id="lcode">
		{{#each .}}
		<option value="{{lcode}}">{{lname}}({{pname}})&nbsp;&nbsp;[{{persons}}/{{capacity}}]</option>
		{{/each}}
</script>
<script>
	let scode=${stu.scode};
	//삭제버튼을 클릭한경우
	$("#div_enroll").on("click",".delete",function(){
		const lcode=$(this).attr("lcode");
		const lname=$(this).attr("lname");
		if(confirm(lname + " 수강을 취소하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/enroll/delete",
				data:{scode,lcode},
				success:function(data){
					if(data=="true"){	
					alert("수강취소완료!");
					getData();
					getCou();
					}else{
						alert("수강취소실패!");
					}
				}
			});
		}
	});
	
	//수강신청 버튼을 누른 경우
	$("#insert").on("click",function(){
		const lcode=$("#div_cou #lcode").val();
		if(confirm("수강신청하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/enroll/insert",
				data:{scode,lcode},
				success:function(data){
					if(data=="true"){	
					alert("수강신청완료!");
					getData();
					getCou();
					}else{
						alert("이미 수강신청한 강좌입니다!");
					}
				}
			});
		}
	});

	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/enroll/list.json",
			data:{scode},
			dataType:"json",
			success:function(data){
				console.log("담당과목",data);
				const temp=Handlebars.compile($("#temp_enroll").html());
				$("#div_enroll").html(temp(data));
			}
		})
	}
	
	getCou();
	function getCou(){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			data:{page:1,size:100,key:'lcode',word:""},
			dataType:"json",
			success:function(data){
				console.log("담당과목",data);
				const temp=Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		})
	}
</script>
