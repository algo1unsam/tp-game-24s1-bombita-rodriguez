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
        new TomaMate(position = self.position(), image='bombita.png')
        ,new FumaPorro(position = self.position(), image = 'cajita.png')
       	,new ComeAsado(position = self.position(), image='Bomba.png')
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
		
		game.schedule(1000, {self.eliminaVisual()})	
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
	method esMejora() = false
	method esPared() = true
	method esCaja() = false
	method esBomba() = false
	method esJugador() = false
	method seQuemo(){}

}

