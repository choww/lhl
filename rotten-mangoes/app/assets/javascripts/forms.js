$(function() {  
  // FORM TOGGLES
  $('.toggle-form-link').click(function(e) {  
    $(this).next('.toggle-form').show();
    e.preventDefault(); 
   });
  
  $('.close-btn').click(function() {
    $(this).closest('.toggle-form').hide();
  });
 
  // NEW ACTOR FORM
  $('#new_actor').on('ajax:success', function(event, actor) {
    this.reset();
    var div = $('#movie-cast');
    var string = actor.roles[0].name + ': ' + actor.firstname + ' ' + actor.lastname;
    $('<p>').text(string).appendTo(div);
  }).on('ajax:error', function(event, actor) {
    console.log('error');
  });

  // NEW REVIEW FORM
  $('#new_review').on('ajax:success', function(event, review) {
    this.reset();
    var div = $('#movie-review');
    
    $('<p>').text(review.text).appendTo(div);
    $('<p>').text(review.rating_out_of_ten + '/10').appendTo(div);

    // TODO: profile link doesn't currently include review user id
    var fullname = review.user.firstname + ' ' + review.user.lastname;
    $('<p>').html("Reviewed by: <a href='/user/'" + review.user_id + "'>" + fullname + "</a>").appendTo(div);
  });
});
