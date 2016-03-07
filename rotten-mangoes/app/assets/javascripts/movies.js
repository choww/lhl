$(document).ready(function() {

  getMovies();

  if ($('#all_movies').length > 0) {
    setTimeout(updateMovies,10000);  
  }
  // build a div for each movie
  function getMovies() {
    $.get('/poll_movies', function(data, status) {
      var movies = $('#all_movies');
      data.forEach(function(movie) {
        var br = '<br/>';
        var movie_url = '/movies/' + movie['id'];
        var title = '<h2><a href=' + movie_url + '>' + movie['title'] + '</a></h2>';
        var release = movie['release_date'];
        var director = movie['director'];
        var runtime = movie['runtime_in_minutes'];
        var description = movie['description'];
        var img = "<img src='" + movie['image']['thumb']['url'] + "'>";

        var movie_str = img + title + 'Directed by ' + director + br + runtime + ' minutes' + br + description;
        var col = 'movie col-xs-4 col-md-3 col-xs-offset-1 col-md-offset-1';
        $('<div>').addClass(col).html(movie_str).appendTo(movies); 
      }); 
    });
  }

  function updateMovies() {
    $.get('/poll_movies', function(data, status) {
      var movies = $('#all_movies');
      if (movies.length > 0) {
        movies.empty();
      }
      getMovies();
      setTimeout(updateMovies, 10000);
    });
   }

});
