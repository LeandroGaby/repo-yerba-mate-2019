object colectivo
{
	// ESCENARIO A MODIFICAR //
	const maxpers    = 50
	//const minpers    = 0
	const maxcomb    = 90
	const tarifa     = 20
	const tarifaesp  = 5
	//const mindinero  = 0
	const norte      = 1 
	const sur        = 0
	const costcomb   = 2
	//const mintanque  = 0
	
	const terminalA  = 0
	const parada1    = 1
	//const parada2    = 2
	//const parada3    = 3
	const parada4    = 4
	const terminalB  = 5
	
	var pers       = 0
	var comb       = 90
	var dinero     = 0
	//var tanque     = 90
	var parada     = terminalA
	var direccion  = norte
	
	
	method cambiar_direccion()
	{
		if (direccion == norte)
		{
			direccion = sur
		}
		else
		{
			direccion = norte
		}
	}
	
	method comprobar_direccion()
	{
		if (direccion == norte)
		{
			return "Direccion: Norte"
		}
		else
		{
			return "Direccion: Sur"	
		}
	}
	method siguiente_parada()
	{
		var consumocomb = 10 + (0.2 * pers)
		
		if (comb >= consumocomb)
		{
			self.consumir_combustible(consumocomb)
			if (parada > terminalA && direccion == sur)
			{
				parada -= 1
			}
			if (parada < terminalB && direccion == norte)
			{
				parada += 1
			}
			
			if (parada == terminalA && direccion == sur)
			{
				var bajaron = pers
				pers -= bajaron
				personas.recorridoterminado()
				return "Recorrido Completado! Todas las personas han bajado del colectivo(" + bajaron + " personas). Sobraron " + comb + "L de combustible. Hemos recaudado $" + dinero
			}
			else
			{
				if (parada == terminalB)
				{
					self.cambiar_direccion()
					return "Ahora nos encontramos en la Terminal B. Posees " + comb + "L de combustible. Aqui podemos cargar combustible"
				}
				else
				{
					return "Ahora nos encontramos en la parada " + parada + ". Posees " + comb + "L de combustible."
				}		
			}
		}
		
		else
		{
			return "Combustible insuficiente, posees " + comb + "L de " + consumocomb + "L. necesarios para hacer 1 parada mas."
		}
	}
	
		
	method bajar_personas()
	{
		var bajaron = personas.bajar(parada)
		pers -= bajaron
		return "Bajaron " + bajaron + " personas."
	}
	
	method subir_personas(cantidad, destino)
	{
		if (destino >= 0 && destino <= 5)
		{
			var sequedan = self.consultar_espacio(cantidad)
			var subieron = cantidad - sequedan
			paradas.sequedan(sequedan, parada)
			personas.suben(subieron, destino)
			self.tarifa(subieron, destino)
			pers += subieron
			return "Subieron " + subieron + " personas."
		}
		else
		 return "Suba en una parada disponible (1-5), o Ingrese un destino valido (0-5)"
	}
	
	method consultar_espacio(cant_personas)
	{
		var espaciodisponible = maxpers - pers
		var sequedan
		if (cant_personas - espaciodisponible >= 0)
		{
			sequedan = cant_personas - espaciodisponible
			return sequedan
		}
		else
		{
			sequedan = 0
			return sequedan
		}
	}
	
	method tarifa(cant_personas, destino)
	{
		if (parada == parada4 && destino == terminalB && direccion == norte || parada == parada1 && destino == terminalA && direccion == sur )
		{
			dinero += tarifaesp * cant_personas
		}
		else
		{
			dinero += tarifa * cant_personas
		}
	}
	
	method consultar_dinero()
	{
		return "Tenemos $" + dinero
	}
	
	method consumir_combustible(cantidad)
	{
		comb-=cantidad
	}
	method cargar_combustible(cantidad)
	{
		if (parada == terminalB)
		{
			var cant = maxcomb - comb
			if (cantidad >= cant)
			{
				var costototal = costcomb * cant
			}	
			else
			{
				var costototal = costcomb * cantidad
			}
			
			if (dinero >= costototal)
			{
				if (cantidad >= cant)
				{
					comb += cant
					dinero -= costototal
					return "Se han cargado " + cant	+ "L. Posees el tanque lleno: " + comb + "L."
				}
				else
				{
					comb += cantidad
					dinero -= costototal
					return "Se han cargado " + cantidad	+ "L. Posees " + comb + "L. de combustible en el tanque"
				}
			}
			else
			{
				return "No te alcanza el dinero"
			}
		}
		else
		{
			return "Necesitas estar en la Terminal B para cargar combustible"
		}
	}
}

object personas
{
	const terminalA = 0
	const parada1 = 1
	const parada2 = 2
	const parada3 = 3
	const parada4 = 4
	const terminalB = 5
	
	// VARIABLES PARA GENTE LLENDO A TAL PARADA
	var llendoterminalA = 0
	var llendoparada1 = 0
	var llendoparada2 = 0
	var llendoparada3 = 0
	var llendoparada4 = 0
	var llendoterminalB = 0
	
	
	
	method suben(cantpers, destino)
	{
		if (destino == parada1)
		{
			llendoparada1 += cantpers
		}
		if (destino == parada2)
		{
			llendoparada2 += cantpers
		}
		if (destino == parada3)
		{
			llendoparada3 += cantpers
		}
		if (destino == parada4)
		{
			llendoparada4 += cantpers
		}
		if (destino == terminalB)
		{
			llendoterminalB += cantpers
		}	
	}
	
	method bajar(destino)
	{
		if (destino == terminalA)
		{
			var bajan = llendoterminalA
			llendoterminalA = 0
			return bajan
		}
		if (destino == parada1)
		{
			var bajan = llendoparada1
			llendoparada1 = 0
			return bajan
		}
		if (destino == parada2)
		{
			var bajan = llendoparada2
			llendoparada2 = 0
			return bajan
		}
		if (destino == parada3)
		{
			var bajan = llendoparada3
			llendoparada3 = 0
			return bajan
		}
		if (destino == parada4)
		{
			var bajan = llendoparada4
			llendoparada4 = 0
			return bajan
		}
		if (destino == terminalB)
		{
			var bajan = llendoterminalB
			llendoterminalB = 0
			return bajan
		}
		else 
			return "Si lees esto dentro de la consola es que estas toqueteando nuestro codigo para llegar a una parada que todavia no esta programada, ASI QUE FUERA! >:/ ... ... ... ¿Seguis aca? FUERA BICHO!!!!"
	}
	
	method recorridoterminado()
	{
		llendoterminalA = 0
		llendoparada1 = 0
		llendoparada2 = 0
		llendoparada3 = 0
		llendoparada4 = 0
		llendoterminalB = 0
	}
}

object paradas
{
	const terminalA = 0
	const parada1 = 1
	const parada2 = 2
	const parada3 = 3
	const parada4 = 4
	const terminalB = 5
	
	var esperandoterminalA = 0
	var esperandoparada1 = 0
	var esperandoparada2 = 0
	var esperandoparada3 = 0
	var esperandoparada4 = 0
	var esperandoterminalB = 0
	
	method sequedan(cantidad, parada)
	{
		if (parada == terminalA)
		{
			esperandoterminalA += cantidad
		}
		if (parada == parada1)
		{
			esperandoparada1 += cantidad
		}
		if (parada == parada2)
		{
			esperandoparada2 += cantidad
		}
		if (parada == parada3)
		{
			esperandoparada3 += cantidad
		}
		if (parada == parada4)
		{
			esperandoparada4 += cantidad
		}
		if (parada == terminalB)
		{
			esperandoterminalB += cantidad
		}
	}
	method genteesperando(parada)
	{
		if (parada == terminalA)
		{
			return "Terminal A - Personas esperando: " + esperandoterminalA
		}
		if (parada == parada1)
		{
			return "Parada 1 - Personas esperando: " + esperandoparada1
		}
		if (parada == parada2)
		{
			return "Parada 2 - Personas esperando: " + esperandoparada2
		}
		if (parada == parada3)
		{
			return "Parada 3 - Personas esperando: " + esperandoparada3
		}
		if (parada == parada4)
		{
			return "Parada 4 - Personas esperando: " + esperandoparada4
		}
		if (parada == terminalB)
		{
			return "Terminal B - Personas esperando: " + esperandoterminalB
		}
		
		else
			return "Este return es inservible"
	}
}