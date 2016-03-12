module MoviesHelper
  def movie_modal_header(action)
    action == 'new' ? "Submit a Movie" : "Edit Movie"
  end
end
