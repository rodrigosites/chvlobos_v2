class Circular < ApplicationRecord
	#validações
  validates :numero_circular, uniqueness: true
  validates :numero_circular, :data_circular, :desconto, :valor_mensalidade, :valor_extra, :valor_profissionalizante,
  :taxa_matricula, presence: true
end
