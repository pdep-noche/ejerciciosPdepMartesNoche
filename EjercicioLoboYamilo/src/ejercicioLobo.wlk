object yamilo {
	
	var calorias = 100
	
	method calorias(cantidad) {
		calorias = cantidad
	}
	
	method calorias() = calorias
	
	method comerA(unAnimal) {
		calorias += unAnimal.peso() / 10
	}
	
	
	method estaConSobrepeso() = calorias > 200
	
	method estaSaludable() = calorias.between(20, 150)	
	
	method correr(tiempo) {
		calorias -= tiempo * 2
	}
	
}


object chanchito {
	var peso = 80
	
	method peso() = peso
	
}




