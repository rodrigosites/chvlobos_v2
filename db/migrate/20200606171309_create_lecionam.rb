class CreateLecionam < ActiveRecord::Migration[6.0]
  def change
    create_table :lecionam do |t|
    	t.integer  "curso_id"
    	t.integer  "professor_id"
      t.timestamps
    end
  end
end
