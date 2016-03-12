class MoviesController < ApplicationController
  def index
    @user = User.new
    @movie = Movie.new
    @movie_action = 'new'
    @user_action = 'new'
  end

  def poll_movies
    @movies = Movie.all.order(updated_at: :desc)
    render json: @movies
  end

  def search
    search_params = [params[:title_or_director], params[:duration]]
    @search_params = search_params.select { |param| !param.nil? }

    unless @search_params.empty? 
      params[:duration] = '> 0' if params[:duration].nil? || params[:duration].empty?
      @movies = Movie.search_movie(params[:title_or_director], params[:duration])
    end
    render json: @movies
  end

  def show
    @user ||= User.new
    @user_action = 'new'
    @movie = Movie.find(params[:id])
    @movie_action = 'edit'

    @actor = @movie.actors.build
    @actor.roles.build

    @review = @movie.reviews.build
    @reviews = Movie.find(params[:id]).reviews
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to root_path
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to root_path
  end  
  
  protected
    def movie_params
      params.require(:movie).permit(
        :title, :release_date, :director, :runtime_in_minutes,
        :image, :remove_image, :description
      )
    end
end
