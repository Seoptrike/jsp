<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
	#fphoto{
		border-radius:50%;
		border : 1px solid black;
	}
</style>   
    
<div>
	<h1> 사용자 목록 </h1>
	
	<div class = "row my-3 justify-content-end">
		<div class="col-8 col-md-4 col-lg-4">
			<form name="frm">
				<div class="input-group">
					<select class="mx-1" name="key" id="select">
                    	<option value="uname">이름</option>
                    	<option value="uid">아이디</option>
               		</select>
					<input class="form=control" name="query" value="" placeholder="검색어를 입력하세요.">
					<button class="btn btn-success">검색</button>
				</div>
			</form>
		</div>
	</div>
	<div id="div_user"></div>
	
	<div class="text-center my-3">
    <button class="btn btn-danger" id="prev">이전</button>
    <span class="mx-3" id="page">1</span>
    <button class="btn btn-primary" id="next">다음</button>
	</div>
	
	<script id="temp_user" type="x-handlebars-template">
		{{#each .}}
			<div class="card mb-2 mx-5">
			<div class="row card-body align-items-center">
				<div class="col-3 col-md-2">
					<img id="fphoto" src="{{check photo}}" width=150 height=150/>
				</div>
				<div class="col">
					<div>{{uname}} ({{uid}})</div>
					<div>전화:{{phone}}</div>
					<div>주소: {{address1}} {{address2}}</div>
				</div>
			</div>
		</div>

		{{/each}}
	</script>
</div>
<script>
	let page = 1;
	let query = $(frm.query).val();
	
	getData();
	function getData() {
	    const key=$(frm.key).val();
		$.ajax({
			type:"get",
			url:"/user/list.json",
			dataType:"json",
			data:{query},
			success:function(data){
				console.log(data);
				const temp = Handlebars.compile($("#temp_user").html());
				$("#div_user").html(temp(data));
				$('#total').html(data.total+"개가 검색되었습니다.");
                const last = Math.ceil(data.total /size);
                $("#page").html(`<b>${page}/${last}</b>`);
                if (page == 1) {
                    $("#prev").attr("disabled", true);
                } else {
                    $("#prev").attr("disabled", false);
                }
                if (page == last) {
                    $("#next").attr("disabled", true);
                } else {
                    $("#next").attr("disabled", false);
                }
			}
		})
	};
	
	 $(frm).on("submit",function(e){
	        e.preventDefault();
	        if(query==""){
	            alert("검색어를 입력하세요");
	        }else{
	            getData();
	        }
	    });
</script>
<script>
Handlebars.registerHelper("check",function(photo){
    if(photo){
        return photo;
    }else{
        return "http://via.placeholder.com/130x100";
    }
});
</script>