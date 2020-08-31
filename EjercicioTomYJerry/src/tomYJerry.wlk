object tom {
	var energia = 50
	
	var posicion = 30
	
	method podesAtraparA(unRaton) =  self.velocidad() > unRaton.velocidad()
	
	
	method velocidad() = 5 + (energia/10)
	
	method energia(cantidad) {
		energia = cantidad
	}
	
	method energia() = energia
	
	method correrA(unRaton){
		energia -= self.cantidadTiempoEnAlcanzarlo(unRaton)
		posicion = unRaton.posicion()
	}
	
	method cantidadTiempoEnAlcanzarlo(unRaton) {
		return 0.5 * self.velocidad()* self.distanciaA(unRaton)
	}
	
	method distanciaA(unRaton) = (posicion - unRaton.posicion()).abs()
	
	method posicion() = posicion
	
}

object robot {
	var velocidad = 8
	var posicion = 34
	
	method velocidad() = velocidad
	
	method posicion() = posicion
}


object jerry {
	var peso = 4
	var posicion = 34
	
	method velocidad() = 10 - peso
	
	method posicion() = posicion
}