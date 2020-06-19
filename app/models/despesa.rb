class Despesa < ApplicationRecord
	belongs_to :tipificacao

	validates :id_tipificacao, :nome, :valor, :vencimento, :referencia, :pago, presence: true
	validates :referencia, uniquiness: { scope: :nome }
end
