import wollok.game.*
import config.*
import otros.*
import bombas.*
import mejoras.*
import Colisionadores.*

class Jugador {
	
	var property radioAumentado = false
	var property position
	var property posicionPrevia = position
	var property cantBombas = 0
 	var property velocidad = 1
  	var property escudo = false
  	var property mejoras = []
  	var property estaVivo = true
  
  	method image(){if(mejoras.any{p=>p.esMejora()}){
		return "bombita.png"
	}else if(escudo){
		return "cajita.png"
	} else{
		return "BOMBITARODRIGUEZ.png"		
	}}
	
	method seQuemo(){
		if(!escudo){
			estaVivo = false
			//game.removeTickEvent("Colisionadores")
			//game.removeTickEvent("Persigue")
			config.gameOver(self)
		}
	}
	
	method soltarBomba(posicion){
	if(self.cantBombas()<3){ 
		self.cantBombas(self.cantBombas()+1)
		game.addVisual(new Bomba().PoneBomba(posicion, self, radioAumentado))
	}else{}
	}
	
	method irA(nuevaPosicion) {
		if(self.estaVivo()){
			posicionPrevia = position
			position = nuevaPosicion	
		}

	}
	
	method volver() {
		position = posicionPrevia
	}
	
	method agarrarMejora(mejora){
		if(self.validarMejora(mejora)){
			mejoras.add(mejora)
			game.removeVisual(mejora)	
		} else{
			game.say(self,'Ya tengo la mejora')
		}
	}
	
	method validarMejora(mejora){
		if(mejoras.size() != 0 ){
			const boolArray = mejoras.map({
				m => self.comparaString(m.contiene(),mejora.contiene())
			})
			return !boolArray.contains(true)
		} else {
			return true
		}
	}
	
	method comparaString(s1,s2){
		return s1 == s2
	}
	
	method activarMejora(){
		if (mejoras.size() != 0){
			const mejoraParaActivar = mejoras.first()
			mejoras.remove(mejoraParaActivar)
			mejoraParaActivar.activar(self)
			game.say(self, mejoraParaActivar.mensajeActivacion())
		} else {
			game.say(self, 'No Tengo Mejoras :(')
		}
	}

	method esPared() = false
	method esCaja() = false
	method esBomba() = false
	method esMejora() = false
	method esJugador() = true

}

class Enemigos {
	
	var property position
	var property posicionPrevia = position
	var property image = "BOMBITARODRIGUEZ.png"
	var property cantBombas = 0
	var property reload = true
	
	
	method soltarBomba(posicion){
	if(self.cantBombas()<3){
		reload = false 
		self.cantBombas(self.cantBombas()+1)
		game.addVisual(new Bomba().PoneBomba(posicion, self, false))
		game.schedule(3000, {reload = true})
	}else{}
	}
	
	
	method Persigue(posicion, posicionX, posicionY){
		if (self.position().distance(posicion)<3 and reload){self.soltarBomba(self.position())}
		else {
		if (posicionY.roundUp() > self.position().y().roundUp()){self.Ir(2)}
		else if (posicionY.roundUp() < self.position().y().roundUp()){self.Ir(3)}
		else if (posicionX.roundUp() > self.position().x().roundUp()){self.Ir(1)}
		else if(posicionX.roundUp() < self.position().x().roundUp()){self.Ir(4)}else{}
		}
        }

	method Ir(va){
		if(va==1){
			posicionPrevia = position
			position=self.position().right(1)
		}
		else if(va==2){
			posicionPrevia = position
			position=self.position().up(1)
		}
		else if (va==3){
			posicionPrevia = position
			position=self.position().down(1)
		}
		else if (va==4){
			posicionPrevia = position
			position=self.position().left(1)
		}

		
}

	method escapaBombaDer(){
			posicionPrevia = position
			position=self.position().right(1)
		
		
	}
	
	method escapaBombaIzq(){
		posicionPrevia = position
		position=self.position().left(1)
		return !(posicionPrevia == position)
		
	}
	method escapaBombaArriba(){
		posicionPrevia = position
		position=self.position().up(1)
		
	}
	method escapaBombaAbajo(){
		posicionPrevia = position
		position=self.position().down(1)
	
	}

	method volver(){
		position = posicionPrevia
	}
	method esMejora() = false
	method esPared() = false
	method esCaja() = false
	method esBomba() = false
	method esJugador() = true
//tiene que chequear que este mas a la izquierda, derecha arriba o abajo


	method seQuemo(){
			 self.image ("BOMBITARODRIGUEZBN.png")
			 game.removeTickEvent("Colisionadores")
			 game.removeTickEvent("Persigue")
			 game.removeVisual(self)
			 //game.schedule(1000, {game.removeVisual(self)})
			 //game.schedule(3000, {
			 //	self.position(position)
			 //	self.image ("BOMBITARODRIGUEZ.png")
			 //	game.addVisual(self)
			 //})
	}
	
	method creacolisionadores(){
		game.onTick(1000,"Colisionadores", {
			game.addVisual(new ColiArriba().poneColisionador(self.position().up(1), self))
			game.addVisual(new ColiAbajo().poneColisionador(self.position().down(1), self))
			game.addVisual(new ColiDer().poneColisionador(self.position().right(1), self))
			game.addVisual(new ColiIzq().poneColisionador(self.position().left(1), self))})
		}

}

