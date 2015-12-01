$( document ).ready(function() {
  $(window).load(function() {
    // Animate loader off screen
    $(".se-pre-con").fadeOut("slow");;
  });
  var clip = new ZeroClipboard($("#d_clip_button"));
  $('head').append('<link rel="stylesheet" media="all" href="/assets/loader.css" data-turbolinks-track="true">');
  
  var theme = $('#hidden-bg-img').data('theme');
   if (theme > "") 
   {
    	$('head').append('<link rel="stylesheet" media="all" href="/assets/sweepstake_themes/'+theme+'.sass" data-turbolinks-track="true">');
    }
  var newimgsrc = $('#hidden-bg-img').data('url');
  $('#gift-wrapper').css('background-image', "url("+newimgsrc+")");
  $("a.popup").click(function(e) {
        popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
        e.stopPropagation(); return false;
    });
  if($("#sweepstake_entry_option_id").length > 0) {
    $("#sweepstake_entry_option_id").on('change',function() {
      if($('option:selected', this).text() == "qualified_entry")
      {
        $("#question").show();  
      }
      else
      {
        $("#question").hide();
      }
    });
  }

$("a.popup").click(function(e) {
        popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
        e.stopPropagation(); return false;
    });

});

function popupCenter(url, width, height, name) {
  var left = (screen.width/2)-(width/2);
  var top = (screen.height/2)-(height/2);
  return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}

$(document).on('ready readyAgain', function() {
    datePickerValidation();
});

$( document ).ready(function() {
	datePickerValidation();
});

function datePickerValidation() {
	var dates = $("#datepicker, #datepicker1").datetimepicker(
	{
	    minDate: "0",
	    maxDate: "+2Y",
	    defaultDate: "+1w",
	    dateFormat: 'yy-mm-dd',
	    timeFormat: "h:mm:ss TT",
	    numberOfMonths: 1,
	    onSelect: function(date) 
	    {
	        for(var i = 0; i < dates.length; ++i) 
	        {
	            if(dates[i].id < this.id)
	                $(dates[i]).datepicker('option', 'maxDate', date);
	            else if(dates[i].id > this.id)
	                $(dates[i]).datepicker('option', 'minDate', date);
	        }
	    } 
	});
}

function validateSweepstakes() {
  $('#sweepstake').validate({
  	rules: 
  	{	
	   'sweepstake[sweepstake_name]':
  	    {
  			required: true
  	    },
  	    'sweepstake[prize_name]':
  	    {
  			required: true
  	    },
  	    'sweepstake[start_date]':
  	    {
  			required: true
  	    },
  	    'sweepstake[end_date]':
  	    {
  			required: true
  	    },
  	    'sweepstake[winner_count]':
  	    {
  			required: true,
			number: true,
			min: 1
  	    },
  	    'sweepstake[entry_option_id]':
  	    {
  			required: true
  	    },
  	         
  	    'sweepstake[bg_color]':
  	    {
  			required: true
  	    }
  	         
      },
  	messages:
  	{		
  		'sweepstake[sweepstake_name]':
  		{
  			required: '*Please enter sweepstake name'
  		},
  	    'sweepstake[prize_name]':
  	    {
  			required: '*Please enter prize name'
  	    },
  	    'sweepstake[start_date]':
  	    {
  			required: '*Please select start date'
  	    },
  	    'sweepstake[end_date]':
  	    {
  			required: '*Please select end date'
  	    },
  	    'sweepstake[winner_count]':
  	    {
  			required: '*Please enter number of winner'
  	    },
  	    'sweepstake[entry_option_id]':
  	    {
  			required: 'Please select participant entry option'
  	    },
  	         
  	    'sweepstake[bg_color]':
  	    {
  			required: 'Please select background color for your widget'
  	    }  
            	
  	},
  	    	 errorPlacement: function(error, element) {
             error.insertAfter(element);
  	}
  });
}

$(window).load(function() {
  if($("#sweep_search").length > 0) {
    $(document).on("click","#sweep th a #sweep .pagination a", function() {
      $.getScript(this.href);
      return false;
    });
    $("#sweep_search input").keyup(function() {
      $.get($("#sweep_search").attr("action"), $("#sweep_search").serialize(), null, "script");
      return false;
    });
  }
});


$( document ).ready(function() {
	$("#sweepstake_prize_image").change(function(){
    var a = this.files[0];
    var ext = a.type;
    var images = ["image/jpg", "image/jpeg", "image/png","image/gif","image/bmp"];
    if(images.indexOf(ext)==-1)
    {
    	alert("Please select valid image type like[jpeg, png, gif, bmp]");
        $("#sweepstake_prize_image").val("");
     }
  });

  $("#sweepstake_rules").change(function(){
    var a = this.files[0];
    var ext = a.type;
    var images = ["application/pdf","application/vnd.ms-excel",
                  "application/msword", 
                  "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
                  "text/plain"];
    if(images.indexOf(ext)==-1)
    {
      alert("Please select valid content type like [pdf, msword, text]");
        $("#sweepstake_rules").val("");
     }
    });
    
});

function ClipBoard() 
{
        $("#tooltip").fadeIn();
        $("#tooltip").fadeOut();
}

$( document ).ready(function() {
	var clip = new ZeroClipboard($("#d_clip_button"));
	(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=1638730503067473";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

  $("#facebook").click(function() {
  		var name = $('#sweep-info').data("name");
  		var link = $('#sweep-info').data("link");
  		var image = $('#sweep-info').data("image");
		var e = {
        method: "feed",
        link: link,
        picture: image,
        name: name,
        caption: "Participate and Get a chance to win Amazing Prizes"
    };
    
FB.ui(e, function(t) {
        if (t["post_id"]) {
        alert("successessfully posted")	;
        }
   });

  });
  
});

function participantFormValidate() {
   // Page ready code...   
   $.validator.addMethod("loginRegex", function(value, element) {
          return this.optional(element) || value == value.match(/^[a-zA-Z\s]+$/);
      }, "*Must contain only letters.");
   $.validator.addMethod("emailRegex", function(value, element) {
          return this.optional(element) || value == value.match(/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/);
      }, "Invalid e-mail");
    
      
    $('#iregister_form').validate({
     rules: {
      'enroll[participant_name]':{
          required: true,
          loginRegex: true
      },
      'enroll[email]':
             {
          required: true,
          emailRegex: true
      },
      'enroll[participant_number]':{
           required: true,
           minlength: 10,
           maxlength: 10,
           number: true,
      },
       'enroll[answer]':{
          required: true
          }
      },
    messages:
      {
          'enroll[participant_name]':
          {
              required: "*Enter your name"
          },
          'enroll[participant_number]':
          {
              required: "*Enter number"
          },
          'enroll[email]':
          {
              required: "*Enter your email address"
          },
          'enroll[answer]':
          {
              required: "*Answer can't be blank"
          }
      },
     errorElement: 'div',
          errorPlacement: function(error, element) {
               error.insertAfter(element);
               
          }
    });
  }    
function enableButton2() {
        alert("sdsdsds");
          $("#button2").attr('disabled', false);
        }
$(document).ready ->
  $("#new_article").on("ajax:success", (e, data, status, xhr) ->
    $("#new_article").append xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_article").append "<p>ERROR</p>"