Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'user_sessions#new'

  resources :alunos, :circulares, :clientes, :cursos, :despesas, :horarios, :lecionam, :professores, :salarios, :tipificacoes, :users, :user_sessions

  #users and sessions
  get 'login' => 'user_sessions#new'
  post 'logout' => 'user_sessions#destroy'
  get 'index' => 'user_sessions#index'
  get 'validate_user/:id', to: "users#validate_user", as: :validate_user

  #alunos
  get 'aluno/busca_dados_cliente', to: "alunos#busca_dados_cliente"
  get 'alunos_inativos', to: "alunos#inativos"
  get 'alterna_aluno/:id', to: "alunos#alterna_aluno", as: :alterna_aluno

  #circulares
  post 'circular_vigente', to: "circulares#circular_vigente"

  #clientes
	get 'alterna_cliente/:id', to: "clientes#alterna_cliente", as: :alterna_cliente
  get 'clientes_inativos', to: "clientes#inativos"
  get 'email_clientes', to: "clientes#listar_emails"

  #financas
  get 'visualiza_boletos', to: "financas#visualiza_boletos"
  get 'visualiza_folha', to: "financas#visualiza_folha"

  #horarios
  get 'horario/:professor_id/disponivel' => 'horarios#new', as: :disponivel
  get 'horario/:professor_id' => 'horarios#destroy_all',  as: :destroy_all

  #lecionam
  get 'lecionam/:curso_id/lecionar' => 'lecionam#new', as: :lecionar

  #matriculas
  resources :matriculas do
    collection do
      get 'busca_professores', to: "matriculas#busca_professores"
      get 'busca_horarios', to: "matriculas#busca_horarios"
      get 'busca_horarios_teoria', to: "matriculas#busca_horarios_teoria"
      get 'busca_dados_curso', to: "matriculas#busca_dados_curso"
      get 'tipo_teoria', to: "matriculas#tipo_teoria"
    end
  end
  get 'matricula_nova', to: "matriculas#new"
  get 'reimprimir_contratos', to: "matriculas#reimprimir_contratos"
  get 'matricula_extra', to: "matriculas#new"
  get 'matriculas_encerradas', to: "matriculas#encerradas"
  get 'altera_encerramento', to: "matriculas#altera_encerramento"
  post 'refaz_contrato', to: "matriculas#refaz_contrato"
  get 'rematricular', to: "matriculas#rematricular"
  get 'rematricular_base', to: "matriculas#rematricular_base"
  get 'reativar_matricula/:id', to: "matriculas#reativar_matricula", as: :reativar_matricula

  #professores
  get 'professores_inativos', to: "professores#inativos"
  get 'professor/:id/controlar_horarios' => 'professores#controlar_horarios', as: :controlar_horarios
  get 'professor/:id/listar_alunos' => 'professores#listar_alunos', as: :listar_alunos
  get 'professor/:horario_id/alunos_horario' => 'professores#alunos_horario', as: :alunos_horario
  get 'alterna_professor/:id', to: "professores#alterna_professor", as: :alterna_professor

  #salarios
  get 'atribuir_salarios', to: "salarios#atribuir_salarios"
  get 'salarios/:professor_id/visualizar_salarios', to: 'salarios#visualizar_salarios', as: :visualizar_salarios

end
