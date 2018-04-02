class ArticlesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.all
    render json: json_params_for(@articles)
    
  end

  # GET /articles/1
  def show
    render json: @article, :except => [:updated_at], content_type: "application/json"
  end

  # POST /articles
  def create
    @article = Article.new(title: params[:title], subtitle: params[:subtitle], body: params[:body])
    if @article.save
      render json: @article, status: :created, location: @article, content_type: "application/json"
    else
      render json: @article.errors, status: :unprocessable_entity, content_type: "application/json"
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article, content_type: "application/json"
    else
      render json: @article.errors, status: :unprocessable_entity, content_type: "application/json"
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    render json: @article, content_type: "application/json"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.permit(:title, :subtitle, :body)
    end

  def json_params_for(objects)
    collection = objects.map do |article|
    { id: article.id,
     subtitle: article.subtitle,
     body: article.body.truncate(500),
     created_at: article.created_at,
    }
    end
    collection.to_json
  end
end
