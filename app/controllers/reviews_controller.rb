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
            render json: @review.first, :except => [:updated_at]
        else
            render json: @review, status: 404
        end
    end
    def destroy
        @review = Review.where(id: params[:id_comment], article_id: params[:id])
        if not @review.empty?  
            @review.first.destroy
            render json: @review.first, :except => [:updated_at]
        else
            render json: @review, status: 404
        end
    end
    def update
        @review = Review.where(id: params[:id_comment], article_id: params[:id])
        if not @review.empty?  
          @review.first.update(review_params)
          render json: @review, status: 200
        else
          render json: @review, status: 404
        end
    end
    def review_params
      params.permit(:author, :comment)
    end

end
