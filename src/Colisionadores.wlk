import wollok.game.*
import config.*
import otros.*
import bombas.*
import mejoras.*
import bombita.*

class Colisionadores{
	var property position = game.origin()
	var property image = "cajita.png" 
	
	
	method poneColisionador(posicion, enemigo){
		self.position(posicion)
		game.schedule(500, {self.configurarColisiones(enemigo)})
		return self}
		
	method configurarColisiones(enemigo) {
	
		const collidObj = game.colliders(self)
		
		if(collidObj != []){
			collidObj.forEach({e=>self.colisiono(e, enemigo)})
		}
		
		self.destruye()
	}
		
//		
	method colisiono(objeto, enemigo){	
		if(objeto.esCaja()){
			enemigo.soltarBomba(enemigo.position())
			enemigo.volver()
		}else if (objeto.esBomba()){
			self.huye(objeto, enemigo)
			}else{}
		 //metodo para que el jugador y el enemigo colisionen
	}
	
	
	method huye (objeto, enemigo){
	}
	
	method destruye(){
		
		game.removeVisual(self)	
	}
	
	method seQuemo(){}
	method esMejora() = false
	method esPared() = false
	method esCaja() = false
	method esBomba() = false
	method esJugador() = false
		
}



class ColiArriba inherits Colisionadores{
	override method huye (objeto, enemigo){
		game.removeTickEvent("Persigue")
			enemigo.escapaBombaIzq()
			enemigo.escapaBombaDer()
			enemigo.escapaBombaAbajo()
			game.schedule(1000, {config.configurarSeguimiento(enemigo)})
}
}

class ColiAbajo inherits Colisionadores{
		override method huye (objeto, enemigo){
			game.removeTickEvent("Persigue")
			if (enemigo.escapaBombaIzq()){}
			else {
			enemigo.escapaBombaDer()}
			enemigo.escapaBombaArriba()

			
			game.schedule(1000, {config.configurarSeguimiento(enemigo)})
	}
}

class ColiDer inherits Colisionadores{
	override method huye (objeto, enemigo){
		game.removeTickEvent("Persigue")
			enemigo.escapaBombaIzq()
			enemigo.escapaBombaArriba()
			enemigo.escapaBombaAbajo()
			
			game.schedule(1000, {config.configurarSeguimiento(enemigo)})
}
}


class ColiIzq inherits Colisionadores{
		override method huye (objeto, enemigo){
		game.removeTickEvent("Persigue")
			enemigo.escapaBombaDer()
			enemigo.escapaBombaArriba()
			enemigo.escapaBombaAbajo()
			game.schedule(1000, {config.configurarSeguimiento(enemigo)})
	}
}