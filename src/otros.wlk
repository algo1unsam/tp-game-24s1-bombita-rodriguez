import wollok.game.*
import bombita.*
import config.*
import mejoras.*

class Caja {
	
	var property position
	method image() = "cabildofrente.png"
	
	method esMejora() = false
	method esPared() = false
	method esCaja() = true
	method esBomba() = false
	method esJugador() = false
	
	method removerConProbabilidadDeMejora() {
        game.removeVisual(self)
        
       if (0.randomUpTo(2).roundUp() == 1) {
            self.generarMejora()
     	}
    }

    method generarMejora() {
        
        const mejora = [
        new TomaMate(position = self.position(), image='mate.png')
        ,new FumaPorro(position = self.position(), image = 'faso.png')
       	,new ComeAsado(position = self.position(), image='parrilla.png')
        ].anyOne()
        
        game.addVisual(mejora)
    }
		
		
	method seQuemo(){
		self.removerConProbabilidadDeMejora()
	}
}


class Fuego{
var property position = game.origin()
method image() = "Fuego.png" 
	
	method Destruye(){
		const collidObj = game.colliders(self)
		
		if(collidObj != []){
			collidObj.forEach({e=>e.seQuemo()})
		}
		
		game.schedule(500, {self.eliminaVisual()})	
	}

	method poneFuego(posicion){
		self.position(posicion)
		game.schedule(1, {self.Destruye()})
		return self
	}

	method eliminaVisual(){
		game.removeVisual(self)
	}
	
	method seQuemo(){}
	method esMejora() = false
	method esPared() = false
	method esCaja() = false
	method esBomba() = false
	method esJugador() = false
}

class Pared{
	var property position
	method image() = "pared.png"
	method esPared() = true
	method esCaja() = false
	method esBomba() = false
	method esMejora() = false
	method esJugador() = false
	method seQuemo(){}

}

object movimientonpc{
	
	method escapaBombaDer(jugador){
			jugador.posicionPrevia(jugador.position()) 
			jugador.position(jugador.position().right(1))
			
		
	}
	
	method escapaBombaIzq(jugador){
		jugador.posicionPrevia(jugador.position()) 
			jugador.position(jugador.position().left(1))
		
		
	}
	method escapaBombaArriba(jugador){
		jugador.posicionPrevia(jugador.position()) 
			jugador.position(jugador.position().up(1))
		
	}
	method escapaBombaAbajo(jugador){
		jugador.posicionPrevia(jugador.position()) 
			jugador.position(jugador.position().down(1))
		
	}
	
	
	
		
		method derecha(jugador){
			jugador.posicionPrevia(jugador.position())
			jugador.verohor(1)
			
			jugador.position(jugador.position().right(1))
		}
		method arriba(jugador){
			jugador.posicionPrevia(jugador.position())
			jugador.verohor(2)
			
			jugador.position(jugador.position().up(1))
		}
		method abajo(jugador){
			jugador.posicionPrevia(jugador.position())
			jugador.verohor(2)
			
			jugador.position(jugador.position().down(1))
		}
		method izquierda(jugador){
			jugador.posicionPrevia(jugador.position())
			jugador.verohor(1)
			
			jugador.position(jugador.position().left(1))
		}
		

		

		
}
	
	


