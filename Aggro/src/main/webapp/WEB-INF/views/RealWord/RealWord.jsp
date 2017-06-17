<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<script>
 $(function() {
	alert('${dataList}');
	$('#invenChat').on('click',function(){
		var popUrl = "";	//팝업창에 출력될 페이지 URL
		var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open("" ,"popup_window",popOption);
		$('#invenfrm').submit();
	});
}); 
</script>
<div class="row">
  <div class="col-sm-6 col-md-3">
    <div class="thumbnail">
      <img src="${img}/site/daum.png">
      <div class="caption">
        <h3>실시간 검색 목록</h3>
 		 <table class="table">
			<tr>
				<th>순 위</th>
				<th>검색어</th>
			</tr>
			<c:forEach items="${dataList.daumDataList}" var="daumData">
		  	  <tr>
					<td>${daumData.rank }</td>
					<td>${daumData.word }</td>
				</tr>
			</c:forEach>
		</table>
      </div>
    </div>
  </div>
  
    <div class="col-sm-6 col-md-3">
    <div class="thumbnail">
	  <img src="${img}/site/naver.jpg">
      <div class="caption">
        <h3>실시간 검색 목록</h3>
	        <table class="table">
				<tr>
					<th>순 위</th>
					<th>검색어</th>
				</tr>
				<c:forEach items="${dataList.naverDataList}" var="naverData">
					<tr>
						<td>${naverData.rank }</td>
						<td>${naverData.word }</td>
					</tr>
				</c:forEach>
		  </table>
      </div>
    </div>
  </div>
  
  <div class="col-sm-6 col-md-3">
    <div class="thumbnail">
      <img src="${img}/site/inven.jpg">
      <div class="caption">
        <h3>실시간 검색 목록</h3>
		<table class="table">
			<tr>
				<th>순 위</th>
				<th>검색어</th>
			</tr>
			<c:forEach items="${dataList.invenDataList}" var="invenData">
				<tr>
					<td>${invenData.rank }</td>
					<td>${invenData.word }</td>
				</tr>
			</c:forEach>
				<tr align="center">
					<td colspan="2">
					<form name="invenfrm" id="invenfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
					<button type="button" class="btn btn-default btn-lg" id="invenChat">
	  					<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 채팅방 입장
	  					<span class="badge">${invenCount}</span>
					</button>
					</form>
					</td>
				</tr>
		</table>
      </div>
    </div>
  </div>
  
  <div class="col-sm-6 col-md-3">
    <div class="thumbnail">
      <img src="${img}/site/marumaru.png">
      <div class="caption">
        <h3>실시간 검색 목록</h3>
		<table class="table">
			<tr>
				<th>순 위</th>
				<th>검색어</th>
			</tr>
			<c:forEach items="${dataList.marumaruDataList}" var="marumaruData">
				<tr>
					<td>${marumaruData.rank }</td>
					<td>${marumaruData.word }</td>
				</tr>
			</c:forEach>
		</table>
      </div>
    </div>
  </div>
  
</div>




