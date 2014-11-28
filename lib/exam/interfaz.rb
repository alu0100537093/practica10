class Interfaz
	attr_accessor :examenes, :examen_seleccionado, :seleccion_menu
	def initialize(examenes)
		examenes.each{ |x|
			raise ArgumentError, 'El array debe ser de objetos de tipo Examen' unless x.is_a? Examen
		}
		
		@examenes = examenes
		@examen_seleccionado = 0 #Este atributo apuntará al indice del examen que se desea realizar
		@seleccion_menu = 0 #Este atributo almacenará la opcion del menu elegida por el usuario
	end
	
	def showmenu()
		menu = ["Opcion 1. Cargar examen.\nOpcion 2. Resolver examen\nOpcion 3. Ver dificultad de examen\nOpcion 4. Invertir examen cargado.\nOpcion 5. Salir."]
	end
	
	def opcion1
		contador = 1
		aux = "\n\nSeleccione el examen que desee cargar\n"
		@examenes.each{ |x|
			aux += "#{contador}. #{x.id}\n"
			contador = contador + 1
		}
		aux
	end

	def opcion2
		
		reset #Reseteamos el examen en el caso de que se haya ejecutado anteriormente
		examen = @examenes[@examen_seleccionado]
		n_preguntas = examen.lista.count
		respuesta = ""
		n_preguntas.times do |i|
			puts mostrar_pregunta(examen, i)
			puts "\n"
			puts "Su respuesta (Introduzca la respuesta y pulse Ctrl + D para continuar: "
			respuesta =$stdin.read
			respuesta = respuesta.to_i
			puts "\n\n"
			puts corregir_pregunta(examen, i, respuesta)
		end	
		puts mostrar_resultado
	end

	def opcion3
		"La dificultad del examen cargado es: #{@examenes[@examen_seleccionado].dificultad_examen}"
	end

	def mostrar_resultado
		"\n\nResultado final:\n\n\tRespuestas correctas: #{@examenes[@examen_seleccionado].respuestas_correctas}\n\tRespuestas incorrectas: #{@examenes[@examen_seleccionado].respuestas_erroneas}\n\n"
	end

	def cargar_examen(indice_examen)
		@examen_seleccionado = indice_examen
	end

	def mostrar_pregunta(examen, pregunta)
		examen.lista[pregunta].to_s
	end

	def corregir_pregunta(examen, indice_pregunta, respuesta_usuario)
		
		decision = respuesta_usuario - 1
		if(examen.comprobar_respuesta(indice_pregunta, decision))
			return "\nRespuesta Correcta.\n"
		else
			return "\nRespuesta Incorrecta.\n"
		end
	end

	def reset
		@examenes.each { |exam|
			exam.reset
		}
	end

	def ejecucion_debug(examen)
		#el examen seleccionado por defecto será el de la posición 0. -> @examenes[0]
		elementos = @examenes[examen].lista.count
		
		elementos.times do |iterador|
			#puts mostrar_pregunta( @examenes[@examen_seleccionado], iterador) -> Mostraría la pregunta, pero es la máquina quien resuelvey no tiene sentido mostrar.
			opcion_aleatoria = rand(@examenes[examen].lista[iterador].respuestas.size)
			@examenes[examen].comprobar_respuesta(iterador, opcion_aleatoria)
		end

		if((@examenes[examen].respuestas_correctas + @examenes[examen].respuestas_erroneas == elementos))
			return true # Si el numero de respuestas correctas + el numero de respuestas erroneas = n_preguntas, entonces se
		else	            # han respondido a todas las preguntas
			return false
		end	
	end

	def invertir(funcion)
		funcion.call
	end

	def menu
		puts showmenu
		puts "\n\n"
		puts "Introduzca la operacion que desea realizar(Presione Ctrl + D para confirmar): "
		@seleccion_menu = $stdin.read
		@seleccion_menu = @seleccion_menu.to_i
		puts "\n\n"
		case @seleccion_menu
			when 1
				puts opcion1
				puts "\n"
				exam = $stdin.read
				value = exam.to_i
				value = value -1
				cargar_examen(value)
				menu
			when 2
				opcion2
				menu
			when 3	
				puts opcion3
				puts "\n"
				menu
			when 4
				invertir(@examanes[@examen_seleccionado].invertir)
				puts "Se ha invertido el orden de las preguntas del examen: #{@examanes[@examen_seleccionado].id}\n\n"
				menu
			when 5
				return
		end
	end

end
