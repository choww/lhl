$(document).ready(function() {

  //if ($('#poll_movies').length > 0) {
  //  setTimeout(updateMovies, 5000);
  //}

  $('.button').click(function() {
    setTimeout(updateMovies,1000);
  }); 

 function getMovies() {
   $.get('/poll_movies', function(data, status) {
     var movies = $('#all_movies');
     var movie = JSON.stringify(data[0]);
     var updated = movie['updated_at'];
      
     $('<p>').html();      
   });
 }

  function updateMovies() {
    $.get('/poll_movies', function(data, status) {
      var initialMovies = $('#all_movies').children().length;
      var json = JSON.stringify(data[0]['title']);
      if (initialMovies != data.length) {
        var p = $('<p>');
        p.html(JSON.stringify(data[0])).appendTo('#poll_movies');
       };
     });
   }
});
