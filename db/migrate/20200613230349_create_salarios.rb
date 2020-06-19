class CreateSalarios < ActiveRecord::Migration[6.0]
  def change
    create_table :salarios do |t|
    	t.integer 	:professor_id
    	t.float 		:valor
    	t.datetime 	:data_inicio
    	t.datetime	:data_fim
      t.timestamps
    end
  end
end
