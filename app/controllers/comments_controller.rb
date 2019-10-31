class CommentsController < ApplicationController
  def create
    Comment.transaction do
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(permitted_params)
      @comment.save!
    end

    redirect_to post_path(@post)
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    redirect_to post_path(@post)
  end

  private

  def permitted_params
    params.require(:comment).permit(:post_id, :name, :content)
  end
end
