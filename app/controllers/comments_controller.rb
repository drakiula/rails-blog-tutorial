class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", only: [:create, :destroy, :archive]
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  def archive
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.status = 'archived'
    @comment.save
    redirect_to article_path(@article), status: :see_other
  end

 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status) 
    end
end
