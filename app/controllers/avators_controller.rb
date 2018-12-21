class AvatorsController < ApplicationController
  before_action :set_avator, only: [:show, :edit, :update, :destroy]
  # before_action :require_user, except: [:index, :show, :new, :create]
  # before_action :get_avator_image, only: [:edit]
  # GET /avators
  # GET /avators.json
  def index
    @avators = Avator.all
  end

  # GET /avators/1
  # GET /avators/1.json
  def show
  end

  # GET /avators/new
  def new
    @path = 'new'
    @avator = Avator.new
    check = Avator.where("uid = ?", current_user.id)
    if check.count > 0

      redirect_to edit_user_path(current_user.id)
    end
  end


  # POST /avators
  # POST /avators.json
  def create
    @avator = Avator.new(avator_params)

    # respond_to do |format|
    if @avator.save
      # format.html { redirect_to @avator, notice: 'Avator was successfully created.' }
      # format.json { render :show, status: :created, location: @avator }
      flash[:notice] = "Avator was successfully created."
      redirect_to edit_user_path(current_user.id)
    else
      # format.html { render :new }
      # format.json { render json: @avator.errors, status: :unprocessable_entity }
      flash[:danger] = @avator.errors.full_messages
      redirect_to edit_user_path(current_user.id)
    end
    # end
  end

  # GET /avators/1/edit
  def edit
    @path = 'edit'
    # @avator avator_size
  end


  # PATCH/PUT /avators/1
  # PATCH/PUT /avators/1.json
  def update
    # respond_to do |format|
      if @avator.update(avator_params)
        flash[:notice] = "Avator was successfully updated."
        redirect_to edit_user_path(current_user.id)
        # format.html { redirect_to @avator, notice: 'Avator was successfully updated.' }
        # format.json { render :show, status: :ok, location: @avator }
      else
        # format.html { render :edit }
        # format.json { render json: @avator.errors, status: :unprocessable_entity }
        flash[:danger] = @avator.errors.full_messages
        redirect_to edit_user_path(current_user.id)
      end
    # end
  end

  # DELETE /avators/1
  # DELETE /avators/1.json
  def destroy
    @avator.destroy
    # respond_to do |format|
    #   format.html { redirect_to avators_url, notice: 'Avator was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    redirect_to avators_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avator
      @avator = Avator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def avator_params
      params.require(:avator).permit(:uid, :image)
    end

    def require_user
      avator_user = Avator.where("id=?", params[:id]) if logged_in?
      if !logged_in? || (logged_in? and avator_user[0].uid.to_s != current_user.id.to_s)
        flash[:danger] = "You are not authorized to perform that action"
        redirect_to edit_user_path(current_user.id)
      end
    end
end
