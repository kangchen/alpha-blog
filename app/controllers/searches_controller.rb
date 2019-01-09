class SearchesController < ApplicationController
  def index
    if params[:str] == nil || params[:str] == '' || params[:str].squish.length < 3
      flash[:danger] = "Search text must be 3 or more characters"
      redirect_to params[:cPath]
    else
      str = params[:str].to_s
      @search_str = Article.where("title like ?", '%' + str.squish! + '%' )
      @search_name = User.where("username = ?", str.squish!)
    end
  end

  def show
  end

end
