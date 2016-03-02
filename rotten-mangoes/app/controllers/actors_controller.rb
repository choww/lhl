class ActorsController < ApplicationController

  before_action :init_movie

  def new
    @actor = @movie.actors.build
    @actor.roles.build
  end

  def create
    @actor = @movie.actors.build(actor_params)
    if @actor.save
      redirect_to movie_path(@movie)
    else
      render :new
    end 
  end

  def show
  end

  private
    def init_movie
      @movie = Movie.find(params[:movie_id])
    end

    def actor_params
      params.require(:actor).permit(
        :firstname, :lastname, :image,
        roles_attributes: [:name, :movie_id, :actor_id]
      )
    end
end
