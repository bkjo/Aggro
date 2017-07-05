<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<style>
.text{
   overflow-x:hidden;
   overflow-y:auto;
   width:100%; 
   height:250px;
   
}
.left{
   width: 80%;
   background-color: #ffe6cb;
   
}
.right{
   width: 80%;
   margin-left: 20%;
   background-color: yellow;
	margin: 3px,3px,3px,3px;
}
p {
    padding-top: 5px;
    padding-right: 5px;
    padding-bottom: 5px;
    padding-left: 5px;
}
 
</style>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	var invenServer = new WebSocket("ws://192.168.0.7:8080/main/invensocket");
	
	
		invenServer.onopen = function(evt){
			$("#invenModal .text").append("<div>연결성공</div>");
			invenServer.send("${nickName}님이 접속");
		};
		invenServer.onmessage = function(evt){
			$('#invenModal .text').append("<div class='w3-left-align w3-round-xlarge left'><p>" + evt.data + "</p></div>");
		};
		invenServer.onclose = function(evt){
			invenServer.onInvenClose(evt);
		};
		invenServer.onerror = function(evt) {
			alert(evt.data);
		};
	
	
 	$('#invenMessage').on('click',function(){
 		if($('#invenModal #inputMessage').val() != ""){
	 		invenServer.send("${nickName} : " + $('#invenModal #inputMessage').val());
			$('#invenModal .text').append("<div class='w3-right-align w3-round-xlarge right'><p>${nickName} : "+ $('#invenModal #inputMessage').val() +"</p></div>");
	        $('#invenModal #inputMessage').val("");
	        $('#invenModal #inputMessage').focus();
 		}
        
 	}); 
	
	$("#invenchat").on('click',function(){
		$('#invenModal .text > div').remove();
	});
	
 	$("#invenModal #inputMessage").keydown(function (key) {
        if (key.keyCode == 13) {
           $("#invenMessage").click();
        }
     });
 	
	
	$('#invenClose').on('click', function(){
		invenServer.send("${nickName}님 접속해제");
		$('#invenModal .text > div').remove();
	});
 	
    $(window).bind("beforeunload",function(){
    	invenServer.send("${nickName}님 접속해제");
    	invenServer.close();
    });
	
	/////////////////////////////////////////////////////// naver  ///////////
	
	/* var naverServer = new WebSocket("ws://192.168.0.7:8080/main/naversocket");
	
	
	// naver server
	naverServer.onopen = function(evt){
		$("#naverModal .text").append("<div>연결성공</div>");
		naverServer.send("${nickName}님이 접속");
	};
	naverServer.onmessage = function(evt){
		$('naverModal .text').append("<div class='w3-left-align w3-round-xlarge left'><p>" + evt.data + "</p></div>");
	};
	naverServer.onclose = function(evt){
		naverServer.onInvenClose(evt);
	};
	naverServer.onerror = function(evt) {
		alert(evt.data);
	};
	
 	$('#naverMessage').on('click',function(){
 		if($('#naverModal #inputMessage').val() != ""){
 			naverServer.send("${nickName} : " + $('#naverModal #inputMessage').val());
			$('#naverModal .text').append("<div class='w3-right-align w3-round-xlarge right'><p>${nickName} : "+ $('#naverModal #inputMessage').val() +"</p></div>");
	        $('#naverModal #inputMessage').val("");
	        $('#naverModal #inputMessage').focus();
 		}
        
 	}); 
	
 	$("#naverModal #inputMessage").keydown(function (key) {
        if (key.keyCode == 13) {
           $("#naverMessage").click();
        }
     });
 	
	
	$('#naverClose').on('click', function(){
		naverServer.send("${nickName}님 접속해제");
		$('#naverModal .text > div').remove();		
	}); */
	
});

</script>
<center>
<form name="invenfrm" id="invenfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
					<button type="button" class="btn btn-info btn-lg" id="invenchat" data-toggle="modal" data-target="#invenModal" data-backdrop="static" data-keyboard="false">
	  					<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 채팅방 입장
	  					<span class="badge">${invenCount}</span>
					</button>
					</form>

</center>


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
				<%-- <tr align="center">
					<td colspan="2">
					<form name="invenfrm" id="invenfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
					<button type="button" class="btn btn-info btn-lg" id="naverchat" data-toggle="modal" data-target="#naverModal" data-backdrop="static" data-keyboard="false">
	  					<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 채팅방 입장
	  					<span class="badge">${naverCount}</span>
					</button>
					</form>
					</td>
				</tr> --%>
		  </table>
      </div>
    </div>
  </div>
  
  <div class="col-sm-6 col-md-4">
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
				<%-- <tr align="center">
					<td colspan="2">
					<form name="invenfrm" id="invenfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
					<button type="button" class="btn btn-info btn-lg" id="invenchat" data-toggle="modal" data-target="#invenModal" data-backdrop="static" data-keyboard="false">
	  					<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 채팅방 입장
	  					<span class="badge">${invenCount}</span>
					</button>
					</form>
					</td>
				</tr> --%>
		</table>
      </div>
    </div>
  </div>
  
  <div class="col-sm-6 col-md-4">
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
  
  
  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
      <img src="${img}/site/menupan.gif">
      <div class="caption">
        <h3>실시간 검색 목록</h3>
		<table class="table">
			<tr>
				<th>순 위</th>
				<th>검색어</th>
			</tr>
			<c:forEach items="${dataList.menupanDataList}" var="menupanData">
				<tr>
					<td>${menupanData.rank }</td>
					<td>${menupanData.word }</td>
				</tr>
			</c:forEach>
		</table>
      </div>
    </div>
  </div>
  
  
  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
      <img src="${img}/site/gomtv.jpg">
      <div class="caption">
        <h3>실시간 검색 목록</h3>
		<table class="table">
			<tr>
				<th>순 위</th>
				<th>검색어</th>
			</tr>
			<c:forEach items="${dataList.gomtvDataList}" var="gomtvData">
				<tr>
					<td>${gomtvData.rank }</td>
					<td>${gomtvData.word }</td>
				</tr>
			</c:forEach>
		</table>
      </div>
    </div>
  </div>
  
  
</div>

  <!-- naver Modal -->
 <!--   <div class="modal fade" id="naverModal" role="dialog">
    <div class="modal-dialog">
    
      Modal content
      <div class="modal-content">
      
        <div class="modal-header">
          <h4 class="modal-title">네이버 채팅방</h4>
        </div>
        <div class="modal-body">
			

<div class="w3-container w3-border w3-large myScrollspy text">

</div>

<div class="form-group">
        <input id="inputMessage" type="text" class="form-control"/>
</div>


        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-default" onclick="send()" id="naverMessage">send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="disconnect()">Close</button>
         </div>
      </div>
      
    </div>
  </div> -->



  <!-- inven Modal -->
  <div class="modal fade" id="invenModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
      
        <div class="modal-header">
          <h4 class="modal-title">채팅방</h4>
        </div>
        <div class="modal-body">
			

<div class="w3-container w3-border w3-large myScrollspy text">

</div>

<div class="form-group">
        <input id="inputMessage" type="text" class="form-control"/>
</div>


        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-default" id="invenMessage">send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" id="invenClose">Close</button>
         </div>
      </div>
      
    </div>
  </div>
