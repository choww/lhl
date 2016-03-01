class ReviewsController < ApplicationController
  before_action :load_movie
  before_action :restrict_access

  def new
    @review = @movie.reviews.build
  end

  def create
    @review = @movie.reviews.build(review_params)
    @review.user_id = current_user.id
    
    if @review.save
      redirect_to @movie, notice: "Review created"
    else
      render :new
    end
  end

  protected
    def review_params
      params.require(:review).permit(
        :text, :rating_out_of_ten
      )
    end

    def load_movie
      @movie = Movie.find(params[:movie_id])
    end
end
