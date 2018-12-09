class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

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
    # @category = Category.find(params[:id])
    # @category.articles = @category.articles.paginate(page: params[:page], per_page: PER_PAGE)
    @category = Article.find_by_sql("select u.username, a.user_id, a.id, a.title, a.description, ac.category_id, c.name
      from kcorner.article_categories ac, kcorner.articles a, kcorner.users u, kcorner.categories c
      where ac.category_id = #{params[:id]} and ac.article_id = a.id and a.user_id = u.id and ac.category_id = c.id")
    # @category_name = Category.find_by_sql("select name from kcorner.categories where id = #{params[:id].to_i}")
    @category_name = Category.where("id = ?", params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only admin can perform that action"
      redirect_to categories_path
    end
  end

end
