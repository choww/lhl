$(document).ready(function() {

  //if ($('#poll_movies').length > 0) {
  //  setTimeout(updateMovies, 5000);
  //}

  $('.button').click(function() {
    setTimeout(updateMovies,1000);
  }); 

  function updateMovies() {
    $.get('/poll_movies', function(data, status) {
      var initialMovies = $('#all_movies').children().length;

      if (initialMovies != data.length) {
        var p = $('<p>');
        p.html(JSON.stringify(data[0])).appendTo('#poll_movies');
       };
     });
   }
});
