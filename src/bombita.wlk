import wollok.game.*
import config.*
import otros.*
import bombas.*
import mejoras.*



class Jugador {
	
	var property radio = 5
	var property position
	var property posicionPrevia = position
	var property cantBombas = 0
 	var property velocidad = 1
  	var property escudo = false
  	const property mejoras = []
  	var property estaVivo = true
  
  	method image(){if(mejoras.any{p=>p.esMejora()}){
		return "bombita.png"
	}else{
		return "BOMBITARODRIGUEZ.png"
	}}
  
	method mejoras(){return mejoras}
	
	method seQuemo(){
		if(escudo){
			escudo = false
		}else{
		estaVivo = false
		config.gameOver()
		}
	}
	
	method soltarBomba(posicion){
	if(self.cantBombas()<3){ 
		self.cantBombas(self.cantBombas()+1)
		game.addVisual(new Bomba().PoneBomba(posicion, self))
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
		mejoras.add(mejora)
	}
	
	method esPared() = false
	method esCaja() = false
	method esBomba() = false
	method esMejora() = false

}

class Enemigos {
	
	var property position
	var property posicionPrevia = position
	var property image = "BOMBITARODRIGUEZ.png"
	var property cantBombas = 0
	
	method soltarBomba(posicion){
	if(self.cantBombas()<3){ 
		self.cantBombas(self.cantBombas()+1)
		game.addVisual(new Bomba().PoneBomba(posicion, self))
	}else{}
	}
	
	
	method Persigue(posicion, posicionX, posicionY){
		if (self.position().distance(posicion)<3){self.soltarBomba(self.position())}
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

	method volver(){
		position = posicionPrevia
	}
	method esMejora() = false
	method esPared() = false
	method esCaja() = false
	method esBomba() = false
//tiene que chequear que este mas a la izquierda, derecha arriba o abajo
}


