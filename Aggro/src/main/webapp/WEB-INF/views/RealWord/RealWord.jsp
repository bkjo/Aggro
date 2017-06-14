<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<script>
$(function() {
	alert('${dataList}');
});
</script>
<div class="row">
  <div class="col-sm-6 col-md-4">
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
  
    <div class="col-sm-6 col-md-4">
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
  
</div>
