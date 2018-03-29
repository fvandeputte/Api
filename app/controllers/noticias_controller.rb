class NoticiasController < ApplicationController
    def index
    @noticias = Noticia.all
    render json: @noticias
    end
end
