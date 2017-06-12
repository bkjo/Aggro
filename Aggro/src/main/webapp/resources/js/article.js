/**
 * 
 */
	var article = {
			context : '',
			setContext : function(context) {
				this.context = context;
			},
			getContext : function(){
				return this.context;
			},
			writeForm : function() {  
		
				var writeForm = 
					'<form>'
					+'<div class="form-group">'
					+'<label for="boardTitle">제목</label>'
					+'<input type="text" class="form-control" id="title" name="title" placeholder="제 목">'
					+'</div>'
					+'<div class="form-group">'
					+'<label for="boardWriter">작성자</label>'
					+'<input type="text" class="form-control" id="writerName" name="writerName" placeholder="작 성 자"></div>'
					+'<div class="form-group">'
					+'<label for="boardPassword">비밀번호</label>'
					+'<input type="password" id="password" class="form-control" name="password" placeholder="비 밀 번 호"></div>'
					+'<div class="form-group">'
					+'<label for="boardContent">글내용</label>'
					+'<textarea id="content" name="content" class="form-control"  rows="5" placeholder="글 내 용"></textarea></div>'
					+'<button type="submit" id="writeSubmit" class="btn btn-primary btn-lg btn-block">전 송</button>'
					+'</form>';
			
					$('.container').html(writeForm);
					$('#writeSubmit').click(function() { 
					$('form').attr('method','post').attr('action',article.getContext()+'/article/write').submit();
					});
			},
			update : function(path) {
				$.ajax({
					url : path,
					data : {},
					async : true,
					dataType : 'json',
					success : function(data) {						
						data = data.info; 
						var searchResult = 
							'<form>'
							+'<div class="form-group">'
							+'<label for="articleId">글번호</label>'
							+'<input type="text" class="form-control" id="articleId" name="articleId" value="'+data.articleId+'" >'
							+'</div>'
							+'<div class="form-group">'
							+'<label for="boardTitle">제목</label>'
							+'<input type="text" class="form-control" id="title" name="title" value="'+data.title+'" >'
							+'</div>'
							+'<div class="form-group">'
							+'<label for="boardWriter">작성자</label>'
							+'<input type="text" class="form-control" id="writerName" name="writerName" value="'+data.writerName+'" ></div>'
							+'<div class="form-group">'
							+'<label for="boardPassword">비밀번호</label>'
							+'<input type="password" id="password" class="form-control" name="password" value="'+data.password+'" ></div>'
							+'<div class="form-group">'
							+'<label for="boardContent">글내용</label>'
							+'<textarea id="content" name="content" class="form-control"  rows="5"  >'+data.content+'</textarea></div>'
							+'<button type="submit" id="updateSubmit" class="btn col-xs-6 btn-primary btn-lg ">수 정</button>'
							+'<button type="submit" id="deleteSubmit" class="btn col-xs-6 btn-danger btn-lg ">삭 제</button>'
							+'</form>';
						
						$('.container').html(searchResult);
					/*	$("textarea#content").text(data.content);*/
						$('#updateSubmit').click(function(e) {
							e.preventDefault(); //기존의 submit을 무시
							$.ajax(article.getContext()+'/article/update',{
								data : {
									articleId : $('#articleId').val(),
									title : $('#title').val(),
									writerName : $('#writerName').val(),
									password : $('#password').val(),
									content : $('#content').val()
								},
								type : 'post',
								//생략가능
								/*	dataType : 'json',
									async : true,*/
								success : function(data) {
//		 						article.detail(article.getContext()+"/article/search/"+data.id);
									location.href= article.getContext()+"/article/list";
								},
								error : function(xhr,status,msg) {
									alert('에러발생상태 :'+status+',내용 : '+msg);
								}
							});
						});
						$('#deleteSubmit').click(function(e) {
							e.preventDefault();
							$.ajax(article.getContext()+'/article/delete',{
							data : {
								articleId : $('#articleId').val()
							},
							success : function(data) {
								alert(data.message);
								location.href= article.getContext()+'/article/list';
							},
							error : function(xhr,status,msg) {
								alert('에러발생상태 :'+status+',내용 : '+msg);
							}
							});
						});
					},
					error : function(xhr,status,msg) {
						alert('에러발생상태 :'+status+',내용 : '+msg);
					}
				});
			},
		 detail : function(path) {
			 alert(path);
			$.ajax({
				url : path,
				data : {
					articleId : $('#articleId').val()
				},
				async : true,
				dataType : 'json',
				success : function(data) {	
					var searchResult = 
						'<form>'
						+'<div class="form-group">'
						+'<label for="articleId">글번호</label>'
						+'<input type="text" class="form-control" id="articleId" name="articleId" value="'+data.info.articleId+'" >'
						+'</div>'
						+'<div class="form-group">'
						+'<label for="boardTitle">제목</label>'
						+'<input type="text" class="form-control" id="title" name="title" value="'+data.info.title+'" >'
						+'</div>'
						+'<div class="form-group">'
						+'<label for="boardWriter">작성자</label>'
						+'<input type="text" class="form-control" id="writerName" name="writerName" value="'+data.info.writerName+'" ></div>'
						+'<div class="form-group">'
						+'<label for="boardPassword">비밀번호</label>'
						+'<input type="password" id="password" class="form-control" name="password" value="'+data.info.password+'" ></div>'
						+'<div class="form-group">'
						+'<label for="boardContent">글내용</label>'
						+'<textarea id="content" name="content" class="form-control"  rows="5"  >'+data.info.content+'</textarea></div>'
						+'<button type="submit" id="updateForm" class="btn col-xs-6 btn-primary btn-lg ">수 정</button>'
						+'<input type="button" id="replyForm" value="댓글 달기" class="btn col-xs-6 btn-danger btn-lg ">'
						+'</form>';
					
					$('.container').html(searchResult);
//					$('.container').append(article.replyForm(data.reply));
					

					
					$('#updateForm').click(function(e) {
						e.preventDefault(); //기존의 submit을 무시
						$.ajax(article.getContext()+'/article/update',{
							data : {
								articleId : $('#articleId').val(),
								title : $('#title').val(),
								writerName : $('#writerName').val(),
								password : $('#password').val(),
								content : $('#content').val()
							},
							type : 'post',
							//생략가능
							/*	dataType : 'json',
								async : true,*/
							success : function(data) {
//	 						article.detail(article.getContext()+"/article/search/"+data.id);
								location.href= article.getContext()+"/article/list";
							},
							error : function(xhr,status,msg) {
								alert('에러발생상태 :'+status+',내용 : '+msg);
							}
						});
					});
					$(document).on("click","#replyForm",function(e){
						e.preventDefault(); //기존의 submit을 무시
						$('.container').html(searchResult);
						$('.container').append(article.replyForm(data.reply));
						for(var index = 0; index < data.comment.length; index++){
							
							//$('#tblList').append("<tr><td>"+data.comment[index].reply+"</td><td><br/>");
							$('#replyView').append("<div><tr><td>"+data.comment[index].reply+"</tr></td></div>");
							
						}
				/*		$.each(data.reply, function() {
							$('#tblList').append("<tr><td>" +"a" + "</td><td>"
									+ "a" + "</td></tr>");
							});*/
			 
						$('#replyForm').attr("value","댓글 감추기").attr("id","replyForm2");
					});
					
					$(document).on("click","#replyForm2",function(e){
						e.preventDefault(); //기존의 submit을 무시
							$('.container').html(searchResult);
							$('#replyForm2').attr("value","댓글 달기").attr("id","replyForm");
						});
					$(document).on("click","#acceptSubmit",function(e) {
						e.preventDefault(); //기존의 submit을 무시
							alert('acceptSubmit');
							$.ajax(path,{
								data : {
									articleId : $('#articleId').val(),
									reply : $('#reply').val()
								},
								type : 'post',
								//생략가능
								/*	dataType : 'json',
									async : true,*/
								success : function(data) {
//		 						article.detail(article.getContext()+"/article/search/"+data.id);
								//location.href= article.getContext()+"/article/list";
									alert('됭당');
								},
								error : function(xhr,status,msg) {
									alert('에러발생상태 :'+status+',내용 : '+msg);
								}
							});
						});
					$('#replySubmit').click(function(e) {
						e.preventDefault(); //기존의 submit을 무시
						alert('replySubmit');
					});
					
				},
				error : function(xhr,status,msg) {
					alert('에러발생상태 :'+status+',내용 : '+msg);
				}
				});
			
		},
		replyForm : function(data) {

			
			
			var replyTag = '<form>'
				+'<div class="form-group">'
				+'<label for="boardContent">댓글</label>'
				+'<div id="replyView"  class="form-group">' 
				+'</div>'
				+'<textarea name="reply" id="reply" class="form-control" rows="5">'
				+'</textarea>'
				+'<button type="submit" id="acceptSubmit" class="btn col-xs-6 btn-success btn-lg ">확 인</button>'
				+'<button type="submit" id="replySubmit" class="btn col-xs-6 btn-warning btn-lg ">취 소</button>'
				+'</form>';
		
				return replyTag;
		} 
		};
