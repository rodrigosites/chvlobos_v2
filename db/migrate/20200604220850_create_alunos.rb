class CreateAlunos < ActiveRecord::Migration[6.0]
  def change
    create_table :alunos do |t|
    	t.integer  :cliente_id
    	t.string   :nome
    	t.string   :rg
    	t.string   :cpf
    	t.string   :celular
    	t.date     :nascimento
    	t.string   :pai
    	t.string   :mae
    	t.string   :nacionalidade
    	t.boolean  :ativo
      t.timestamps
    end
  end
end
