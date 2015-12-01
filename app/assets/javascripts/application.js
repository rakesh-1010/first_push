// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require zeroclipboard
//= require jquery_ujs
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery-ui
//= require jquery.minicolors
//= require jquery.minicolors.simple_form
//= require jquery-ui-timepicker-addon
//= require social-share-button
//= require bootstrap-colorpicker
//= require sweepstakes
//= require turbolinks
//= require_tree .
//= stub js/classie
//= stub js/cbpAnimatedHeader
//= stub js/cbpAnimatedHeader.min
//= stub js/jqBootstrapValidation
//= stub js/contact_me
//= stub js/freelancer


$(document).ready(function(){
	if($("#sidebar-wrapper").length > 0) {
        sidebar_wrapper_height();
    }
    $(".dropdown").hover(            
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop( true, true ).slideDown("fast");
            $(this).toggleClass('open');        
        },
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop( true, true ).slideUp("fast");
            $(this).toggleClass('open');       
        });
});

$(document).ready(function(){
  $("#menu-toggle").click(function(e) {
        // e.preventDefault();
        $("#wrapper").toggleClass("active");
        $('.sidebar-footer.hidden-small').toggle();
        $('.register').toggleClass('slide-register');
});
});

$(document).ready(function(){
    $(".dropdown").hover(            
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop( true, true ).slideDown("fast");
            $(this).toggleClass('open');        
        },
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop( true, true ).slideUp("fast");
            $(this).toggleClass('open');       
        }
    );
});

function slide (argument) {
  $("#wrapper").toggleClass();
  $('.sidebar-footer.hidden-small').toggle();
}

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});

function openPopup(link)
{	
    window.open(link.href,'exam_dialog','toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=no');
    return false;   
}

function sidebar_wrapper_height()
{
    currentHeight = $('.register').outerHeight();    
    $("#sidebar-wrapper").css('height',""+currentHeight+" !important" );
}

