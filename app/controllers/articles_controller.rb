class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    # @articles = Article.find_by_sql("select a.title, a.description, a.updated_at, a.id, u.username
    #   from kcorner.articles as a,kcorner.users as u where a.user_id = u.id order by a.updated_at desc")
    # @articles = Article.all.order('updated_at DESC') # order by oldest
    # @articles = Article.paginate(page: params[:page], per_page: 10)
    @articles = Article.paginate(page: params[:page], :per_page => PER_PAGE).order('updated_at DESC')
    # sleep 0.01
  end

# creating an article
  def new
    @article = Article.new
    @action = 'Create Article'
  end

  def create
    @article = Article.new(article_params)
    # @article.user = User.find(rand(1..7))
    @article.user = current_user
    if @article.save
      # @message_color = 'green'
      flash[:success] = "Article was successfully created"
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
    if logged_in? and current_user == @article.user
      if @article.update(article_params)
        flash[:notice] = "Article was successfully updated"
        redirect_to article_path(@article)
      end
    else
      @action = 'Update Article'
      flash[:danger] = "Only user #{@article.user.username} can update this article"
      redirect_to article_path
    end
  end

# deleting an article
  def destroy
    @article.destroy
    # @essage_color  = "green"
    flash[:notice] = "Article was successfully deleted"
    redirect_to user_path(current_user)
    # render 'edit'
  end

  def show
    # sleep 0.5
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      # @message_color = "red"
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to article_path
    end
  end

end
