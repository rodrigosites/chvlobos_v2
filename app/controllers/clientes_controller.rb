# coding: utf-8
class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy, :alterna_cliente]

  def index
    @clientes_total = Cliente.where(ativo: true)
    @pagy, @clientes = pagy(@clientes_total.order(:id))
  end

  def show
    @alunos = Aluno.where(cliente_id: params[:id]).order(:id)
  end

  def new
    @cliente = Cliente.new
  end

  def edit
  end

  def create
    @cliente = Cliente.new(cliente_params)
    @cliente.ativo = true
    respond_to do |format|
      if @cliente.save
        #gera_notificacao("admin",@cliente, action_name)
        format.html { redirect_to @cliente, notice: "Cliente #{@cliente.nome} criado com sucesso." }
        #format.json { render action: 'show', status: :created, location: @cliente }
      else
        showErrors(@cliente.errors)
        format.html { render action: 'new' }
        #format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        #gera_notificacao("admin",@cliente, action_name)
        format.html { redirect_to @cliente, notice: "Dados do cliente #{@cliente.nome} foram atualizados com sucesso." }
        #format.json { head :no_content }
      else
        showErrors(@cliente.errors)
        format.html { render action: 'edit' }
        #format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @cliente.alunos.any?
      redirect_to clientes_path, alert: "Não foi possível excluir o(a) cliente #{@cliente.nome}. Primeiro você precisa excluir os alunos vinculadas."
    else
      respond_to do |format|
        if @cliente.destroy
          #gera_notificacao("admin",@cliente, action_name)
          format.html { redirect_to clientes_path}
          #format.json { head :no_content }
        else
          showErrors(@cliente.errors)
          format.html { redirect_back fallback_location: clientes_path }
        end
      end
    end
  end

  def inativos
    @inativos = Cliente.where(ativo: false)
    @pagy, @clientes = pagy(@inativos.order(:id))
  end

  def alterna_cliente
    if @cliente.ativo?
      if @cliente.alunos.any?
        redirect_to clientes_path, alert: "Não foi possível desativar o(a) cliente #{@cliente.nome}, pois existem alunos vinculados a ele(a)."
        return
      else  
        @cliente.update_attribute(:ativo, false)
        redirect_to clientes_path, notice: "Cliente #{@cliente.nome} desativado com sucesso."
      end
    else
      @cliente.update_attribute(:ativo, true)
      redirect_to clientes_inativos_path, notice: "Cliente #{@cliente.nome} reativado com sucesso."
    end
  end

  def listar_emails
    @emails = ""
    @email_ausente = []
    @clientes = Cliente.all
    @clientes.each do |cliente|
      cliente.alunos.each do |aluno|
        if aluno.matriculas.size > 0
          unless cliente.email == "@"
            @emails << "#{cliente.email};"
          else
            @email_ausente << cliente.nome
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(:nome, :endereco, :rg, :cpf, :telefone, :celular, :email, :nascimento, :bairro, :cidade,
        :uf, :cep, :pai, :mae, :nacionalidade, :profissao)
    end
end
