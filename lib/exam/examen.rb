class Examen
	attr_reader :id, :lista, :plantilla

	def initialize(id, lista)
		raise ArgumentError, 'El id especificado no es una cadena' unless id.is_a? String
		raise ArgumentError, 'No se le pasa como argumento un objeto de tipo Lista' unless lista.is_a? Lista
		@id = id
		@lista = lista
		@plantilla = []
		@lista.each{|x|
			@plantilla.push(x.r_correcta)
		}
	end
end
