class LikesController < ApplicationController
    def create
        @article = Article.find(params[:article_id])
        if !already_liked?
            @article.likes.create(user_id: current_user.id)
        else
           flash[:notice] = "You have already liked this post!"
        end
        redirect_to article_path(@article)
    end
    
    def destroy
        @article = Article.find(params[:article_id])
        @like =  @article.likes.find(params[:id])
        if already_liked?
            @like.destroy
        else
            flash[:notice] = "You haven't liked this post!"
        end
        redirect_to article_path(@article)
    end
    private
        def already_liked?
            Like.where(user_id: current_user.id, article_id: params[:article_id]).exists?
        end
end
