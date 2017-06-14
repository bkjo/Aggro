<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<title>Hey Common Aggro</title>
<style> 
	#cm { position:absolute; } 
	.hc { width:200px; left:0; right:0; margin-left:auto; margin-right:auto; } /* 가로 중앙 정렬 */ 
	.vc { height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto; } /* 세로 중앙 정렬 */ 
</style>
<div id="cm" class="hc vc">
	<div>
		<form action="${context}/realword/nickname/create" method="post">
			<label for="nickName">NickName</label>
			<input id="nickName" name="nickName" type="text" class="form-control" id="nickName">
			<div align="right">
				<input id="btnNext" type="submit" class="btn btn-default" style="background-image:none;" value="Next" />
			</div>
		</form>
	</div>
</div>
