class Aula < ApplicationRecord
	#associações
  belongs_to :horario
  belongs_to :matricula

  #validações
  validates :horario_id, :matricula_id, presence: true
end
