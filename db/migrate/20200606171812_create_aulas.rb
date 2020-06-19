class CreateAulas < ActiveRecord::Migration[6.0]
  def change
    create_table :aulas do |t|
    	t.integer  :matricula_id
	    t.integer  :horario_id
	    t.boolean  :teoria
	    t.boolean  :musicalizacao
      t.timestamps
    end
  end
end
