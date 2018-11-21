class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    # @articles = Article.find_by_sql("select a.title, a.description, a.updated_at, a.id, u.username
    #   from kcorner.articles as a,kcorner.users as u where a.user_id = u.id order by a.updated_at desc")
    @articles = Article.all.order('updated_at DESC') # order by oldest
  end

# creating an article
  def new
    @action = 'Create Article'
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.find(rand(1..5))
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      @action = 'Create Article'
      render 'new'
    end
  end

# updating an article
  def edit
    @action="Update Article"
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      @action = 'Update Article'
      render 'edit'
    end
  end

# deleting an article
  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end

  def show
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

end
