# coding: utf-8

class HorariosController < ApplicationController
before_action :set_horario, only: [:show, :edit, :update, :destroy]

  def index
    @horarios = Horario.joins(:matriculas).group('horarios.id')
  end

  def show
  end

  def new
    @horario = Horario.new
  end

  def edit
  end

  def create
    horarios = params[:horario][:horario]
    horarios.shift
    erro = false
    unless horarios[0].nil?
      horarios.each do |horario|
        @horario = Horario.new(horario_params)
        @horario.horario = horario
        unless @horario.save #? gera_notificacao("admin",@horario, action_name) : erro = true
          erro = true
        end
      end
    else
      @horario = Horario.new(horario_params)
      @horario.horario = params[:diferenciado][:horario]
      unless @horario.save #? gera_notificacao("admin",@horario, action_name) : erro = true
        erro = true
      end
    end
    respond_to do |format|
      unless erro
        format.html { redirect_to controlar_horarios_path(id: @horario.professor_id), notice: "Horários cadastrados com sucesso." }
      else
        format.html { redirect_to disponivel_path(professor_id: params[:horario][:professor_id]), alert: "Houve um erro ao tentar cadastrar os horários." }
      end
    end
  end

  def update
    respond_to do |format|
      if @horario.update(horario_params)
        #gera_notificacao("admin",@horario, action_name)
        format.html { redirect_to @horario.professor, notice: "Horário #{dia(@horario.dia)} - 
        #{hora(@horario.horario)} foram atualizados com sucesso." }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @horario.destroy
        #gera_notificacao("admin",@horario, action_name)
        format.html { redirect_to controlar_horarios_path(id: @horario.professor_id) }
      else
        format.html { redirect_to @horario.professor, alert: "Não foi possível excluir o horário pois existem matrículas atreladas a ele."}
      end
    end
  end

  def destroy_all
    @professor = Professor.find(params[:professor_id])
    respond_to do |format|
      erro = false
      @professor.horarios.each do |horario|
        unless horario.destroy
          erro = true
        end
      end
      if erro
        format.html { redirect_to controlar_horarios_path(id: @professor), alert: "Não foi possível excluir todos os horários, pois existem matrículas atreladas a alguns deles."}
      else
        format.html { redirect_to controlar_horarios_path(id: @professor), notice: "Horários excluídos com sucesso."}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horario
      @horario = Horario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horario_params
      params.require(:horario).permit(:dia, :professor_id, :sala_id, :horario => [])
    end
end