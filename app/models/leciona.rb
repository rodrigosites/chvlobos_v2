class Leciona < ApplicationRecord
	#associações
	belongs_to :curso
  	belongs_to :professor

  	validates :curso_id, :professor_id, presence: true
end
