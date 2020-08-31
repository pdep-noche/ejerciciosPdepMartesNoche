object pepita{
	
	var energia = 100
	
	method vola(cantMetros) {
		energia -= cantMetros
	}	
	
	method energia() = energia
	
	
	method energia(cantidad) {
		energia = cantidad
	}
	
	method comer(cantGramos) {
		energia += cantGramos *2
	}
	
	
	
}
