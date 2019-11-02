class PostsController < MembersController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.comments.build
  end

  def create
    Post.transaction do
      @post = Post.new(permitted_params)
      @post.save!
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    Post.transaction do
      @post = Post.find(params[:id])
      @post.attributes = permitted_params
      @post.save!
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :edit
  end

  def destroy
    Post.transaction do
      @post = Post.find(params[:id])
      @post.destroy
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :index
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :content,
                                 comments_attributes: [:post_id, :name, :content, :_destroy, :id])
  end
end
