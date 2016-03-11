$(function() {
  getMovies();

  if ($('#all_movies').length > 0  ) {
    setTimeout(updateMovies,10000);  
  }

  // build a div for each movie
  // TODO: find better way to organize divs
  function buildMovie(movie) {
    var movies = $('#all_movies');

    var br = '<br/>';
    var release = movie.release_date;
    var director = 'Directed by ' + movie.director;
    var runtime = movie.runtime_in_minutes + ' minutes';
    var description = movie.description;

    var movie_str = director + br + runtime + br + description;
    var col = 'movie col-xs-4 col-md-3 col-xs-offset-1 col-md-offset-1';
    var updated = movie.updated_at;
    var div = $('<div>').addClass(col).attr('data-updated', updated).html(movie_str).appendTo(movies); 
    
    var movie_url = '/movies/' + movie.id;
    $('<h2>').html('<a href=' + movie_url + '>' + movie.title + '</a>').prependTo(div);
    $('<img>').attr('src', movie.image.thumb.url).prependTo(div);
  }

  // MOVIE SEARCH FORM
  $('#search_movies').on('ajax:success', function(event, data) {
    this.reset();
    data.forEach(
      function(movie) {
        $('#all_movies').addClass('hidden');
        var movies = $('#search_results');

        var br = '<br/>';
        var release = movie.release_date;
        var director = 'Directed by ' + movie.director;
        var runtime = movie.runtime_in_minutes + ' minutes';
        var description = movie.description;

        var movie_str = director + br + runtime + br + description;
        var col = 'movie col-xs-4 col-md-3 col-xs-offset-1 col-md-offset-1';
        var updated = movie.updated_at;
        var div = $('<div>').addClass(col).attr('data-updated', updated).html(movie_str).appendTo(movies); 
        
        var movie_url = '/movies/' + movie.id;
        $('<h2>').html('<a href=' + movie_url + '>' + movie.title + '</a>').prependTo(div);
        $('<img>').attr('src', movie.image.thumb.url).prependTo(div);    
      });
  });

  
  function getMovies() {
    $.ajax('/poll_movies', { dataType: 'json' })
      .done(function(data) {
        data.forEach( buildMovie ); 
      });
  }

  // poll request made every 10 seconds--but only reload data if additions or updates have been made
  function updateMovies() {
    var most_recent = $('.movie').first().attr('data-updated');

    $.ajax('/poll_movies', {
      success: function(data, status) {
        var movies = $('#all_movies');
        if (data[0].updated_at != most_recent) {
          console.log('yay');
          movies.empty();
          
          getMovies();
        }
       setTimeout(updateMovies, 10000);
      }
    });
  }

});
