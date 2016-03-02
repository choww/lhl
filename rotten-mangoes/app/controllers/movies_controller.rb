class MoviesController < ApplicationController
  def index
    @movies = Movie.all 

    search_params = [params[:title], params[:director], params[:duration]]
    @search_params = search_params.select { |param| !param.nil? }

    unless @search_params.empty? 
      params[:duration] = '> 0' if params[:duration].nil? || params[:duration].empty? 
      @results =  Movie.where("title LIKE ? AND director LIKE ? AND runtime_in_minutes #{params[:duration]}", "%#{params[:title]}%", "%#{params[:director]}%")  
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
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
    redirect_to movies_path
  end  
  
  protected
    def movie_params
      params.require(:movie).permit(
        :title, :release_date, :director, :runtime_in_minutes,
        :image, :remove_image, :description
      )
    end
end
