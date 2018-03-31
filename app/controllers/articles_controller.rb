class ArticlesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.all
    render json_params_for(@articles)
    
  end

  # GET /articles/1
  def show
    render json: @article, :except => [:updated_at]
  end

  # POST /articles
  def create
    @article = Article.new(title: params[:title], subtitle: params[:subtitle], body: params[:body])
    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    render json: @article
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
     body: article.body.truncate(5)
     created_at: article.created_at,
    }
    end
    collection.to_json
  end
end
