class CreateTipificacoes < ActiveRecord::Migration[6.0]
  def change
    create_table :tipificacoes do |t|
    	t.string 			:tipo
    	t.string			:descricao
      t.timestamps
    end
  end
end
