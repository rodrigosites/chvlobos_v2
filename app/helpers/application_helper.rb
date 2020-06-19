include Pagy::Frontend

module ApplicationHelper

	def is_admin?
		self.level == 'admin'
	end

	def is_user?
		self.level == 'user'
	end

	def is_pending?
		self.level == 'pending'
	end

	def now
		Time.now
	end

	def dayPTBR(string)
    	string.slice(2,string.length-1)
	end

	def hourPTBR(horario)
	  horario.to_s.slice(10..15)
	end

	def datePTBR
		self.strftime('%d/%m/%Y')
  	end

  def showErrors(modelErrors)
  	errors = ''
    modelErrors.full_messages.each do |e|
      errors += "- #{e} <br>"
    end
    flash.now[:alert] = errors.html_safe
  end

	def get_config(config_attribute)
		Rails.application.config.send(config_attribute)
	end

	def toPTBR
		case self
			when 'new'
				'cadastrar'
			when 'edit'
				'editar'
			when 'show'
				'abrir'
			when 'index'
				'listar'
			when 'users'
				'usuários'
			else
				self
		end	
	end

	def actionTitle(controller)
		controller.capitalize!
		case self
			when 'new'
				"Cadastrar Novo(a) #{controller.singularize}"
			when 'edit'
				"Editar Dados do(a) #{controller.singularize}"
			when 'show'
				"Abrir Cadastro do(a) #{controller.singularize}"
			when 'index'
				"Listar #{controller} Ativos(as)"
			when 'inativos'
				"Listar #{controller} Inativos(as)"
			when 'encerradas'
				"Listar #{controller} Encerradas"
			when 'visualiza_folha'
				"Visualizar Folha de Pagamento"
			when 'visualiza_boletos'
				"Visualizar Boletos por Cliente"				
		end
	end

	def actionDescription(controller)
		case self
			when 'new'
				"Nesta página você pode cadastrar um(a) novo(a) #{controller.singularize} no sistema."
			when'edit'
				"Nesta página você pode editar os dados de um(a) #{controller.singularize} previamente cadastrado(a) no sistema."
			when'show'
				"Nesta página você pode consultar os dados de um(a) #{controller.singularize} previamente cadastrado(a) no sistema."
			when'index'
				"Nesta página você tem acesso a lista de #{controller.pluralize} ativos(as) existentes no sistema."
			when 'inativos'
				"Nesta página você tem acesso a lista de #{controller.pluralize} inativos(as) existentes no sistema."
			when 'encerradas'
				"Nesta página você tem acesso a lista de #{controller.pluralize} encerradas existentes no sistema."
			when 'visualiza_folha'
				"Nesta página você tem acesso a folha de pagamento de acordo com o mês e ano selecionados. Lembrando que o pagamento é realizado ao professor no mês subsequente ao período selecionado."
			when 'visualiza_boletos'
				"Nesta página você tem acesso ao valor dos boletos por cliente, de acordo com o mês e ano selecionados."
		end
	end

end
