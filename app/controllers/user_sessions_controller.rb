class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy, :index]
  
  def new
	@user = User.new
  end

  def create
	if @user = login(params[:email], params[:password])
	  redirect_back_or_to(index_path, notice: "Autenticado.")
	else
	  flash.now[:alert] = "Usuário e/ou senha não conferem!"
      render :new
    end
  end

  def destroy
	logout
	redirect_to(root_path, notice: "Sua sessão foi encerrada.")
  end

  def index
  end
end
