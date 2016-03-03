class ActorsController < ApplicationController
  before_action :init_movie

  def create
    @actor = @movie.actors.build(actor_params)
    if @actor.save
      render json: @actor.as_json( include: {roles: {only: :name}} ),  
                   status: :created, 
                   location: @movie      
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
