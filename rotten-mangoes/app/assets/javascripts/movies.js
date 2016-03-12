$(function() {
  getMovies();
 
  setInterval(updateMovies, 10000);

  function getMovies() {
    $.ajax('/poll_movies', { dataType: 'json' })
      .done(function(data) {
        console.log('called?');
        var movies = $('#all_movies');
        data.forEach(function(movie) {
          buildMovie(movie, movies);
        }); 
      });
  }

  // poll request made every 10 seconds--but only reload data if additions or updates have been made
  function updateMovies() {
    var most_recent = $('.movie').first().attr('data-updated');

    $.ajax('/poll_movies', {
      success: function(data, status) {
        var movies = $('#all_movies');
        if (data[0].updated_at != most_recent) {
          movies.empty();       
          getMovies();
        }
      }
    });
  }

  // build a div for each movie and append it to the movies div
  // TODO: find better way to organize divs
  function buildMovie(movie, movies) {
    var br = '<br/>';
    var release = new Date(movie.release_date);

    var director = 'Directed by ' + movie.director;
    var runtime = movie.runtime_in_minutes + ' minutes';
    var description = movie.description;
    
    var movie_str = director + br + release + br + runtime + br + description;
    var classes = 'movie col-md-5 col-xs-offset-2 col-md-offset-1';
    var updated = movie.updated_at;
    var div = $('<div>').addClass(classes).attr('data-updated', updated).html(movie_str).appendTo(movies); 
    
    var movie_url = '/movies/' + movie.id;
    var h2 = $('<h3>').prependTo(div);
    $('<a>').attr('href', movie_url).text(movie.title).appendTo(h2);
    $('<img>').attr('src', movie.image.thumb.url).prependTo(div);
  }

  // MOVIE SEARCH FORM
  $('#search_movies').on('ajax:success', function(event, data) {
    this.reset();
    $('#all_movies').addClass('hidden');
    var movies = $('#search_results');

    data.forEach(function(movie) {
      buildMovie(movie, movies);
    });
  });


});
