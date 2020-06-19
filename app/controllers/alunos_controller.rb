# coding: utf-8
class AlunosController < ApplicationController
before_action :set_aluno, only: [:show, :edit, :update, :destroy, :alterna_aluno]

  def index
    @alunos_total = Aluno.where(ativo: true)
    @pagy, @alunos = pagy(@alunos_total.order(:id))
  end

  def show
  end

  def new
    @aluno = Aluno.new
    @clientes = Cliente.order('nome').where(ativo: true)
  end

  def edit
    @clientes = Cliente.order('nome').where(ativo: true)
  end

  def create
    @aluno = Aluno.new(aluno_params)
    @aluno.ativo = true
    respond_to do |format|
      if @aluno.save
        #gera_notificacao("admin",@aluno, action_name)
        format.html { redirect_to @aluno, notice: "Aluno #{@aluno.nome} criado com sucesso." }
        #format.json { render action: 'show', status: :created, location: @aluno }
      else
        showErrors(@aluno.errors)
        format.html { render action: 'new' }
        #format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @clientes = Cliente.order('nome').where(ativo: true)
    respond_to do |format|
      if @aluno.update(aluno_params)
        #gera_notificacao("admin",@aluno, action_name)
        format.html { redirect_to @aluno, notice: "Dados do aluno #{@aluno.nome} foram atualizados com sucesso." }
        #format.json { head :no_content }
      else
        showErrors(@aluno.errors)
        format.html { render action: 'edit' }
        #format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @aluno.matriculas.any?
      redirect_to alunos_path, alert: "Não foi possível excluir o(a) aluno(a) #{@aluno.nome}. Primeiro você precisa encerrar as matrículas vinculadas."
    else
      respond_to do |format|
        if @aluno.destroy
          #gera_notificacao("admin",@aluno, action_name)
          format.html { redirect_to alunos_path}
          #format.json { head :no_content }
        else
          showErrors(@aluno.errors)
          format.html { redirect_back fallback_location: alunos_path }
        end
      end
    end
  end

  def alterna_aluno
    if @aluno.ativo?
      if @aluno.matriculas.any?
        redirect_to alunos_path, alert: "Exclusão cancelada. O aluno #{@aluno.nome} tem matriculas vinculadas. Favor encerrar as matriculas."
        return
      else  
        @aluno.update_attribute(:ativo, false)
      end
    else
      @aluno.update_attribute(:ativo, true)
    end
    if Rails.application.routes.recognize_path(request.referrer)[:controller] == 'clientes'
      redirect_to cliente_path(@aluno.cliente.id), notice: "Status do aluno #{@aluno.nome} alterado com sucesso."
    else
      redirect_to alunos_path, notice: "Status do aluno #{@aluno.nome} alterado com sucesso."
    end
  end

  def inativos
    @inativos = Aluno.where(ativo: false)
    @pagy, @alunos = pagy(@inativos.order(:id))
  end

  def busca_dados_cliente
    @cliente = Cliente.find(params[:cliente_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluno
      @aluno = Aluno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aluno_params
      params.require(:aluno).permit(:cliente_id, :nome, :rg, :cpf, :celular, :nascimento, :pai, :mae, :nacionalidade)
    end
end
