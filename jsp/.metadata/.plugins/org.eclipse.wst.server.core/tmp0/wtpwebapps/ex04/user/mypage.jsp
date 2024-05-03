<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	#imgPhoto{
		border-radius:50%;
		border : 1px solid black;
	}
</style>

<div class="row justify-content-center">
	<div class="col-8">
		<h1>마이페이지</h1>
		<div class="col-lg-12 mb-4 mb-sm-5">
           <div class="card card-style1 border-0">
               <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
                   <div class="row align-items-center">
                       <div class="col-lg-6 mb-4 mb-lg-0 text-end">
                           <c:if test="${user.photo!=null}">
							<img id="imgPhoto" src="${user.photo}" width="200">
							</c:if>
							<c:if test="${user.photo==null}">
								<img id="imgPhoto" src="http://via.placeholder.com/200x200" width="200">
							</c:if>
                       </div>
                       <div class="col-lg-6 px-xl-10">
                           <ul class="list-unstyled mb-1-9">
                           		<li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">이름:</span>${user.uname} ( ${user.uid} ) </li>
                               <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">주소:</span>${user.address1} <br> ${user.address2}</li>
                               <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">전화:</span>${user.phone}</li>
                               <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">가입일:</span><fmt:formatDate value= "${user.jdate}" pattern= "yyyy년MM월dd일 HH:mm:ss"/></li>
                               <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">수정일:</span><fmt:formatDate value= "${user.udate}" pattern= "yyyy년MM월dd일 HH:mm:ss"/></li>
                           </ul>
                       </div>
                       <div class="text-center my-3">
							<span><button id=btnPass class= "btn btn-danger">비밀번호 변경</button></span>
							<span><button id=btnInfo class= "btn btn-warning px-4">정보 수정</button></span>
						</div>
                   </div>
               </div>
           </div>
       </div>
	</div>
	<jsp:include page="modal_info.jsp"/>
	<jsp:include page="modal_pass.jsp"/>
	<jsp:include page="modal_photo.jsp"/>
</div>

<script>
	$("#btnInfo").on("click",function(){
		$("#modalInfo").modal("show");
	});
	$("#btnPass").on("click",function(){
		$("#modalPass").modal("show");
	});
	$("#imgPhoto").on("click",function(){
		$("#modalPhoto").modal("show");
	});
</script>