class Examen
	attr_reader :id

	def initialize(id, lista)
		raise ArgumentError, 'El id especificado no es una cadena' unless id.is_a? String
		raise ArgumentError, 'No se le pasa como argumento un objeto de tipo Lista' unless lista.is_a? Lista
		@id = id
		@lista = lista
	end
end