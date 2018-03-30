class ReviewsController < ApplicationController
    def index 
        @article = Article.find(params[:id])
        @comments = @article.reviews
        render json: @comments
    end
    def create
        @review = Review.new(author: params[:author], comment: params[:comment], article_id: params[:id])
        if @review.save
          render json: @review, status: :created
        else
          render json: @review.errors, status: :unprocessable_entity
        end
    end
    def show
        @review = Review.where(id: params[:id_comment], article_id: params[:id])
        if not @review.empty?  
            render json: @review, :except => [:updated_at]
        end
    end
    def destroy
        @review = Review.where(id: params[:id_comment], article_id: params[:id])
        if @review.empty?
            render @review, status: :not_found

        else
            @review.destroy
            render json:@review, status: 200
        end
    end
end
