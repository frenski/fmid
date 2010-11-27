$(document).ready(function() {

  var soctype = $("input#entry_soctype").val();

  $('#'+soctype+'2').show();

  $("form#new_entry").submit(function() {
	
	$('#loader_img').show();

    var socid = $("input#entry_socid").val();
    $.post("/"+soctype, $(this).serialize(), function(data) {
	  $('#resultdiv').html(data);
	 });

    return false;
  });

  $('.nav_link').mouseover(function() {
    $(this).children('.nav_img2').fadeIn('fast');
  });

  $('#facebook2').mouseout(function() {
    if(soctype != 'facebook') $('#facebook2').fadeOut();
  });

  $('#twitter2').mouseout(function() {
    if(soctype != 'twitter') $('#twitter2').fadeOut();
  });

  $('#flickr2').mouseout(function() {
    if(soctype != 'flickr') $('#flickr2').fadeOut();
  });

});