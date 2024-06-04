import wollok.game.*
import bombita.*
import config.*
import otros.*



//Se instancia al colocar una bomba, el radio va a ser el radio que tenga el usuario seteado
class Bomba {
	var property radio = 1
	var property tiempoExplosion = 2
	var property position = game.at(0,0)
	const property image = "Bomba.png"
	
	method esMejora() = false
	method esPared() = false
	method esCaja() = false
	method esBomba() = true
	
	method Explotar(pusobomba){//Funcion que hace explotar a la bomba eliminando la visual y llamando a las funciones que eliminen 
		game.removeVisual(self)
		pusobomba.cantBombas(pusobomba.cantBombas()-1)
		game.addVisual(new Fuego().poneFuego(self.position().up(1)))
		game.addVisual(new Fuego().poneFuego(self.position().down(1)))
		game.addVisual(new Fuego().poneFuego(self.position().right(1)))
		game.addVisual(new Fuego().poneFuego(self.position().left(1)))
		game.addVisual(new Fuego().poneFuego(self.position()))
	}
	
	method PoneBomba(posicion, pusobomba){//funcion que pasa la posicion y 
		self.position(posicion)
		game.schedule(3000, {self.Explotar(pusobomba)})
		return self
		
	}
	
	method seQuemo(){}
}

