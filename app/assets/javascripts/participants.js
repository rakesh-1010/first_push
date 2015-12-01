$( document ).ready(function() {
	$("#sweep_sweep_name").change(function(){
	var id = $("#sweep_sweep_name").val();
		    $.ajax({
				type: "get",
		        url: '/participants/winner_list',
		        data: {
		            id: id
		        },
		        success: function(data){
		        }
        	});
	});
});
$(function() {
 participantFormValidate();
});

