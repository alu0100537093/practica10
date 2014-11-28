#!/usr/bin/env ruby
# encoding: utf-8
require 'exam.rb'


describe Pregunta do
  
		
		before :each do
			@p1 = Pregunta.new("Pregunta", ['Respuesta a', 'Respuesta b', 'Respuesta c', 'Respuesta d'],0, 5)
			@p2 = Pregunta.new("Pregunta", ['Respuesta a', 'Respuesta b', 'Respuesta c', 'Respuesta d'], 3, 7)
		end
  
		it "Debe existir una pregunta" do
			expect(@p1).to eq(Pregunta.new("Pregunta", ['Respuesta a', 'Respuesta b', 'Respuesta c', 'Respuesta d'], 0, 5))
		end

		it "Existe un enunciado deseado" do
			expect(@p1.enunciado).not_to eq (nil)
			expect(@p1.enunciado).to eq ("Pregunta")
		end

		it "Existen respuestas" do
			expect(@p1.respuestas).not_to eq (nil)
			expect(@p1.respuestas).to eq (['Respuesta a', 'Respuesta b', 'Respuesta c', 'Respuesta d'])
		end

		it "Existe una opción de respuesta correcta" do
			expect(@p1.r_correcta).to eq(0)
			expect(@p2.r_correcta).to eq(3)
			expect(@p1.r_correcta).not_to eq(1)
			expect(@p2.r_correcta).not_to eq(2)
		end
		
		it"Las preguntas tienen asociadas una dificultad" do
			expect(@p1.dificultad).to eq(5)
			expect(@p2.dificultad).to eq(7)
			expect(@p1.dificultad).not_to eq(3)
			expect(@p2.dificultad).not_to eq(1)
		end

		it "Se devuelve la respuesta que se pasa como parametro" do
			expect(@p1.get_respuesta(1)).to eq('Respuesta b')
		end
		
		
		it "Las respuestas devuelve la respuesta solicitada adecuada" do
			expect(@p1.get_respuesta(0)).to eq("Respuesta a")
			expect(@p1.get_respuesta(1)).to eq("Respuesta b")
			expect(@p1.get_respuesta(2)).to eq("Respuesta c")
			expect(@p1.get_respuesta(3)).to eq("Respuesta d")
		end

		it "Comprobando funcionamiento del metodo to_s" do
			expect(@p1.to_s).to eq("Pregunta\n1. Respuesta a\n2. Respuesta b\n3. Respuesta c\n4. Respuesta d\n")
		end
		
		# Mixin Comparable!
		it "Se comparan preguntas correctamente" do
			expect(@p1<@p2).to eq(true)
			expect(@p1==@p2).to eq(false)
			expect(@p2>@p1).to eq(true)
		end
		

end


describe Preguntasverdadero_falso do
	
		before :each do
			@p1 = Preguntasverdadero_falso.new("Pregunta", 0,3)
			@p2 = Preguntasverdadero_falso.new("Pregunta", 1,6)
			@p3 = Pregunta.new("Pregunta", ['Respuesta a', 'Respuesta b', 'Respuesta c', 'Respuesta d'], 3, 3)
			@p4 = Pregunta.new("Pregunta", ['Respuesta a', 'Respuesta b', 'Respuesta c', 'Respuesta d'], 2 ,4)
		end

		it "Es una isntancia de la clase madre" do
			expect(@p1.instance_of?(Pregunta)).to eq(false)
			expect(@p1.instance_of?(Preguntasverdadero_falso)).to eq(true)
			expect(@p1.is_a?(Pregunta)).to eq(true)
			expect(@p1.is_a?(Preguntasverdadero_falso)).to eq(true)
		end
		
		it "Existe pregunta verdadero falso" do
			expect(@p1).to eq(Preguntasverdadero_falso.new("Pregunta", 0, 3))
		end
		
		it "Sus respuestas son verdadero y falso" do
			expect(@p1.respuestas).to eq(['Verdadero', 'Falso'])
		end
		
		it "El enunciado es el deseado" do
			expect(@p1.enunciado).to eq("Pregunta")
		end
		
		#Mixin comparable!
		it "Se comparan preguntas de verdadero y falso correctamente" do
			expect(@p1<@p2).to eq(true)
			expect(@p1==@p3).to eq(true)
			expect(@p2>@p3).to eq(true)
			expect(@p2>=@p3).to eq(true)
			expect(@p2<=@p3).to eq(false)
			expect(@p4.between?(@p1,@p2)).to eq(true)

		end
			
end	

describe Nodo do
	
		before :all do
			@ex1 = Pregunta.new("1+2 =",['2','3','7','1','Ninguna de las anteriores'], 1, 1)
			@ex2 = Pregunta.new("Pregunta ",['a','b','c','d'], 2, 3)
			@nodo_prueba = Nodo.new(@ex1,@ex2)
			@nodo_prueba2 = Nodo.new(@ex1,@ex1, @nodo_prueba)
			@nodo_prueba3 = Nodo.new(@ex1,@ex1, @nodo_prueba)
		end
	
		it "Existe un valor" do
			expect(@nodo_prueba[:value]).to eq(@ex1)
			expect(@nodo_prueba2[:value]).to eq(@ex1)	
		end
	
		it "Existe un siguiente" do
			expect(@nodo_prueba[:next]).to eq(@ex2)
			expect(@nodo_prueba2[:next]).to eq(@ex1)	
		end

		it "Existe un nodo anterior" do
			expect(@nodo_prueba2[:previous]).to eq(@nodo_prueba)
			expect(@nodo_prueba3[:previous]).to eq(@nodo_prueba)
		end
		
		it "Comprobamos el funcionamiento del operador =" do
			expect(@nodo_prueba2).to eq(@nodo_prueba3)
			expect(@nodo_prueba2).not_to eq(@nodo_prueba)
		end



end



describe Lista do
	
	
		before :all do
			@ex1 = Pregunta.new("1+2 =",['2','3','7','1','Ninguna de las anteriores'], 1, 2)
			@ex2 = Pregunta.new("5+7 =",['43','21','12','6','11'], 2, 2)
			@ex3 = Pregunta.new("Pregunta", ['a','b','c','d'], 3, 3)
			@ex4 = Pregunta.new("Pregunta a", ['Verdadero', 'Falso'], 0, 4)
			@ex5 = Pregunta.new("Pregunta b", ['Verdadero', 'Falso'], 1, 4)
			@ex6 = Pregunta.new("Pregunta c", ['Verdadero', 'Falso'], 0, 5)
			@nodo_prueba2 = Lista.new([@ex4, @ex5, @ex6])
			@nodo_prueba = Lista.new([@ex1, @ex2, @ex3])
			@nodo_final = Nodo.new(@ex3,nil)
		end

		it "Debe existir un nodo de la lista con sus datos y su siguiente" do
			expect(@nodo_prueba.cabeza[:value]).to eq(@ex1)
		end
		
		it "Se indica correctamente cual es el ultimo nodo de la lista" do
			expect(@nodo_prueba.final[:value]).to eq(@ex3)
		end
		
		it "Se puede acceder a los elementos anteriores" do
			expect(@nodo_prueba.get_anterior(0)).to eq(nil)
			expect(@nodo_prueba.get_anterior(1)).to eq(@ex1)
			expect(@nodo_prueba.get_anterior(2)).to eq(@ex2)
		end

		it "Se extrae el primer elemento de la lista" do
			
			@nodo_prueba.extraer_primero
			expect(@nodo_prueba).to eq (Lista.new([@ex2, @ex3]))
		end
		
		it "Se puede insertar un elemento" do
			@nodo_prueba.add([@ex1])
			expect(@nodo_prueba).to eq (Lista.new([@ex2, @ex3, @ex1]))
		end
	
		it "Se puede insertar varios elementos" do
			@nodo_prueba.add([@ex2, @ex2])
			expect(@nodo_prueba).to eq (Lista.new([@ex2, @ex3, @ex1, @ex2, @ex2]))
		end
		
		it "Se puede acceder a los elementos de la lista"do
			expect(@nodo_prueba[0]).to eq(@ex2)
			expect(@nodo_prueba[1]).to eq(@ex3)
			expect(@nodo_prueba[2]).to eq(@ex1)
			expect(@nodo_prueba[3]).to eq(@ex2)
			expect(@nodo_prueba[4]).to eq(@ex2)
			expect(@nodo_prueba[5]).to eq(nil)
		end
		
		
		it "Se puede recorrer la lista inversamente con el atributo previous de nodo" do
			expect(@nodo_prueba.recorrido_inverso).to eq (Lista.new([@ex2,@ex2,@ex1,@ex3,@ex2]))
			expect(@nodo_prueba2.recorrido_inverso).to eq (Lista.new([@ex6, @ex5, @ex4]))
		end

		it "Debe existir una Lista con su cabeza" do
			expect(@nodo_prueba.cabeza[:value]).to eq(@ex2)
		end
		
		it "Comprobacion del metodo to_s" do
			@nodo_prueba2.to_s == ("1)Pregunta a\n1. Verdadero\n2. Falso\n\n2)Pregunta b\n1. Verdadero\n2. Falso\n\n3)Pregunta c\n1. Verdadero\n2. Falso\n")
		end
		
		
		
		

end


describe Lista do


		before :all do
			@ex1 = Pregunta.new("¿Cual es la salida del siguiente codigo Ruby?\n\n\tclass Xyz\n\t\tdef pots\n\t\t\t@nice\n\t\tend\n\tend\n\n\txyz = Xyz.new\n\tp xyz.pots", ['#<Xyz:0xa000208>','nil','0','Ninguna de las anteriores'], 1, 5)
			@ex2 = Preguntasverdadero_falso.new("La siguiente definicion de un hash en Ruby es valida:\n\n\thash_raro = {\n\t\t[1,2,3] => Object.new(),\n\t\tHash.new => :toto\n\t}", 0, 2)
			@ex3 = Pregunta.new("¿Cual es la salida del siguiente codigo Ruby?\n\n\tclass Array\n\t\tdef say_hi\n\t\t\t\"HEY\"\n\t\tend\n\tend\n\n\n\tp [1,\"bob\"].say_hi", ['1', 'bob','HEY!','Ninguna de las anteriores'], 2, 9)
			@ex4 = Pregunta.new("¿Cual es el tipo de objeto en el siguiente codigo Ruby?\n\n\tclass Objeto\n\tend", ['Una instancia de la clase Class', 'Una constante', 'Un objeto', 'Ninguna de las anteriores'], 0, 6)
			@ex5 = Preguntasverdadero_falso.new("Es apropiado que una clase Tablero herede de una clase Juego", 0, 4)
			@nodo_prueba = Lista.new([@ex1,@ex2,@ex3,@ex4,@ex5])
		end
		
		
		it "Se comprueba la estructura de la lista" do
			expect(@nodo_prueba).to eq(Lista.new([@ex1,@ex2,@ex3,@ex4,@ex5]))
			#puts @nodo_prueba
		end
		
		
		#METODOS DEL MIX-IN ENUMERABLE
		
		it "Se cuentan el numero de preguntas de un examen" do
			expect(@nodo_prueba.count).to eq(5)
			expect(@nodo_prueba.map{|i| i}).to eq([@ex1,@ex2,@ex3,@ex4,@ex5])
			expect(@nodo_prueba.max).to eq(@ex3)
			expect(@nodo_prueba.min).to eq(@ex2)
			expect(@nodo_prueba.sort).to eq([@ex2, @ex5, @ex1, @ex4, @ex3])
		end
	
end

describe Examen do
		before :all do
			@p1 = Pregunta.new("¿Cual es la salida del siguiente codigo Ruby?\n\n\tclass Xyz\n\t\tdef pots\n\t\t\t@nice\n\t\tend\n\tend\n\n\txyz = Xyz.new\n\tp xyz.pots", ['#<Xyz:0xa000208>','nil','0','Ninguna de las anteriores'], 1, 5)
			@p2 = Preguntasverdadero_falso.new("La siguiente definicion de un hash en Ruby es valida:\n\n\thash_raro = {\n\t\t[1,2,3] => Object.new(),\n\t\tHash.new => :toto\n\t}", 0, 2)
			@p3 = Pregunta.new("¿Cual es la salida del siguiente codigo Ruby?\n\n\tclass Array\n\t\tdef say_hi\n\t\t\t\"HEY\"\n\t\tend\n\tend\n\n\n\tp [1,\"bob\"].say_hi", ['1', 'bob','HEY!','Ninguna de las anteriores'], 2, 9)
			@p4 = Pregunta.new("¿Cual es el tipo de objeto en el siguiente codigo Ruby?\n\n\tclass Objeto\n\tend", ['Una instancia de la clase Class', 'Una constante', 'Un objeto', 'Ninguna de las anteriores'], 0, 6)
			@p5 = Preguntasverdadero_falso.new("Es apropiado que una clase Tablero herede de una clase Juego", 0, 4)
			
			@p6 = Pregunta.new("¿Cual es la capital de España?",['Francia', 'Lisboa', 'Madrid', 'Berlín'], 2, 1)
			@p7 = Pregunta.new("72^4 = ¿?", ['576895', '26873856', '34393487', '984737642'], 1, 8)
			@p8 = Preguntasverdadero_falso.new("Cualquier número elevado a 0 es igual a 1", 0, 2)

			@lista = Lista.new([@p1,@p2,@p3,@p4,@p5])
			@lista2 = Lista.new([@p6,@p7,@p8])

			@examen = Examen.new('Examen_1', @lista)
			@examen2 = Examen.new('Examen_2', @lista2)
		end

		it "El examen posee un nombre o identificador" do
			expect(@examen.id).to eq('Examen_1')
			expect(@examen.id).not_to eq('Un nombre cuaquiera') 
			expect(@examen2.id).not_to eq('Otro nombre')
			expect(@examen2.id).to eq('Examen_2')
		end

		it "El examen posee una Lista de preguntas" do
			expect(@examen.lista).to eq(@lista)
			expect(@examen2.lista).to eq(@lista2)
		end

		it "El examen posee una plantilla de respuestas" do
			expect(@examen.plantilla).to eq([1,0,2,0,0])
			expect(@examen.plantilla).not_to eq([1,0,3,0,0])
			expect(@examen2.plantilla).to eq([2,1,0])
		end
		
		it "Comprobamos que el calculo de la dificultad de un examen se realiza de forma correcta" do
			expect(@examen.dificultad_examen).to eq(5)
			expect(@examen2.dificultad_examen).to eq(3)
		end

		it "Se comrpueba que la respuesta dada es correcta para una pregunta determinada" do
			expect(@examen.comprobar_respuesta(0,1)).to eq(true)
			expect(@examen.comprobar_respuesta(2,3)).to eq(false)
			expect(@examen2.comprobar_respuesta(0,1)).to eq(false)
			expect(@examen2.comprobar_respuesta(2,0)).to eq(true)
		end

		it "Comprobando funcionamiento de la funcion reset" do
			@examen.reset()
			@examen2.reset()
			expect(@examen.respuestas_correctas).to eq(0)
			expect(@examen.respuestas_erroneas).to eq(0)
			expect(@examen2.respuestas_correctas).to eq(0)
			expect(@examen2.respuestas_erroneas).to eq(0)
		end
		
		
		it "Comprobamos que la funcion invertir devuelve un bloque" do
			(@examen.invertir).is_a? Proc
		end

		it "Comprobamos que el proc devuelto en invertir hace que se invierta el examen" do
			expect(@examen.invertir.call).to eq(Lista.new([@p5,@p4,@p3,@p2,@p1]))
		end
		
		
	

		
		
end

describe Interfaz do

		before :all do
			@p1 = Pregunta.new("¿Cual es la salida del siguiente codigo Ruby?\n\n\tclass Xyz\n\t\tdef pots\n\t\t\t@nice\n\t\tend\n\tend\n\n\txyz = Xyz.new\n\tp xyz.pots", ['#<Xyz:0xa000208>','nil','0','Ninguna de las anteriores'], 1, 5)
			@p2 = Preguntasverdadero_falso.new("La siguiente definicion de un hash en Ruby es valida:\n\n\thash_raro = {\n\t\t[1,2,3] => Object.new(),\n\t\tHash.new => :toto\n\t}", 0, 2)
			@p3 = Pregunta.new("¿Cual es la salida del siguiente codigo Ruby?\n\n\tclass Array\n\t\tdef say_hi\n\t\t\t\"HEY\"\n\t\tend\n\tend\n\n\n\tp [1,\"bob\"].say_hi", ['1', 'bob','HEY!','Ninguna de las anteriores'], 2, 9)
			@p4 = Pregunta.new("¿Cual es el tipo de objeto en el siguiente codigo Ruby?\n\n\tclass Objeto\n\tend", ['Una instancia de la clase Class', 'Una constante', 'Un objeto', 'Ninguna de las anteriores'], 0, 6)
			@p5 = Preguntasverdadero_falso.new("Es apropiado que una clase Tablero herede de una clase Juego", 0, 4)
			
			@p6 = Pregunta.new("¿Cual es la capital de España?",['Francia', 'Lisboa', 'Madrid', 'Berlín'], 2, 1)
			@p7 = Pregunta.new("72^4 = ¿?", ['576895', '26873856', '34393487', '984737642'], 1, 8)
			@p8 = Preguntasverdadero_falso.new("Cualquier número elevado a 0 es igual a 1", 0, 2)

			@lista = Lista.new([@p1,@p2,@p3,@p4,@p5])
			@lista2 = Lista.new([@p6,@p7,@p8])

			@examen = Examen.new('Examen_1', @lista)
			@examen2 = Examen.new('Examen_2', @lista2)

			@interfaz = Interfaz.new([@examen, @examen2])
			@interfaz.seleccion_menu = 1
			@interfaz.examen_seleccionado = 0
		end

		it "La interfaz posee un conjunto de examenes" do
			expect(@interfaz.examenes).to eq ([@examen, @examen2])
		end
		
		it "Se muestra el menu correctamente" do
			expect(@interfaz.showmenu).to eq (["Opcion 1. Cargar examen.\nOpcion 2. Resolver examen\nOpcion 3. Ver dificultad de examen\nOpcion 4. Invertir examen cargado.\nOpcion 5. Salir."])
		end
		
		it "Se comprueba que la opcion elegida por el usuario se almacena correctamente" do
			expect(@interfaz.seleccion_menu).to eq(1)
		end
		
		it "Se comprueba que el indice de examen seleccionado por el usuario se almacena correctamente" do
			expect(@interfaz.examen_seleccionado).to eq(0)
		end
		
		it "Se muestra el primer submenu correctamente" do
			expect(@interfaz.opcion1).to eq ("\n\nSeleccione el examen que desee cargar\n1. Examen_1\n2. Examen_2\n")
		end
		
		it "Se comprueba que se devuelve string con dificultad del examen cargado" do
			expect(@interfaz.opcion3).to eq("La dificultad del examen cargado es: 5")
		end

		it "Se comprueba que el resultado mostrado es el correcto" do
			expect(@interfaz.mostrar_resultado).to eq("\n\nResultado final:\n\n\tRespuestas correctas: 0\n\tRespuestas incorrectas: 0\n\n")
		end

		it "Se comprueba que se carga correctamente el examen deseado" do
			expect(@interfaz.cargar_examen(1)).to eq(1)
			expect(@interfaz.cargar_examen(0)).to eq(0)
		end

		it "Se muestran las preguntas especificadas" do
			expect(@interfaz.mostrar_pregunta(@examen2, 0)).to eq("¿Cual es la capital de España?\n1. Francia\n2. Lisboa\n3. Madrid\n4. Berlín\n")
			expect(@interfaz.mostrar_pregunta(@examen2, 1)).to eq("72^4 = ¿?\n1. 576895\n2. 26873856\n3. 34393487\n4. 984737642\n")
			expect(@interfaz.mostrar_pregunta(@examen2, 2)).to eq("Cualquier número elevado a 0 es igual a 1\n1. Verdadero\n2. Falso\n")
		end

		it "Se indica al usuario si la pregunta ha sido respondida correctamente o no" do
			expect(@interfaz.corregir_pregunta(@examen, 0, 2)).to eq("\nRespuesta Correcta.\n")
			expect(@interfaz.corregir_pregunta(@examen, 1, 2)).to eq("\nRespuesta Incorrecta.\n")
		end

		it "Se pueden resetear los examenes realizados" do
			@interfaz.reset #Se resetean los resultados obtenidos de los examenes.
			expect(@interfaz.examenes[0].respuestas_correctas).to eq(0)
			expect(@interfaz.examenes[0].respuestas_erroneas).to eq(0)
			expect(@interfaz.examenes[1].respuestas_correctas).to eq(0)
			expect(@interfaz.examenes[1].respuestas_erroneas).to eq(0)
		end
		
		it"Se ejecuta la simulación de un examen" do
			
			expect(@interfaz.ejecucion_debug(0)).to eq(true)
			expect(@interfaz.ejecucion_debug(1)).to eq(true)
			#@interfaz.menu
		end

		it "Se pueden invertir pasando un bloque mediante la funcion invertir" do
			expect(@interfaz.invertir(@examen.invertir)). to eq(Lista.new([@p5,@p4,@p3,@p2,@p1]))
		end
		
end

