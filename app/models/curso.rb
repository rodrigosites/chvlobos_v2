class Curso < ApplicationRecord
	
	#associações no banco de dados
  has_many :lecionam
  has_many :matriculas, :dependent => :destroy
  has_many :professores, through: :lecionam

  #validações
  validates :nome, uniqueness: true
  validates :nome, :anos, presence: true

  def nome=(s)
    super s.titleize
  end

end
