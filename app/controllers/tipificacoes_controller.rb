class TipificacoesController < ApplicationController
	before_action :set_tipificacao, only: [:show, :edit, :update, :destroy]

	def index
		@pagy, @tipificacoes = pagy(Tipificacao.all)
	end

	def new
		@tipificacao = Tipificacao.new
	end

	def create
		@tipificacao = Tipificacao.new(tipificacao_params)
		respond_to do |format|
			if @tipificacao.save
				format.html { redirect_to tipificacoes_path, notice: "Tipificação #{@tipificacao.tipo} criada com sucesso." }
				#format.json { }
			else
				showErrors(@tipificacao.errors)
				format.html { render action: 'new'}
			end
		end
	end

	def update
		respond_to do |format|
			if @tipificaco.update(tipificacao_params)
				format.html { redirect_to tipificacoes_path, notice: "Tipificação #{@tipificacao.tipo} atualizada com sucesso." }
				#format.json { }
			else
				showErrors(@tipificacao.errors)
				format.html { render action: 'edit' }
			end
		end
	end

	def destroy
		respond_to do |format|
      if @tipificacao.destroy
        format.html { redirect_to tipificacoes_path, notice: "Tipificação #{@tipificacao.tipo} excluída com sucesso."}
        #format.json { }
      else
        showErrors(@tipificacao.errors)
        format.html { redirect_back fallback_location: tipificacoes_path }
      end
    end
	end

	def edit
	end

	def show
	end

	private

	def set_tipificacao
		@tipificacao = Tipificacao.find(params[:id])
	end

	def tipificacao_params
		params.require(:tipificacao).permit(:tipo, :descricao)
    end
end
