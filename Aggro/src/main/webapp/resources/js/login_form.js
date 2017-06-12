/**
 * 로그인화면 JavaScript
 */

var setFormLogin = {
		setFormLogin : function(context) {
			var inputbox = '';
			var passwordBox = '';
			var loginDiv = '';
			var loginImgButtonTag ='';
			var context1 = context;
			console.log(context1+'@@@');
			loginDiv += '<br/><br/><img id = "loginform_image" src="../resources/img/member/loginform_image.jpg" />';
			inputbox += '<input placeholder="아이디를 입력하세요" type = "text" name ="id" class="form-control"/>';
			passwordBox += '<input placeholder="비밀번호를 입력하세요" id="input_pw" type ="password" name ="password" class="form-control"/><br/>';
			loginImgButtonTag += '<img id = "loginImgButton" alt="" src="../resources/img/main/button.png" /><br/>';
			$('#loginDiv1').append(loginDiv);
			$('#input1').append(inputbox);
			$('#input1').append(passwordBox);
			$('#loginButton').append(loginImgButtonTag);
			
			
			$('#loginform_image').css('border','0').css('width','160px').css('height','160px');
			$('#loginImgButton').css('width','160px');
			$('#loginButton').addClass('text-center');
			$('#loginButton').css('margin-left','1%');
			$('#loginImgButton').click(function() {
			$('form').attr('action',context1+'/member/login').attr('method','post').submit();
			
		});	
		}
}