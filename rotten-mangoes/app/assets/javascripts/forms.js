$(document).ready(function() {
  // TOGGLE SIGN UP / LOGIN FORM
  $('#login-modal').modal('show');
  
  // NEW ACTOR FORM
  $('#new_actor').on('ajax:success', function(event, actor) {
    this.reset();
    console.log('success');
    var div = $('#movie-cast');
    var string = actor['roles'][0]['name'] + ': ' + actor['firstname'] + ' ' + actor['lastname'];
    $('<p>').text(string).appendTo(div);
  }).on('ajax:error', function(event, actor) {
    console.log('error');
  });
});
