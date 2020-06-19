class LecionamController < ApplicationController

	def index
  end

  def show
  end

  def edit
  end

	# NEW referente a associação HABTM entre os modelos Curso e Professor
  def new
		@leciona = Leciona.new
		@professores = Professor.order("nome")
		@curso = Curso.find(params[:curso_id]).nome.capitalize
  end

  # CREATE referente a associação HABTM entre os modelos Curso e Professor
  def create
		professores = params[:leciona][:professor_id]
	  professores.shift
		curso_id = params[:leciona][:curso_id]
    erro = false
    unless professores[0].nil?
	    professores.each do |professor|
	      @leciona = Leciona.new
	      @leciona.curso_id = curso_id
	      @leciona.professor_id = professor
	      unless @leciona.save #? gera_notificacao("admin",@horario, action_name) : erro = true
	        erro = true
	      end
	    end
	  else
	  	erro = true
	  end
    respond_to do |format|
	    unless erro
				format.html { redirect_to Curso.find(curso_id), notice: "Professor(es) vinculado(s) com sucesso." }
				#format.json { render action: 'show', status: :created, location: @leciona }
			else
				format.html { redirect_to lecionar_path(curso_id: curso_id), alert: "Nenhum professor foi selecionado."}
				#format.json { render json: @leciona.errors, status: :unprocessable_entity }
			end
		end
	end

  def update
  end

  def destroy
		@leciona = Leciona.find(params[:id])
		respond_to do |format|
			if @leciona.destroy
		  	format.html { redirect_to @leciona.curso}
		  	#format.json { head :no_content }
		  else
		  	showErrors(@leciona.errors)
		  	format.html { redirect_back fallback_location: @leciona.curso }
		  end
		end
  end

  private
	# Never trust parameters from the scary internet, only allow the white list through.
  def leciona_params
	  params.require(:leciona).permit(:curso_id,:professor_id => [])
  end
  
end
