import wollok.game.*
import bombita.*
import config.*

class Mejoras{
	const property image
	var property position
	
	
	// Validacion de metodos que no le pueden faltar a una mejora
	method desactivar(personaje){}
	
	method activar(personaje){}
	
	method programarDesactivar(personaje){
		game.schedule(5000, {=>self.desactivar(personaje)})
	}
	
	method mensajeActivacion(){
		return 'Mejora Activada'
	}
	
	method seQuemo(){
		game.removeVisual(self)
	}
	
	method esMejora() = true
	method esPared() = false
	method esCaja() = false
	method esBomba() = false
	method esJugador() = false	
}

class TomaMate inherits Mejoras{
	
	override method mensajeActivacion(){
		return 'Pasado de mates'
	}
	
	override method activar(personaje){
		self.programarDesactivar(personaje)
		personaje.escudo(true)
	}
	
	override method desactivar(personaje){
		personaje.escudo(false)
	}
	
	method contiene(){
		return 'tieneMate'
	}
}

class FumaPorro inherits Mejoras{
	var property nuevaVelocidad = 2
	var property velDefault = 1
	
	override method mensajeActivacion(){
		return 'Pego?'
	}
	
	override method activar(personaje){
		self.programarDesactivar(personaje)
		config.reconfigurarTeclas()
	}
	
	override method desactivar(personaje){
		config.volverTeclas()
	}
	
	method contiene (){
		return 'tienePorro'
	}
}

class ComeAsado inherits Mejoras{
	
	override method mensajeActivacion(){
		return 'Poder Asado'
	}
	
	
	override method activar(personaje){
		self.programarDesactivar(personaje)
		personaje.radioAumentado(true)
	}
	
	override method desactivar(personaje){
		personaje.radioAumentado(false)
	}
	
	method contiene (){
		return 'tieneAsado'
	}
}