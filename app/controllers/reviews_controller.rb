class ReviewsController < ApplicationController
    def index 
        @article = Article.where(id: params[:id])
        if not @article.empty?  
            render json: @article.first.comments, :except => [:updated_at], content_type: "application/json"
        else
            render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
        end
        
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
            render json: @review.first, :except => [:updated_at], content_type: "application/json"
        else
            render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
        end
    end
    def destroy
        @review = Review.where(id: params[:id_comment], article_id: params[:id])
        if not @review.empty?  
            @review.first.destroy
            render json: @review.first, :except => [:updated_at]
        else
            render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
        end
    end
    def update
        @review = Review.where(id: params[:id_comment], article_id: params[:id])
        if not @review.empty?  
          @review.first.update(review_params)
          render json: @review, status: 200, content_type: "application/json"
        else
          render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
        end
    end
    def update_put
        if (params[:author].present? && params[:comment].present? && params[:created_at].present?)
            @review = Review.where(id: params[:id_comment], article_id: params[:id])
            if not @review.empty?  
              @review.first.update(review_params)
              render json: @review, status: 200
            else
              render json: @review, status: 404
            end
        else
            render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
        end
    end
    def review_params
      params.permit(:author, :comment)
    end

end
