import wollok.game.*

class Mejoras{
	const property image
	var property position
	
	method desactivar(personaje){
		return true
	}
	
	method activar(personaje){
		
	}
	
	method seQuemo(){}
	method esMejora() = true
	method esPared() = false
	method esCaja() = false
	method esBomba() = false	
}

class TomaMate inherits Mejoras{
	
	override method activar(personaje){
		game.schedule(5000, self.desactivar(personaje))
		personaje.escudo(true)
	}
	
	override method desactivar(personaje){
		personaje.escudo(false)
		return true
	}
}

class FumaPorro inherits Mejoras{
	var property nuevaVelocidad = 2
	var property velDefault = 1
	
	override method activar(personaje){
		game.schedule(5000, self.desactivar(personaje))
		personaje.velocidad(nuevaVelocidad)
	}
	
	override method desactivar(personaje){
		personaje.velocidad(velDefault)
		return true
	}
}

class ComeAsado inherits Mejoras{
	const nuevoRadio = 2
	const radioDefault = 1
	
	override method activar(personaje){
		game.schedule(5000, self.desactivar(personaje))
		personaje.radio(nuevoRadio)
	}
	
	override method desactivar(personaje){
		personaje.radio(radioDefault)
		return true
	}
}
