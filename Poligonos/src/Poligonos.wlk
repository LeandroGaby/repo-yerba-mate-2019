object poligono
{
	var property a = 0
	var property b = 0
	var property c = 0
	
	
	method esEquilatero()
	{
		if (self.esTriangulo()) 
		{
			return (a == b and a == c)
		}
		else
		{
			return false
		}
	}
	method esIsosceles()
	{
		if (self.esTriangulo() and self.iso()) 
		{
			return ((a == b and a != c) or (a == c and a != b) or (c == b and c != a))
		}
		else
		{
			return false
		}
	}
	method esEscaleno()
	{
		if (self.esTriangulo() and self.esca()) 
		{
			return (a != b and a != c and b != c)
		}
		else
		{
			return false
		}
	}
	
	
	method esTriangulo()
	{
		return (a > 0 and b > 0 and c > 0)
	}
	
	method esca()
	{
		if (a > b and a > c)
		{
			return ((b + c) > a)
		}
		if (b > a and b > c)
		{
			return ((a + c) > b)
		}
		if (c > b and c > a)
		{
			return ((b + a) > c)
		}
		else
		{
			return false
		}
	}
	
	method iso()
	{
		if ((a > b and a > c) or (a < b and a < c))
		{
			return ((b + c) > a)
		}
		if ((b > a and b > c) or (b < a and b < c))
		{
			return ((a + c) > b)
		}
		if ((c > b and c > a) or (c < b and c < a))
		{
			return ((b + a) > c)
		}
		
		else
		{
			return false
		}
	}
}