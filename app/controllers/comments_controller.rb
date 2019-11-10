class CommentsController < MembersController
  before_action :authenticate_user!, only: [:destroy]

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

  def destroy
    Post.transaction do
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
      @comment.destroy
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
