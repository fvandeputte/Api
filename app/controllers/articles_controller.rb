class ArticlesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_article, only: [:update]

  # GET /articles
  def index
    @articles = Article.all
    response.headers['Content-type'] = "application/json"
    render json: json_params_for(@articles)
    
  end

  # GET /articles/1
  def show
    @article = Article.where(id: params[:id])
    if not @article.empty?
      render json: @article.first, :except => [:updated_at]
    else
      render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
    end
    #@article = Article.where(id: params[:id])
    #if not @article.empty?  
    #    render json: @article.first, :except => [:updated_at]
    #else
    #    @article_dos = Article.find(params[:id])
    #    render json: 'Not found', status: 404, content_type: "application/json"
    #end

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

  def update
        @article = Article.where(id: params[:id_article])
        if not @article.empty?  
          @article.first.update(article_params)
          render json: @article.first, status: 200, content_type: "application/json", :except => [:updated_at]
        else
          render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
        end
    end
  def update_put
        if (params[:title].present? && params[:subtitle].present? && params[:created_at].present? && params[:id].present? && params[:body].present?)
            @article = Article.where(id: params[:id_article])
            if not @article.empty?  
              @article.first.update(article_params)
              render json: @article.first, status: 200, content_type: "application/json", :except => [:updated_at]
            else
              render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
            end
        else
            render :json => {:error => "Should send all the fields"}.to_json, :status => 404, content_type: "application/json"
        end
    end


  # DELETE /articles/1
  def destroy
    @article = Article.where(id: params[:id])
    if not @article.empty?
      @article.first.destroy
      render json: @article.first, :except => [:updated_at], content_type: "application/json"
    else
      render :json => {:error => "Not found"}.to_json, :status => 404, content_type: "application/json"
    end
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
      title: article.title,
     subtitle: article.subtitle,
     body: article.body.truncate(500),
     created_at: article.created_at,
    }
    end
    collection.to_json
  end
end
