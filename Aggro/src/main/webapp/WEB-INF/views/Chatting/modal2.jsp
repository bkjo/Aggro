<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<style>
.text{
   overflow-x:hidden;
   overflow-y:auto;
   width:700px; 
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

    var webSocket = new WebSocket('ws://192.168.0.7:8080/main/invensocket');
    
    webSocket.onerror = function(event) {
      onError(event)
    };
    webSocket.onopen = function(event) {
      onOpen(event)
    };
    webSocket.onmessage = function(event) {
      onMessage(event)
    };
    webSocket.onclose = function(event) {
    	onClose(event)
    };
  //웹 소켓이 닫혔을 때 호출되는 이벤트
    webSocket.onclose = function(event){
    //	textarea.value += "Server Disconnect...\n";
    };

    
    function onMessage(event) {
    	$('.text').append("<div class='w3-left-align w3-round-xlarge left'><p>" + event.data + "</p></div>");
    }
    function onOpen(event) {
    	$(".text").append("<p>연결성공</p>"); 
        webSocket.send("${nickName}님이 접속");
    }
    
    function onError(event) {
      alert(event.data);
    }
    function send() {
    	$('.text').append("<div class='w3-right-align w3-round-xlarge right'><p>${nickName} : "+ $('#inputMessage').val() +"</p></div>");
        webSocket.send("${nickName} : " + $('#inputMessage').val());
        $('#inputMessage').val("");
        $('#inputMessage').focus();
    }
    
/*     function disconnect(){
    	webSocket.send("${nickName} 접속해제");
        webSocket.close();
		window.close();        
    }
     */
/*     $(window).bind("beforeunload",function(){
    	webSocket.send("${nickName}님 접속해제");
    	webSocket.close();
    }); */
</script>


<div class="w3-container w3-border w3-large myScrollspy text">
</div>

<div class="col-sm-12 form-group">
        <input id="inputMessage" type="text" class="form-control"/>
        <input type="submit" value="send" onclick="send()" id="sendMessage" class="form-control" />
        <input onclick="disconnect()" value="Disconnect" type="button" class="form-control">
</div>

