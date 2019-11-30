class TagsController < MembersController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    Tag.transaction do
      @tag = Tag.new(permitted_params)
      @tag.save!
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    Tag.transaction do
      @tag = Tag.find(params[:id])
      @tag.attributes = permitted_params
      @tag.save!
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :edit
  end

  def destroy
    Tag.transaction do
      @tag = Tag.find(params[:id])
      @tag.destroy
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :index
  end

  private

  def permitted_params
    params.require(:tag).permit(:tag_name)
  end
end
