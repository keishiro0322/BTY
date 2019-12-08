class CategoriesController < MembersController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    Category.transaction do
      @category = Category.new(permitted_params)
      @category.save!
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    Category.transaction do
      @category = Category.find(params[:id])
      @category.attributes = permitted_params
      @category.save!
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :edit
  end

  def destroy
    Tag.transaction do
      @category = Category.find(params[:id])
      @category.destroy
    end

    redirect_to action: :index
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    render action: :index
  end

  private

  def permitted_params
    params.require(:category).permit(:name)
  end
end

