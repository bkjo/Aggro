/**
 *jQuery 속성 예제 
 */

var attr = {
	attrDemo : function(imgPath) {
		$('<img/>',{src:imgPath,width:'100%',height:'100%'}).appendTo($('#sampleBox1').empty());	
	},
	htmlDemo : function(target) {
		$("<div id='htmlBox'></div>").appendTo($(target).empty());
		$('#htmlBox').html('<div style="background : yellow; width:100px; height:100px;">노란 박스</div>');
	},
	textDemo : function(target) {
		$("<div id='textBox'></div>").appendTo($(target).empty());
		$('#textBox').text('블루박스');
	}
}
