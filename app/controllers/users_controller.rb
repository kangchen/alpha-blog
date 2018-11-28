class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  # before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], :per_page => PER_PAGE).order('username ASC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    # @user = User.new
    if current_user != @user
      flash[:danger] = "You can only edit your own profile"
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User account was successfully updated"
      redirect_to articles_path
    else
      # @action = 'Update Article'
      render 'edit'
    end
  end

  def show

  end

  private
  def user_params
    params.require("user").permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if !logged_in? && current_user != @user
      # @message_color = "red"
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end
end
