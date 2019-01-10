class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  # before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], :per_page => PER_PAGE).order('username ASC')
    # expires_in 3.minutes, :public => true
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
      # flash[:danger] = @user.errors.full_messages.to_sentence
      # redirect_to signup_path
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

  def destroy
    @user = User.find(params[:id])
    image_ids = Avator.where("uid = ?", params[:id])
    if image_ids.count > 0
      @avator = Avator.find(image_ids[0].id)
      @avator.destroy
    end
    @user.destroy
    flash[:success] = "#{@user.username} and all articles created by #{@user.username} have been deleted"
    redirect_to users_path
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
      flash[:danger] = "You can only edit your own profile"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end

end
