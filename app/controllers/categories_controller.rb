class CategoriesController < ApplicationController
  def index
    # @categories = Category.paginate(page: params[:page], :per_page => PER_PAGE)
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:sucess] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
