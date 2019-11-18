class CommentsController < MembersController
  before_action :authenticate_user!, only: [:destroy]
  before_action :find_commentable, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    Comment.transaction do
      @commentable.comments.build(permitted_params)
      @commentable.save!
    end

    redirect_back(fallback_location: root_path)
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    redirect_back(fallback_location: root_path)
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
    params.require(:comment).permit(:name, :content)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
    elsif params[:post_id]
      @commentable = Post.find_by_id(params[:post_id])
    end
  end

end
