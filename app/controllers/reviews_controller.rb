class ReviewsController < ApplicationController
    def index 
        @article = Article.find(params[:id])
        @comments = @article.reviews
        render json: @comments
    end
    def create
    @article = Article.new(author: params[:author], comment: params[:comment], article_id: params[:id)
    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end
end
