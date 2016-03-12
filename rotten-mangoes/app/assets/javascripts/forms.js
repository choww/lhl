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
    console.log(review);
    $('<p>').text(review.text).appendTo(div);
    $('<p>').text(review.rating_out_of_ten + '/10').appendTo(div);

    var fullname = review.user.firstname + ' ' + review.user.lastname;
    var reviewer = $('<p>').appendTo(div);
    reviewer.text('Reviewed by: ');
    $('<a>').attr('href', '/users/' + review.user_id).text(fullname).appendTo(reviewer);
  });
});
