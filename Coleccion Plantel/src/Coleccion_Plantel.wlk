object plantilla
{
	const plantel = #{jugador1, jugador2, jugador3, jugador4, jugador5, jugador6, jugador7, jugador8, jugador9, jugador10}
	const titulares = #{jugador1, jugador2, jugador3, jugador4, jugador5}
	const suplentes = #{jugador6, jugador7, jugador8}
	const reserva = #{jugador9, jugador10}
	
	method Jugar_Partido()
	{
		if (self.Disponibilidad_Equipo())
		{
			return "Partido jugado con exito"
		}
		else
		{
			return "No se tiene el numero necesario (5) para jugar"
		}
	}
	
	method Ver_Plantel()
	{
		return plantel
	}
	method Ver_Titulares()
	{
		return titulares
	}
	method Ver_Suplentes()
	{
		return suplentes
	}
	method Ver_Reserva()
	{
		return reserva
	}
	
	method Agregar_Titular(jugador)
	{
		if (not jugador.Estado_Lesion())
		{
			suplentes.remove(jugador)
			reserva.remove(jugador)
			titulares.add(jugador)
			return jugador.Nombre() + " Agregado a Titulares"
		}
		else
		{
			return jugador.Nombre() + " no esta disponible"
		}
	}
	
	method Agregar_Suplente(jugador)
	{
		
		if (not jugador.Estado_Lesion())
		{
			suplentes.add(jugador)
			reserva.remove(jugador)
			titulares.remove(jugador)
			return jugador.Nombre() + " Agregado a Suplentes"
		}
		else
		{
			return jugador.Nombre() + " no esta disponible"
		}
	}
	
	method Agregar_Reserva(jugador)
	{
		suplentes.remove(jugador)
		reserva.add(jugador)
		titulares.remove(jugador)
		return jugador.Nombre() + " Agregado a Reserva"
	}
	
	method Disponibilidad_Equipo()
	{
		if(jugador1.Estado_Lesion())
		{
			titulares.remove(jugador1)
			suplentes.remove(jugador1)
			reserva.add(jugador1)
		}
		if(jugador2.Estado_Lesion())
		{
			titulares.remove(jugador2)
			suplentes.remove(jugador2)
			reserva.add(jugador2)
		}
		if(jugador3.Estado_Lesion())
		{
			titulares.remove(jugador3)
			suplentes.remove(jugador3)
			reserva.add(jugador3)
		}
		if(jugador4.Estado_Lesion())
		{
			titulares.remove(jugador4)
			suplentes.remove(jugador4)
			reserva.add(jugador4)
		}
		if(jugador5.Estado_Lesion())
		{
			titulares.remove(jugador5)
			suplentes.remove(jugador5)
			reserva.add(jugador5)
		}
		if(jugador6.Estado_Lesion())
		{
			titulares.remove(jugador6)
			suplentes.remove(jugador6)
			reserva.add(jugador6)
		}
		if(jugador7.Estado_Lesion())
		{
			titulares.remove(jugador7)
			suplentes.remove(jugador7)
			reserva.add(jugador7)
		}
		if(jugador8.Estado_Lesion())
		{
			titulares.remove(jugador8)
			suplentes.remove(jugador8)
			reserva.add(jugador8)
		}
		if(jugador9.Estado_Lesion())
		{
			titulares.remove(jugador9)
			suplentes.remove(jugador9)
			reserva.add(jugador9)
		}
		if(jugador10.Estado_Lesion())
		{
			titulares.remove(jugador10)
			suplentes.remove(jugador10)
			reserva.add(jugador10)
		}
		return titulares.sum()==5
	}
}

object jugador1
{
	var apellido = "Mejia"
	var nombre = "Pepito"
	
	var lesion = false
	var dorsal = 1
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador2
{
	var apellido = "Armando"
	var nombre = "Raul"
	
	var lesion = false
	var dorsal = 2
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador3
{
	var apellido = "Benitez"
	var nombre = "Lucho"
	
	var lesion = false
	var dorsal = 3
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador4
{
	var apellido = "Vargas"
	var nombre = "Pablo"
	
	var lesion = false
	var dorsal = 4
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador5
{
	var apellido = "Cruz"
	var nombre = "Tomas"
	
	var lesion = false
	var dorsal = 5
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador6
{
	var apellido = "Villalba"
	var nombre = "Mateo"
	
	var lesion = false
	var dorsal = 6
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador7
{
	var apellido = "Paez"
	var nombre = "Francisco"
	
	var lesion = false
	var dorsal = 7
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador8
{
	var apellido = "Mejia"
	var nombre = "Pepito"
	
	var lesion = false
	var dorsal = 8
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador9
{
	var apellido = "Gonzales"
	var nombre = "Gaston"
	
	var lesion = false
	var dorsal = 9
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}
object jugador10
{
	var apellido = "Fernandez"
	var nombre = "Gullermo"
	
	var lesion = false
	var dorsal = 10
	
	method Estado_Lesion()
	{
		return lesion
	}
	method Lesion()
	{
		lesion = true
		return self.Nombre() + " se Lesiono"
	}
	method recuperacion()
	{
		lesion = false
		return self.Nombre() + " se Recupero"
	}
	method Nombre()
	{
		return nombre + " " + apellido
	}
}










