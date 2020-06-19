class Tipificacao < ApplicationRecord
	has_many :despesa

	validates :tipo, uniqueness: true
	validates :tipo, presence: true
end
