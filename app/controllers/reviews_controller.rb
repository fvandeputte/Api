class ReviewsController < ApplicationController
    def index 
        @article = Article.find(params[:id])
        @comments = @article.reviews
        render json: @comments
    end
end
