class SalariosController < ApplicationController
	before_action :set_salario, only: [:show, :edit, :update, :destroy]

	def index
		@pagy, @salarios = pagy(Salario.where("data_inicio <= ? AND data_fim IS NULL", now))
		@circular = Circular.where(vigente: true).first
	end

	def new
		@salario = Salario.new
	end

	def create
		@salario = Salario.new(salario_params)
	end

	def edit
	end

	def show
	end

	def update
		respond_to do |format|
			if @salario.data_fim.nil?
	      if @salario.update(salario_params)
	        #gera_notificacao("admin",@aluno, action_name)
	        format.html { redirect_to visualizar_salarios_path(@salario.professor_id), notice: "Salário alterado com sucesso." }
	        #format.json { head :no_content }
	      else
	        showErrors(@salario.errors)
	        format.html { render action: 'edit' }
	        #format.json { render json: @aluno.errors, status: :unprocessable_entity }
	      end
	    else
	  		if params[:salario][:data_fim].present? && @salario.update(salario_params)
	  			#gera_notificacao("admin",@aluno, action_name)
	        format.html { redirect_to visualizar_salarios_path(@salario.professor_id), notice: "Salário alterado com sucesso." }
	        #format.json { head :no_content }
	      else
	      	flash.now[:alert] = "Erro: Fim da Vigência não pode estar em branco."
	      	format.html { render action: 'edit' }
	      end
	    end
	  end
	end

	def destroy
	end

	def atribuir_salarios
		@circular = Circular.where(vigente: true).first
		@salarios_substituidos = Salario.where(data_fim: nil)
		if @salarios_substituidos.size > 0
			@salarios_substituidos.each do |substituido|
				substituido.update_attribute(:data_fim, (@circular.data_circular - 1))
			end
		end
		@professores = Professor.order(:nome)
		error = false
		@professores.each do |professor|
			@salario = Salario.new(professor_id: professor.id, valor: @circular.salario_aula, data_inicio: @circular.data_circular)
			unless @salario.save
				error = true
			end
		end
		respond_to do |format|
			unless error
				format.html { redirect_to salarios_path, notice: "Salários atribuídos com sucesso." }
			else
				format.html { redirect_to salarios_path, alert: "Erro: Já existem salários cadastrados com início da vigência em #{@circular.data_circular.datePTBR}. " }
			end
		end
	end

	def visualizar_salarios
		@professor = Professor.find(params[:professor_id])
		@salario_vigente = Salario.where(professor_id: @professor.id, data_fim: nil).first
		@pagy, @salarios_antigos = pagy(Salario.where("professor_id = ? AND id != ?", @professor.id, @salario_vigente.id))
	end

	private

  # Use callbacks to share common setup or constraints between actions.
  def set_salario
    @salario = Salario.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def salario_params
    params.require(:salario).permit(:professor_id, :valor, :data_inicio, :data_fim)
  end

end
