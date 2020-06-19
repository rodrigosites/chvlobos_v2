module CursosHelper
	def get_leciona(curso,professor)
    Leciona.find_by(curso_id: curso, professor_id: professor)
  end
end
