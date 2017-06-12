<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Banner -->
<div class="banner-top">
    <img alt='top banner' src="${context}/resources/rainbow/images/main/main_header.png">
	<input type="hidden" id="sessionVar" value="${sessionScope.user.id}">
</div>

<!-- Header section -->
<header class="header-wrapper header-wrapper--home">
    <div class="container">
        <!-- Logo link-->
     	<a href="${context}" class="logo">
        	<img alt='logo' src="${context}/resources/rainbow/images/main/logo.png">
     	</a>

		<!-- Main website navigation-->
		<nav id="navigation-box">
			<!-- Toggle for mobile menu mode -->
			<a href="#" id="navigation-toggle"> 
				<span class="menu-icon">
					<span class="icon-toggle" role="button" aria-label="Toggle Navigation">
						<span class="lines"></span>
					</span>
				</span>
			</a>

			<!-- Link navigation -->
			<ul id="navigation">
				<!-- 이 부분에 메뉴 헤더 내용이 들어간다(로그인했을 시와 로그인 안했을 시에 헤더가 다르다 (layout.user에서 구분한다) -->
			</ul>
		</nav>

		<!-- Additional header buttons / Auth and direct link to booking-->
		<div class="control-panel">
			<div class="auth auth--home">
				<div class="auth__show">
				<span class="auth__image"> <img alt="" src="${context}/resources/rainbow/images/main/cholong.jpg"></span>
				</div>
				<a href="#" class="btn btn--sign btn--singin">${sessionScope.user.name}</a>
				<ul class="auth__function" id="dropBoxBtn">
                	<li id="purchaseListBtn"><a href="${context}/purchase/purchase_list/0" class="auth__function-item">예매내역</a></li>    
                	<li id="memberLeaveBtn"><a href="#" class="auth__function-item">회원탈퇴</a></li>    
                </ul>
			</div>
			<button id="bookBtn" class="btn btn-md btn--warning btn--book btn-control--home login-window" style="font-size: 11px;">Book a ticket</button>
		</div>
	</div>
</header>

<!-- open/close -->
<!-- 비회원 상태에서 book a ticket(노란버튼)을 누를 때 나타나는 회원 가입창이다. -->
<div class="overlay overlay-hugeinc">
	<section class="container">
		<div class="col-sm-4 col-sm-offset-4">
			<button type="button" class="overlay-close">Close</button>
				<form class="login" id="nav_login" name="nav_login">
                        <p class="login__title">sign in <br>
                        	<span class="login-edition">welcome to Rainbow Cinema</span>
                        </p>
                        <div class="social social--colored">
                                <a href='#' class="social__variant fa fa-facebook"></a>
                                <a href='#' class="social__variant fa fa-twitter"></a>
                                <a href='#' class="social__variant fa fa-tumblr"></a>
                        </div>
                        <p class="login__tracker">or</p>
                        <div class="field-wrap">
	                        <input type='text' placeholder='아이디를 입력하세요' id="nav_id" name="nav_id" class="login__input">
	                        <input type='text' placeholder='비밀번호를 입력하세요' id="nav_password" name='nav_password' class="login__input">
                        </div>
                        <div class="login__control">
                            <button id="nav_loginBtn" name="nav_loginBtn" class="btn btn-md btn--warning btn--wider">sign in</button>
                            <a href="#" class="login__tracker form__tracker">Forgot password?</a>
                        </div>
				</form>
			</div>
	</section>
</div>
