class CreateDespesas < ActiveRecord::Migration[6.0]
  def change
    create_table :despesas do |t|
    	t.integer 		:id_tipificacao
      t.string      :nome
    	t.float				:valor
    	t.datetime		:vencimento
    	t.datetime		:referencia
    	t.boolean			:pago
      t.string      :descricao
      t.timestamps
    end
  end
end
