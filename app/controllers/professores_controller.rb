# encoding: UTF-8
class ProfessoresController < ApplicationController
  before_action :set_professor, only: [:show, :edit, :update, :destroy, :controlar_horarios, :listar_alunos, :alterna_professor]

  def index
    @professores_total = Professor.where(ativo: true)
    @pagy, @professores = pagy(@professores_total.order(:id))
  end

  def show
  end

  def new
    @professor = Professor.new
  end

  def edit
  end

  def create
    @professor = Professor.new(professor_params)
    @professor.ativo = true
    respond_to do |format|
      if @professor.save
        #gera_notificacao("admin",@professor, action_name)
        format.html { redirect_to @professor, notice: "professor #{@professor.nome} criado com sucesso." }
        #format.json { render action: 'show', status: :created, location: @professor }
      else
        showErrors(@professor.errors)
        format.html { render action: 'new' }
        #format.json { render json: @professor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @professor.update(professor_params)
        #gera_notificacao("admin",@professor, action_name)
        format.html { redirect_to @professor, notice: "Dados do professor #{@professor.nome} foram atualizados com sucesso." }
        #format.json { head :no_content }
      else
        showErrors(@professor.errors)
        format.html { render action: 'edit' }
        #format.json { render json: @professor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @professor.destroy
        #gera_notificacao("admin",@professor, action_name)
        format.html { redirect_to professores_path}
        #format.json { head :no_content }
      else
        showErrors(@professor.errors)
        format.html { redirect_back fallback_location: professores_path }
      end
    end
  end

  def alterna_professor
    if @professor.ativo?
      tem_aluno = false
      @professor.horarios.each do |horario|
        horario.matriculas.size > 0 ? tem_aluno = true : tem_aluno = false
      end
      if tem_aluno
        redirect_to professores_path, alert: "Exclusão cancelada. O professor #{@professor.nome} tem alunos vinculados. Favor alterar a matricula dos alunos."
        return
      else  
        @professor.update_attribute(:ativo, false)
        @professor.horarios.destroy_all
      end
    else
      @professor.update_attribute(:ativo, true)
    end
    redirect_to professores_inativos_path, notice: "Status do professor #{@professor.nome} alterado com sucesso."
  end

  def inativos
    @inativos = Professor.where(ativo: false)
    @pagy, @professores = pagy(@inativos.order(:id))
  end

  def controlar_horarios
    @pagy, @horarios = pagy(@professor.horarios.order('dia','horario'))
  end

  def listar_alunos
    @horarios = @professor.horarios.order('dia','horario').joins(:matriculas).group('horarios.id')#.page(params[:page]).per_page(9)
  end

  def alunos_horario
    @horario = Horario.find(params[:horario_id])
    @aulas = @horario.aulas
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professor
      @professor = Professor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def professor_params
      params.require(:professor).permit(:nome, :endereco, :rg, :cpf, :telefone, :celular, :email, :nascimento, :bairro, :cidade,
        :uf, :cep, :pai, :mae, :nacionalidade, :profissao, :escolaridade)
    end
end