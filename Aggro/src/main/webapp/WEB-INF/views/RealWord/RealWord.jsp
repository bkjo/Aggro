<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<style>
* {
  box-sizing: border-box;
}

body {
  background-color: #edeff2;
  font-family: "Calibri", "Roboto", sans-serif;
}

.chat_window {
  position: absolute;
  width: calc(100% - 20px);
  max-width: 800px;
  height: 500px;
  border-radius: 10px;
  background-color: #fff;
  left: 50%;
  top: 50%;
  transform: translateX(-50%) translateY(-50%);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
  background-color: #f8f8f8;
  overflow: hidden;
}

.top_menu {
  background-color: #fff;
  width: 100%;
  padding: 20px 0 15px;
  box-shadow: 0 1px 30px rgba(0, 0, 0, 0.1);
}
.top_menu .buttons {
  margin: 3px 0 0 20px;
  position: absolute;
}
.top_menu .buttons .button {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: inline-block;
  margin-right: 10px;
  position: relative;
}
.top_menu .buttons .button.close {
  background-color: #f5886e;
}
.top_menu .buttons .button.minimize {
  background-color: #fdbf68;
}
.top_menu .buttons .button.maximize {
  background-color: #a3d063;
}
.top_menu .title {
  text-align: center;
  color: #bcbdc0;
  font-size: 20px;
}

.messages {
  position: relative;
  list-style: none;
  padding: 20px 10px 0 10px;
  margin: 0;
  height: 347px;
  overflow: scroll;
}
.messages .message {
  clear: both;
  overflow: hidden;
  margin-bottom: 20px;
  transition: all 0.5s linear;
  opacity: 0;
}
.messages .message.left .avatar {
  background-color: #f5886e;
  float: left;
}
.messages .message.left .text_wrapper {
  background-color: #ffe6cb;
  margin-left: 20px;
}
.messages .message.left .text_wrapper::after, .messages .message.left .text_wrapper::before {
  right: 100%;
  border-right-color: #ffe6cb;
}
.messages .message.left .text {
  color: #c48843;
}
.messages .message.right .avatar {
  background-color: #fdbf68;
  float: right;
}
.messages .message.right .text_wrapper {
  background-color: #c7eafc;
  margin-right: 20px;
  float: right;
}
.messages .message.right .text_wrapper::after, .messages .message.right .text_wrapper::before {
  left: 100%;
  border-left-color: #c7eafc;
}
.messages .message.right .text {
  color: #45829b;
}
.messages .message.appeared {
  opacity: 1;
}
.messages .message .avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  display: inline-block;
}
.messages .message .text_wrapper {
  display: inline-block;
  padding: 20px;
  border-radius: 6px;
  width: calc(100% - 85px);
  min-width: 100px;
  position: relative;
}
.messages .message .text_wrapper::after, .messages .message .text_wrapper:before {
  top: 18px;
  border: solid transparent;
  content: " ";
  height: 0;
  width: 0;
  position: absolute;
  pointer-events: none;
}
.messages .message .text_wrapper::after {
  border-width: 13px;
  margin-top: 0px;
}
.messages .message .text_wrapper::before {
  border-width: 15px;
  margin-top: -2px;
}
.messages .message .text_wrapper .text {
  font-size: 18px;
  font-weight: 300;
}

.bottom_wrapper {
  position: relative;
  width: 100%;
  background-color: #fff;
  padding: 20px 20px;
  position: absolute;
  bottom: 0;
}
.bottom_wrapper .message_input_wrapper {
  display: inline-block;
  height: 50px;
  border-radius: 25px;
  border: 1px solid #bcbdc0;
  width: calc(100% - 160px);
  position: relative;
  padding: 0 20px;
}
.bottom_wrapper .message_input_wrapper .message_input {
  border: none;
  height: 100%;
  box-sizing: border-box;
  width: calc(100% - 40px);
  position: absolute;
  outline-width: 0;
  color: gray;
}
.bottom_wrapper .send_message {
  width: 140px;
  height: 50px;
  display: inline-block;
  border-radius: 50px;
  background-color: #a3d063;
  border: 2px solid #a3d063;
  color: #fff;
  cursor: pointer;
  transition: all 0.2s linear;
  text-align: center;
  float: right;
}
.bottom_wrapper .send_message:hover {
  color: #a3d063;
  background-color: #fff;
}
.bottom_wrapper .send_message .text {
  font-size: 18px;
  font-weight: 300;
  display: inline-block;
  line-height: 48px;
}

.message_template {
  display: none;
}
</style>
<script>
(function () {
	
	var webSocket = new WebSocket('ws://192.168.10.9:8081/chatserver');
	 
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
	 //   textarea.value += "Server Disconnect...\n";
	 };

	 
	 function onMessage(event) {
	    //$('#messageWindow').val($('#messageWindow').val() + event.data + "\n");
	    var Message;
	    Message = function (arg) {
	        this.text = arg.text, this.message_side = arg.message_side;
	        this.draw = function (_this) {
	            return function () {
	                var $message;
	                $message = $($('.message_template').clone().html());
	                $message.addClass(_this.message_side).find('.text').html(_this.text);
	                $('#invenMessages1').append($message);
	                return setTimeout(function () {
	                    return $message.addClass('appeared');
	                }, 0);
	            };
	        }(this);
	        return this;
	    };
	    
        var $messages, message;
        $messages = $('.messages');
        message_side = 'left';
        message = new Message({
            text: event.data,
            message_side: message_side
        });
        message.draw();
        return $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 300);
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
	     location.reload();
	 }
	 
	 $(window).bind("beforeunload",function(){
	    webSocket.send("${nickName}님 접속해제");
	    webSocket.close();
	 });
	 
    var Message;
    Message = function (arg) {
        this.text = arg.text, this.message_side = arg.message_side;
        this.draw = function (_this) {
            return function () {
                var $message;
                $message = $($('.message_template').clone().html());
                $message.addClass(_this.message_side).find('.text').html(_this.text);
                $('.messages').append($message);
                return setTimeout(function () {
                    return $message.addClass('appeared');
                }, 0);
            };
        }(this);
        return this;
    };
    $(function () {
        var getMessageText, message_side, sendMessage;
        message_side = 'right';
        getMessageText = function () {
            var $message_input;
            $message_input = $('.message_input');
            return $message_input.val();
        };
        sendMessage = function (text , action , id) {
            var $messages, message;
            if (text.trim() === '') {
                return;
            }
            $('.message_input').val('');
            $messages = $('.messages');
            message_side = message_side === 'left' ? 'right' : 'left';
            if (action === 'send') {
            	message_side = 'right';
            } else {
            	message_side = 'left';
            }
            message = new Message({
                text: text,
                message_side: message_side
            });
            message.draw();
            return $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 300);
        };
        $('.send_message').click(function (e) {
        	webSocket.send($(this).attr('id')+ ":" + "${nickName}:" + getMessageText());
            return sendMessage(getMessageText() , 'send', $(this).attr('id'));
        });
        $('.message_input').keyup(function (e) {
            if (e.which === 13) {
                return sendMessage(getMessageText());
            }
        });
        sendMessage('Hello Aggro! :)');
//         return setTimeout(function () {
//             return sendMessage('I\'m fine, thank you!');
//         }, 2000);
    });
}.call(this));

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
            <tr align="center">
               <td colspan="2">
               <form name="invenfrm" id="invenfrm" action="${context}/realword/inven/chat" method="post" target="popup_window">
               <button type="button" class="btn btn-default btn-lg" id="naverChat1" data-toggle="modal" data-target="#myModal">
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
	               <button type="button" class="btn btn-default btn-lg" id="invenChat1" data-toggle="modal" data-target="#myModal">
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

<div class="chat_window" style="display: none;">
	<div class="top_menu">
		<div class="buttons">
			<div class="button close"></div>
			<div class="button minimize"></div>
			<div class="button maximize"></div>
		</div>
		<div class="title">Chat</div>
	</div>
	<ul class="messages" id="invenMessages1"></ul>
	<div class="bottom_wrapper clearfix">
		<div class="message_input_wrapper">
			<input class="message_input" placeholder="Type your message here..." />
		</div>
		<div class="send_message" id="invenChat1">
			<div class="icon"></div>
			<div class="text">Send</div>
		</div>
	</div>
</div>
<div class="message_template">
	<li class="message">
		<div class="avatar"></div>
		<div class="text_wrapper">
		<div class="text"></div>
		</div>
	</li>
</div>

<script>
	$('#invenChat1').click(function(e) {
		$('.chat_window').show();
	});
	$('#naverChat1').click(function() {
		$('.chat_window').show();
	});
</script>
