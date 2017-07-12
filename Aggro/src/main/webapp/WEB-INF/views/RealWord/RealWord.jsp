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
			
			invenServer.onopen = function(event){
				onOpen(event)
			}
			invenServer.onmessage = function(event){
				onMessage(event)
			}
			invenServer.onerror = function(event) {
				onError(event);
			}
			
			function onOpen(event){
				$('#daumChat').on('click',function(){
					$('#daumText > div').remove();
						invenServer.send("daumChat | ${nickName}님이 접속");
						$("#daumText").append("<div>연결성공</div>");
				});
				$('#naverChat').on('click',function(){
					$('#naverText > div').remove();
					invenServer.send("naverChat | ${nickName}님이 접속");
					$("#naverText").append("<div>연결성공</div>");
				});
				$('#invenChat').on('click',function(){
					$('#invenText > div').remove();
					invenServer.send("invenChat | ${nickName}님이 접속");
					$("#invenText").append("<div>연결성공</div>");
				});
			}
		
			function onMessage(event){
				var message = event.data.split("|");
				var room = message[0].trim();
				var text = message[1];
				switch(room){
				case "daumChat":
					$('#daumText').append("<div class='w3-left-align w3-round-xlarge left'><p>" + text + "</p></div>");	
					$('#daumText').scrollTop($('#daumText')[0].scrollHeight);
					break;
				case "naverChat":
					$('#naverText').append("<div class='w3-left-align w3-round-xlarge left'><p>" + text + "</p></div>");	
					$('#naverText').scrollTop($('#naverText')[0].scrollHeight);
					break;
				case "invenChat":
					$('#invenText').append("<div class='w3-left-align w3-round-xlarge left'><p>" + text + "</p></div>");	
					$('#invenText').scrollTop($('#invenText')[0].scrollHeight);
					break;
				}
			};
			
			function onError(event){
				alert(event.data);
			}
	
 	$('#daumMessage').on('click',function(){
 		if($('#dauminputMessage').val() != ""){
	 		invenServer.send("daumChat | ${nickName} : " + $('#dauminputMessage').val());
			$('#daumText').append("<div class='w3-right-align w3-round-xlarge right'><p>나 : "+ $('#dauminputMessage').val() +"</p></div>");
			$('#dauminputMessage').val("");
	        $('#dauminputMessage').focus();
	        $('#daumText').scrollTop($('#daumText')[0].scrollHeight);
 		}
 	});
 	
 	$('#naverMessage').on('click',function(){
 		if($('#naverinputMessage').val() != ""){
	 		invenServer.send("naverChat | ${nickName} : " + $('#naverinputMessage').val());
			$('#naverText').append("<div class='w3-right-align w3-round-xlarge right'><p>나 : "+ $('#naverinputMessage').val() +"</p></div>");
			$('#naverinputMessage').val("");
	        $('#naverinputMessage').focus();
	        $('#naverText').scrollTop($('#naverText')[0].scrollHeight);
 		}
 	});
 	
 	$('#invenMessage').on('click',function(){
 		if($('#inveninputMessage').val() != ""){
	 		invenServer.send("invenChat | ${nickName} : " + $('#inveninputMessage').val());
			$('#invenText').append("<div class='w3-right-align w3-round-xlarge right'><p>나 : "+ $('#inveninputMessage').val() +"</p></div>");
			$('#inveninputMessage').val("");
	        $('#inveninputMessage').focus();
	        $('#invenText').scrollTop($('#invenText')[0].scrollHeight);
 		}
 	});
 	
 	$("#dauminputMessage").keydown(function (key) {
        if (key.keyCode == 13) {
           $("#daumMessage").click();
        }
     });
 	
 	$("#naverinputMessage").keydown(function (key) {
        if (key.keyCode == 13) {
           $("#naverMessage").click();
        }
     });
 
 	$("#inveninputMessage").keydown(function (key) {
        if (key.keyCode == 13) {
           $("#invenMessage").click();
        }
     });
 	
	$('#daumClose').on('click', function(){
		invenServer.send("daumChat | ${nickName}님 접속해제");
		$('#daumText > div').remove();
	});
 	
	$('#naverClose').on('click', function(){
		invenServer.send("naverChat | ${nickName}님 접속해제");
		$('#naverText > div').remove();
	});
	
	$('#invenClose').on('click', function(){
		invenServer.send("invenChat | ${nickName}님 접속해제");
		$('#invenText > div').remove();
	});
	
    $(window).bind("beforeunload",function(){
    	invenServer.send("daumChat | ${nickName}님 접속해제");
    	invenServer.send("naverChat | ${nickName}님 접속해제");
    	invenServer.send("invenChat | ${nickName}님 접속해제");
    	invenServer.close();
    });
	
	
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
			 <tr align="center">
					<td colspan="2">
					<form name="daumfrm" id="daumfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
					<button type="button" class="btn btn-info btn-lg" id="daumChat" data-toggle="modal" data-target="#daumModal" data-backdrop="static" data-keyboard="false">
	  					<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 채팅방 입장
	  					<span class="badge" id="daumCount">0</span>
					</button>
					</form>
					</td>
				</tr>
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
				 <tr align="center">
					<td colspan="2">
					<form name="naverfrm" id="naverfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
					<button type="button" class="btn btn-info btn-lg" id="naverChat" data-toggle="modal" data-target="#naverModal" data-backdrop="static" data-keyboard="false">
	  					<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 채팅방 입장
	  					<span class="badge" id="naverCount">0</span>
					</button>
					</form>
					</td>
				</tr> 
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
				<tr align="center">
					<td colspan="2">
					<form name="invenfrm" id="invenfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
					<button type="button" class="btn btn-info btn-lg" id="invenChat" data-toggle="modal" data-target="#invenModal" data-backdrop="static" data-keyboard="false">
	  					<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 채팅방 입장
	  					<span class="badge" id="invenCount">0</span>
					</button>
					</form>
					</td>
				</tr>
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

  <!-- daum Modal -->
  <div class="modal fade" id="daumModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Daum 채팅방</h4>
        </div>
      	<div class="modal-body">
			<div class="w3-container w3-border w3-large text" id="daumText">
			</div>
			<div class="form-group">
        		<input id="dauminputMessage" type="text" class="form-control"/>
			</div>
      	</div>
      	<div class="modal-footer">
          <button type="submit" class="btn btn-default" id="daumMessage">send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" id="daumClose">Close</button>
      	</div>
      </div>
    </div>
  </div>
  
  
  <!-- ////////////////////////////////////////////////////////////////////////////////// -->

   <!-- naver Modal -->
  <div class="modal fade" id="naverModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Naver 채팅방</h4>
        </div>
        <div class="modal-body">
			<div class="w3-container w3-border w3-large text" id="naverText">
			</div>
			<div class="form-group">
		        <input id="naverinputMessage" type="text" class="form-control"/>
			</div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-default" id="naverMessage">send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" id="naverClose">Close</button>
         </div>
      </div>
    </div>
  </div>
  
  
    <!-- ////////////////////////////////////////////////////////////////////////////////// -->

   <!-- inven Modal -->
  <div class="modal fade" id="invenModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Inven 채팅방</h4>
        </div>
        <div class="modal-body">
			<div class="w3-container w3-border w3-large text" id="invenText">
			</div>
			<div class="form-group">
		        <input id="inveninputMessage" type="text" class="form-control"/>
			</div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-default" id="invenMessage">send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" id="invenClose">Close</button>
         </div>
      </div>
    </div>
  </div>