class CreateCirculares < ActiveRecord::Migration[6.0]
  def change
    create_table :circulares do |t|
			t.string   :numero_circular
	    t.date     :data_circular
	    t.float    :desconto
	    t.float    :valor_mensalidade
	    t.float    :valor_extra
	    t.boolean  :vigente
	    t.float    :taxa_matricula
	    t.float    :salario_aula
	    t.float    :valor_profissionalizante
      t.timestamps
    end
  end
end
