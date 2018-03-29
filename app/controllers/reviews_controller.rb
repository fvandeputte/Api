class ReviewsController < ApplicationController
    def index 
        @article = Article.find(params[:id])
        @comments = @article.reviews
        render json: @comments
    end
    def create
    @review = Review.new(author: params[:author], comment: params[:comment], article_id: params[:id])
    if @review.save
      render json: @review, status: :created, location: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end
end
