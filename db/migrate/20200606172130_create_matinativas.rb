class CreateMatinativas < ActiveRecord::Migration[6.0]
  def change
    create_table :matinativas do |t|
    	t.integer  :aluno_id
	    t.integer  :curso_id
	    t.datetime :data_matricula
	    t.datetime :termino_matricula
	    t.integer  :ano
	    t.float    :valor_mensal
	    t.integer  :teoria_ano
	    t.integer  :id_ativa
	    t.integer  :professor_id
	    t.integer  :professor_teoria_id
	    t.integer  :dia_pratica
	    t.integer  :dia_teoria
      t.timestamps
    end
  end
end
