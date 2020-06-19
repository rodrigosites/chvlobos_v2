class CreateHorarios < ActiveRecord::Migration[6.0]
  def change
    create_table :horarios do |t|
    	t.integer  :professor_id
	    t.string   :dia
	    t.time     :horario
      t.timestamps
    end
  end
end
