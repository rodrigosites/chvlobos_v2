class UsersController < ApplicationController
	before_action :set_user, except: [:new, :create, :index]
  before_action :admin_level_check, only: [:validate_user, :admin_update, :destroy, :index]
	skip_before_action :require_login, only: [:new, :create]

	def index
    @users_total = User.order(:id)
    @pagy, @users = pagy(@users_total)
  end

  def new
		@user = User.new
	end

	# POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if User.all.size < 1
    	@user.level = "admin"
    elsif @user.level.nil?
      @user.level = "pending"
    end
    respond_to do |format|
      if @user.save
        if logged_in?
          format.html { redirect_to users_path, notice: "Usuário #{@user.name} cadastrado com sucesso." }
        else 
          format.html { redirect_to root_path, notice: "Usuário #{@user.name} cadastrado com sucesso." }
        end
        #format.json { render action: 'show', status: :created, location: @user }
      else
        showErrors(@user.errors)
        format.html { render :new }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "O cadastro do usuário #{@user.name} foi atualizado com sucesso." }
        #format.json { head :no_content }
      else
        showErrors(@user.errors)
        format.html { render :edit }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        if User.all.size < 1
          logout
        end
          format.html { redirect_to users_path }
          #format.json { head :no_content }
      else
        showErrors(@user.errors)
        format.html { redirect_back fallback_location: users_path }
      end
    end
  end

  def admin_update
  end

  def validate_user
    if @user.update_attribute(:level, 'user')
      respond_to do |format|
        format.html { redirect_to users_path, notice: "Usuário #{@user.name} validado com sucesso." }
        #format.json {}
      end
    else
      redirect_to users_path, alert: "#{@user.errors.full_messages}"
    end
  end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :level)
    end
end
