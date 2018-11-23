class UsersController < ApplicationController
  
  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], :per_page => PER_PAGE).order('username DESC')
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
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require("user").permit(:username, :email, :password)
  end

end
