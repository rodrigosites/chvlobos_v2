class DespesasController < ApplicationController
		before_action :set_despesa, only: [:show, :edit, :update, :destroy]

	def index
		@pagy, @despesas = pagy(Despesa.all)
	end

	def new
		@despesa = Despesa.new
	end

	def create
		@despesa = Despesa.new(despesa_params)
		respond_to do |format|
			if @despesa.save
				format.html { redirect_to despesas_path, notice: "Despesa #{@despesa.tipo} criada com sucesso." }
				#format.json { }
			else
				showErrors(@despesa.errors)
				format.html { render action: 'new'}
				#format.json { }
			end
		end
	end

	def update
		respond_to do |format|
			if @tipificaco.update(despesa_params)
				format.html { redirect_to despesas_path, notice: "Despesa #{@despesa.tipo} atualizada com sucesso." }
				#format.json { }
			else
				showErrors(@despesa.errors)
				format.html { render action: 'edit' }
				#format.json { }
			end
		end
	end

	def destroy
		respond_to do |format|
      if @despesa.destroy
        format.html { redirect_to despesas_path, notice: "Despesa #{@despesa.tipo} excluída com sucesso."}
        #format.json { }
      else
        showErrors(@despesa.errors)
        format.html { redirect_back fallback_location: despesas_path }
        #format.json { }
      end
    end
	end

	def edit
	end

	def show
	end

	private

	def set_despesa
		@despesa = Despesa.find(params[:id])
	end

	def tipificacao_params
		params.require(:despesa).permit(:id_tipificacao, :nome, :valor, :vencimento, :referencia, :pago, :descricao)
    end
end
