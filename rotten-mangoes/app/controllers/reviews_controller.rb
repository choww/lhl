class ReviewsController < ApplicationController
  before_action :load_movie
  before_action :restrict_access

  def create
    @review = @movie.reviews.build(review_params)
    @review.user = current_user
    
    if @review.save
      render json: @review.as_json( include: {user: {only: [:firstname, :lastname]}} ), 
                           status: :created, 
                           location: @movie
    end
  end

  protected
    def review_params
      params.require(:review).permit(
        :text, :rating_out_of_ten, :user_id
      )
    end

    def load_movie
      @movie = Movie.find(params[:movie_id])
    end
end
