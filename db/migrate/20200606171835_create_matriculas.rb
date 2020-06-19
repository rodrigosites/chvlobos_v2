class CreateMatriculas < ActiveRecord::Migration[6.0]
  def change
    create_table :matriculas do |t|
    	t.integer  :aluno_id
	    t.integer  :curso_id
	    t.datetime :data_matricula
	    t.integer  :ano
	    t.float    :valor_mensal
	    t.integer  :teoria_ano
      t.timestamps
    end
  end
end
