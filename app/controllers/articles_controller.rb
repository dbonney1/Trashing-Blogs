class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end
    
    def show
        @article = Article.find(params[:id])
        @related_articles = @article.find_related_tags
    end

    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new(article_params)
        @article.user = current_user
        
        if @article.save
            
            redirect_to @article
        else
            render 'new'
        end
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        
        redirect_to articles_path
    end
    
    def tagged
        if params[:tag].present?
            @articles = Article.tagged_with(params[:tag])
        else
            @articles = Article.all
        end
    end
end

    

private
    def article_params
        params.require(:article).permit(:title, :text, :tag_list)
    end