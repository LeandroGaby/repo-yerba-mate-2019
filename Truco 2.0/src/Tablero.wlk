/*
 * FALTA
 * 
 * VARIANTES DEL TRUCO Y ENVIDO
 */

class Cartas 
{
    var property valor 
    var property numero
    var property palo
        
    constructor(_numero, _palo, _valor){
		numero = _numero
		palo = _palo
		valor = _valor
	}
	
	method valorEnvido()
	{
		if (numero >= 10)
			return 0
		else
			return numero
	}
	
	method nombre()
	{ return("" + numero + " de " + palo) }
}

class Jugador
{
	var property cartasEnMano = []
	var property cartaJugada
	var property mano
	var property miTurno
	var property nombre 
	var property numero
	var property puntaje = 0
	var property rondasGanadas = 0
	var property cantidadEnvido
	var property tengoFlor = false
	
	constructor(_nombre, _numero, _mano)
	{
		nombre = _nombre
		numero = _numero
		mano = _mano
		miTurno = _mano
	}
	
	method jugarCartaAlAzar()
	{
		var carta = cartasEnMano.anyOne()
		cartasEnMano.remove(carta)
		cartaJugada = carta
		console.println("" + self.nombre() + " Jugó: " + carta.nombre())
		mesa.cambiarTurno()
	}
	
	method rotarMano()
	{ 
		mano = not mano
    	miTurno = mano
		return mano
	}
	
	method rotarTurno()
	{ 
		miTurno = not miTurno
		return miTurno
	}
	
	method modificarMiTurno(trueORfalse)
	{ 
		miTurno = trueORfalse
		return miTurno
	}
	
	method puntosGanados(num)
	{ puntaje += num }
	
	method calcularEnvido()
    {
    	if (cartasEnMano.size() == 3)
    	{
    		var cartasIguales = []
			if ( cartasEnMano.filter({ cartas => cartas.palo() == "Espada" }).size() >= 2 )
				cartasIguales = cartasEnMano.filter({ cartas => cartas.palo() == "Espada" })
			if ( cartasEnMano.filter({ cartas => cartas.palo() == "Basto" }).size() >= 2 )
				cartasIguales = cartasEnMano.filter({ cartas => cartas.palo() == "Basto" })
			if ( cartasEnMano.filter({ cartas => cartas.palo() == "Oro" }).size() >= 2 )
				cartasIguales = cartasEnMano.filter({ cartas => cartas.palo() == "Oro" })                                
			if ( cartasEnMano.filter({ cartas => cartas.palo() == "Copa" }).size() >= 2 )
				cartasIguales = cartasEnMano.filter({ cartas => cartas.palo() == "Copa" })
			
	    	if (cartasIguales.size() == 3)
	    		tengoFlor = true
	     	if (cartasIguales.size() >= 2)
	     		cantidadEnvido = cartasIguales.map({carta => carta.valorEnvido()}).sum() + 20
	    	if (cartasIguales.size() == 0)
	    	{
	 	    	cantidadEnvido = cartasEnMano.max({carta => carta.valorEnvido()}).valorEnvido()
	 	    }
		}
    	return cantidadEnvido
    }
   
    method verMazo()
    { console.println(cartasEnMano.map({carta => carta.nombre()})) }
    
    method reiniciarValoresJugador()
    {
    	if (mesa.trucoEnJuego() == true and rondasGanadas == 2)
    	{ self.puntosGanados(2) }
    	else
    		if (rondasGanadas == 2)
    		{ self.puntosGanados(1) }
    	cartasEnMano.removeAll(cartasEnMano)	
    	self.rotarMano()
    	tengoFlor = false
    	rondasGanadas = 0
    }
	
	method borrarCartas()
	{ cartasEnMano.removeAll(cartasEnMano) }
	
	method rondaGanada() 
	{ rondasGanadas += 1 }
	
	method agarrarCarta(carta) 
	{ cartasEnMano.add(carta) }
	
	method jugarCarta(num, palo)
	{
		var carta = cartasEnMano.find({carta => carta.numero() == num and carta.palo() == palo })
		cartasEnMano.remove(carta)
		cartaJugada = carta
		console.println("" + self.nombre() + " Jugó: " + carta.nombre())
		mesa.cambiarTurno()
	}
	
	method existenciaJugador(num)
	{ return (self.numero() == num) }
}

object mesa{
	
	var property mazo = []
	var property jugadores = []
	var property ronda = 1
	var property turno = 1
	var property vuelta = 1
	var property juegoActivo = false
	var property envidoActivo = false
	var property trucoActivo = false
	var property puntosTruco = 0
	var property trucoEnJuego = false
	var property puntosParaGanar = 15
	var property turnoGuardado
	/* METODOS DISPONIBLES PARA EL USUARIO */
	
	
	method ayuda()
	{
		console.println("Comandos utiles para el usuario:
- mesa.ayuda()
- mesa.iniciarJuego()
- mesa.reiniciarJuego()
- mesa.agregarJugador(nombre)
- mesa.borrarJugador(nombre)
- mesa.verJugadores()
- mesa.verMazo()
- mesa.jugarCarta(numero, palo)")
	}
	
	method iniciarJuego()
	{
		self.agregarJugador("Lucas") // Borrar
		self.agregarJugador("Alemanco") // Borrar
		if(not juegoActivo){
			if (jugadores.size() == 2){
				juegoActivo = true
				vuelta = 1
				ronda = 1
				turno = 1
				self.reiniciarValoresMesa()
				console.println("Juego Iniciado.")
			}
			else
				console.println("Se necesitan dos jugadores para comenzar a jugar.")
		}
		else
			console.println("El juego ya se inicio previamente.")
	}
	
	method reiniciarJuego()
	{
		if(juegoActivo){
			juegoActivo = false
			self.reiniciarValoresJugadores()
			jugadores.removeAll(jugadores) /* Eliminar, sirve para testear en fase de desarrollo */
			console.println("Juego Reiniciado, los jugadores se mantienen.")
			self.iniciarJuego()
		}
		else console.println("No es posible reiniciar si todavia no se inicio el juego.")
	}
	
	method borrarJugador(jugador){ 
		if(not juegoActivo){
			if (self.seleccionarJugador(1).nombre() == jugador){
				jugadores.remove(self.seleccionarJugador(1))
				console.println("Realizado con exito.")
			}
			else{
				if (self.seleccionarJugador(2).nombre() == jugador){
					jugadores.remove(self.seleccionarJugador(2))
					console.println("Realizado con exito.")
				}
				else{
					console.println("El nombre ingresado es incorrecto.")
				}		
			}
		}
		else
		console.println("No es posible realizar esta accion en mitad de la partida.")
	}
	
	method agregarJugador(jugador){ 
		if(jugadores.size() < 2){
			if( not jugadores.any({jugadore => jugadore.existenciaJugador(1)}) )
			{
				jugadores.add(new Jugador(jugador,1,true))
				console.println("Realizado con exito.")
			}
			else{
				jugadores.add(new Jugador(jugador,2,false))
				console.println("Realizado con exito.")
			}
		}
		else
			console.println("Solo pueden anotarse 2 jugadores.")
	}
	
	method jugarCarta(num, palo)
	{ 
		if (not envidoActivo and not trucoActivo)
			self.seleccionarJugador(self.buscarJugadorTurno()).jugarCarta(num, palo)
		else
			console.println("Tenes que responder")
	}
	
	method jugarCartaAlAzar()
	{
		if (not envidoActivo and not trucoActivo)
			self.seleccionarJugador(self.buscarJugadorTurno()).jugarCartaAlAzar()
		else
			console.println("Tenes que responder")
	}
	
	method verJugadores()
	{
		if(jugadores.size() == 2)
			console.println( "Jugador 1: " + self.seleccionarJugador(1).nombre() + "
Jugador 2: " + self.seleccionarJugador(2).nombre() ) 
	 	else
		console.println("Jugador:" + jugadores.anyOne().nombre())
	}
	
	method envido()
	{
		if(ronda == 1)
		{
			envidoActivo = true
			console.println(self.seleccionarJugador(self.buscarJugadorTurno()).nombre() + ": Te canto envido")
			turnoGuardado = turno
			self.cambiarTurno()
		}
		else
			console.println("Ya no se puede cantar el envido.")
	}
	
	method truco()
	{
		if (not envidoActivo)
		{
			trucoActivo = true
			console.println(self.seleccionarJugador(self.buscarJugadorTurno()).nombre() + ": Te canto truco")
			turnoGuardado = turno
			self.cambiarTurno()
		}
		else
			console.println("Tenes que responder primero al envido.")
	}
	
	method quiero()
	{
		if (envidoActivo)
		{
			console.println(self.seleccionarJugador(self.buscarJugadorTurno()).nombre() + ": Quiero!")
			self.confrontacionEnvido()
			self.cambiarTurno()
			envidoActivo = false
		}
		if (trucoActivo)
		{
			console.println(self.seleccionarJugador(self.buscarJugadorTurno()).nombre() + ": Quiero!")
			self.cambiarTurno()
			trucoActivo = false
			trucoEnJuego = true
		}
	}
	
	method noQuiero()
	{
		if (envidoActivo)
		{
			console.println(self.seleccionarJugador(self.buscarJugadorTurno()).nombre() + ": No quiero!")
			self.seleccionarJugador(turnoGuardado).puntosGanados(1)
			self.cambiarTurno()
			envidoActivo = false
		}
		if (trucoActivo)
		{
			console.println(self.seleccionarJugador(self.buscarJugadorTurno()).nombre() + ": No quiero!")
			trucoActivo = false
			trucoEnJuego = false
			self.seleccionarJugador(turnoGuardado).rondaGanada()
			self.seleccionarJugador(turnoGuardado).rondaGanada()
			self.cambiarRonda()
		}
	}
	
	method verMazo()
	{ self.seleccionarJugador(self.buscarJugadorTurno()).verMazo() }
	
	method verInfo()
	{ console.println("Ronda " + ronda + " | Turno " + turno + " // " + self.seleccionarJugador(self.buscarJugadorTurno()).nombre()) }
	
	
	
	/* METODOS DEL SISTEMA */
	
	
	
	method verPuntajes()
	{
		console.println("Puntajes:")
		console.println(self.seleccionarJugador(1).nombre() + ": " + self.seleccionarJugador(1).puntaje() + " puntos")
		console.println(self.seleccionarJugador(2).nombre() + ": " + self.seleccionarJugador(2).puntaje() + " puntos")
	}
	
	method buscarJugadorTurno()
	{ return jugadores.find({ jugador => jugador.miTurno() == true }).numero() }
	
	method seleccionarJugador(num)
	{ return jugadores.find({jugador => jugador.numero() == num}) }
	
	method asignarEnvido()
	{ jugadores.map({jugador => jugador.calcularEnvido()}) }
	
	method compararCartas()
	{
		var carta1 = self.seleccionarJugador(1).cartaJugada().valor()
		var carta2 = self.seleccionarJugador(2).cartaJugada().valor()
		var jugadorGanador
		
		if (carta1 == carta2)
    	{
    		self.seleccionarJugador(1).rondaGanada()
            self.seleccionarJugador(2).rondaGanada()
    		console.println("Parda")
    		jugadorGanador = jugadores.find({jugador => jugador.mano() == true})
    	}
    	if (carta1 > carta2)
    	{
    		self.seleccionarJugador(1).rondaGanada()
   			jugadorGanador = self.seleccionarJugador(1)
    	console.println("Gana " + jugadorGanador.nombre())
   		}
    	if (carta1 < carta2)
    	{
    		self.seleccionarJugador(2).rondaGanada()
    		jugadorGanador = self.seleccionarJugador(2)
    	console.println("Gana " + jugadorGanador.nombre())
    	}
    	if (not jugadorGanador.miTurno())
    	{
    		var jugadorPerdedor = jugadores.find({jugador => jugador.miTurno() == true})
    		jugadorPerdedor.modificarMiTurno(false) 
    	}
    	return jugadorGanador	
	}
	
	method cambiarRonda()
	{
		if (ronda < 3)
			ronda += 1
		if (jugadores.any({jugador => jugador.rondasGanadas() >= 2}))
		{
			ronda = 1
			self.cambiarVuelta()
		}
	}	
	
	method cambiarTurno()
	{
		if (envidoActivo or trucoActivo)
		{
			if (turno == 1)
			{
				jugadores.map({jugador => jugador.rotarTurno()})
				turno += 1
			}
			else
			{
				jugadores.map({jugador => jugador.rotarTurno()})
				turno -= 1
			}
		}
		else
		{
			if (turno == 1)
			{
				jugadores.map({jugador => jugador.rotarTurno()})
				turno += 1
			}
			else
			{
				self.compararCartas().modificarMiTurno(true)
				turno -= 1
				self.cambiarRonda()
			}
		}
	}
	
	method cambiarVuelta()
	{
		if(jugadores.any({jugador => jugador.puntaje() >= puntosParaGanar }))
		{
			var fin = jugadores.find({jugador => jugador.puntaje() >= puntosParaGanar })
			console.println("Termino la partida! Gano " + fin.nombre())
			self.reiniciarJuego()
		}
		else
		{
			console.println("Esta vuelta la gano: " + jugadores.find({jugador => jugador.rondasGanadas() >= 2}).nombre())
			console.println("Vuelta " + vuelta + " Terminada")
			self.reiniciarValoresJugadores()
			self.verPuntajes()
			self.reiniciarValoresMesa()
			vuelta += 1
			console.println("Vuelta " + vuelta + " comenzada")
		}
	}
	
	method reiniciarValoresMesa() 
	{ 
		trucoEnJuego = false
		trucoActivo = false
		envidoActivo = false
		console.println("Barajando...")
		self.rellenarMazo()
		self.repartirCartas()
		self.asignarEnvido()
	}
	
	method reiniciarValoresJugadores() 
	{ (1..2).forEach({x => self.seleccionarJugador(x).reiniciarValoresJugador()}) }
	
	method obtenerCartaDelMazo(){
		const carta = mazo.anyOne()
		mazo.remove(carta)
		return carta
	}
	 
	method repartirCartas(){
		(1 .. 2).forEach({
			numerojugador =>
				(1 .. 3).forEach({ 
					x => jugadores.find({jugador => jugador.numero() == numerojugador}).agarrarCarta(self.obtenerCartaDelMazo()) }) })
	}
	
	method confrontacionEnvido()
	{
		var jugadorGanador
		if (self.seleccionarJugador(1).cantidadEnvido() == self.seleccionarJugador(2).cantidadEnvido())
			jugadorGanador = jugadores.find({jugador => jugador.mano() == true})
		else
			jugadorGanador = jugadores.max({jugador => jugador.cantidadEnvido()})
		console.println("Gano el Jugador: " + jugadorGanador.nombre())
		jugadorGanador.puntosGanados(2)
	}
	
	
	
	
	
	method rellenarMazo(){
		
		var palo
		
		/* x => Numero De Carta
		   y => Valor De Carta
		 
		   Cartas del 2 al 6 */
		(2 .. 6).forEach({ 
			x => (1 .. 4).forEach({ 
				y => if(y==1){ palo= "Espada" }
					 if(y==2){ palo= "Basto" }
				 	 if(y==3){ palo= "Oro" }
					 if(y==4){ palo= "Copa" }
					mazo.add(new Cartas(x,palo,if(x==2 or x==3){x+7}else{x-3})) 
				})
		})
	
		/*Carta 1*/
		(1 .. 4).forEach({ 
			y => if(y==1){ palo= "Espada" }
				 if(y==2){ palo= "Basto" }
				 if(y==3){ palo= "Oro" }
				 if(y==4){ palo= "Copa" }
				mazo.add(new Cartas(1,palo,if(y==1){14} else {if(y==2){13}else{8}}
				)) 
		})
		
		/*Carta 7*/
		(1 .. 4).forEach({ 
			y => if(y==1){ palo= "Espada" }
				 if(y==2){ palo= "Basto" }
				 if(y==3){ palo= "Oro" }
				 if(y==4){ palo= "Copa" }
				mazo.add(new Cartas(7,palo,if(y==1){12} else {if(y==3){11}else{4}}
				)) 
		})
		
			
		/*Cartas del 10 al 12 */
		(10 .. 12).forEach({ 
			x => (1 .. 4).forEach({ 
				y => if(y==1){ palo= "Espada" }
				 	 if(y==2){ palo= "Basto" }
					 if(y==3){ palo= "Oro" }
					 if(y==4){ palo= "Copa" }
					mazo.add(new Cartas(x,palo,x-5)) 
			})
		})
	}		
}
