class Salario < ApplicationRecord
	#associações no banco de dados
  belongs_to :professor

  validates :data_inicio, :data_fim, uniqueness: { scope: :professor_id, message: 'Já existe salário com data semelhante cadastrada.'}
  validates :professor_id, :valor, :data_inicio, presence: true
end
