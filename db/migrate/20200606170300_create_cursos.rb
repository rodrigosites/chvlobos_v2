class CreateCursos < ActiveRecord::Migration[6.0]
  def change
    create_table :cursos do |t|
    	t.string   :nome
	    t.integer  :anos
  	  t.boolean  :basico
      t.timestamps
    end
  end
end
