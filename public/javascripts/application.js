jQuery.noConflict();
jq = jQuery;
$ = jQuery;
$$ = jQuery;

//sidebar
$(document).ready(function() {
	$('#sidebar > .block > h3').each(function(index, value) {
		$(value).click(function() {
//			alert($(this.parentNode).children().filter(':last-child').html());
			$(this.parentNode).children().filter(':last-child').toggle();
		})
	})
});