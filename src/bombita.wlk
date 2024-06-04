import wollok.game.*
import config.*
import otros.*
import bombas.*
import mejoras.*
import Colisionadores.*




class Jugador {
	var property radioAumentado = false
	var property puedevolveramoverse = true
	var property radio = 5
	var property position
	var property posicionPrevia = position
	var property cantBombas = 0
 	var property velocidad = 1
  	var property escudo = false
  	var property mejoras = []
  	var property estaVivo = true
  	var property image = imagenElegida.imagenelegida()
  	
  	method image(){if(mejoras.any{p=>p.esMejora()}){
		return "bombita.png"
	}else if(escudo){
		return "cajita.png"
	} else{
		return image	
	}}
  
	method mejoras(){return mejoras}
	
	method seQuemo(){
		if(!escudo){
			estaVivo = false
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
		if(self.estaVivo()and puedevolveramoverse){
			posicionPrevia = position
			position = nuevaPosicion	
		}
		puedevolveramoverse = false
		game.schedule(50, {puedevolveramoverse=true})

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
	var property verohor = 1
	var property estaVivo = true
	
	
	method soltarBomba(posicion){
	if(self.cantBombas()<3 and reload){
		reload = false 
		self.cantBombas(self.cantBombas()+1)
		game.addVisual(new Bomba().PoneBomba(posicion, self, false))
		game.schedule(3000, {reload = true})
		
	}else{}
	}
	
	
	method PersigueVertical(posicion, posicionX, posicionY){
		if (estaVivo){
		if (self.position().distance(posicion)<3){self.soltarBomba(self.position())}
		else {
		if (posicionY.roundUp() > self.position().y().roundUp() and verohor == 1){self.Ir(2)}
		else if (posicionY.roundUp() < self.position().y().roundUp() and verohor == 1){self.Ir(3)}
		else if (posicionX.roundUp() > self.position().x().roundUp() and verohor == 2){self.Ir(1)}
		else if(posicionX.roundUp() < self.position().x().roundUp() and verohor == 2){self.Ir(4)}else{}
		}
		}else{}
        }
        
 

	method Ir(va){
		
		posicionPrevia = position
		
		if(va==1){
			verohor = 1
			
			position=self.position().right(1)
		}
		else if(va==2){
			verohor = 2
			
			position=self.position().up(1)
		}
		else if (va==3){
			verohor = 2
			
			position=self.position().down(1)
		}
		else if (va==4){
			verohor = 1
			
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
			 estaVivo = false
			 game.schedule(1000, {game.removeVisual(self)})
	}
	
	method creacolisionadores(){
		game.onTick(1500,"Colisionadores", {
			game.addVisual(new Colimedio().poneColisionador(self.position(), self))
			game.addVisual(new ColiArriba().poneColisionador(self.position().up(1), self))
			game.addVisual(new ColiAbajo().poneColisionador(self.position().down(1), self))
			game.addVisual(new ColiDer().poneColisionador(self.position().right(1), self))
			game.addVisual(new ColiIzq().poneColisionador(self.position().left(1), self))})
		}
		
//	method seDestraba (){
//		game.onTick(500, "nosequedo", {sequedo = position})
//		game.onTick(7000,"destraba", {self.mueveAzar()})
//	} 
//	
//	method mueveAzar(){
//		if (sequedo == position){
//			self.Ir(1.randomUpTo(4))
//		}else{}
//	}

}


object muestra inherits Jugador(position = game.at (11, 4), image = "Fuego.png"){
	
}

object imagenElegida{
	var property imagenelegida = "BOMBITARODRIGUEZ.png"
	
}
