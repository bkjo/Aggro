<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script type="text/javascript">
    $(document).ready(function(){
    	$('#inputMessage').focus();
    	
    	$("#inputMessage").keydown(function (key) {
            if (key.keyCode == 13) {
               $("#sendMessage").click();
            }
         });
    	
    });
    
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
    	$('#messageWindow').val($('#messageWindow').val() + event.data + "\n");
    }
    function onOpen(event) {
    	$("#messageWindow").val("연결성공\n"); 
        webSocket.send("${nickName}님이 접속");
    }
    
    function onError(event) {
      alert(event.data);
    }
    function send() {
    	$('#messageWindow').val($('#messageWindow').val() + '${nickName} : ' + $('#inputMessage').val() + "\n");
        webSocket.send("${nickName} : " + $('#inputMessage').val());
        $('#inputMessage').val("");
        $('#inputMessage').focus();
    }
    
    function disconnect(){
    	webSocket.send("${nickName} 접속해제");
        webSocket.close();
		window.close();        
    }
    
    $(window).bind("beforeunload",function(){
    	webSocket.send("${nickName}님 접속해제");
    	webSocket.close();
    });
   
</script>

<!--     <fieldset>
        <textarea id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
        <br/>
        <input id="inputMessage" type="text"/>
        <input type="submit" value="send" onclick="send()" />
        <input onclick="disconnect()" value="Disconnect" type="button">

    </fieldset>
 -->    
  <div class="form-group">
     <div class="col-sm-12">
        <textarea class="form-control" id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
     </div>
      <div class="col-sm-12">
        <input id="inputMessage" type="text" class="form-control"/>
        <input type="submit" value="send" onclick="send()" id="sendMessage" class="form-control" />
        <input onclick="disconnect()" value="Disconnect" type="button" class="form-control">
      </div>
    </div> 




