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
		game.schedule(1000, {self.configurarColisiones(enemigo)})
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
		
}


class ColiArriba inherits Colisionadores{
	override method huye (objeto, enemigo){
		game.removeTickEvent("Persigue")
	
			enemigo.escapaBombaAbajo()
			enemigo.escapaBombaDer()
			if (enemigo.position().x().roundUp()>enemigo.posicionPrevia().x().roundUp()){}else{
			enemigo.escapaBombaIzq()}
			
			game.schedule(1000, {config.configurarSeguimiento(enemigo1)})
}
}

class ColiAbajo inherits Colisionadores{
		override method huye (objeto, enemigo){
			game.removeTickEvent("Persigue")
			
			enemigo.escapaBombaArriba()
			enemigo.escapaBombaDer()
			if (enemigo.position().x().roundUp()>enemigo.posicionPrevia().x().roundUp()){}else{
			enemigo.escapaBombaIzq()}
			
			game.schedule(1000, {config.configurarSeguimiento(enemigo1)})
	}
	
		override method colisiono(objeto, enemigo){	
		
		
		if(objeto.esCaja()){
			enemigo.soltarBomba(enemigo.position())
			if (enemigo.position() == game.at(23,9) ){
			enemigo.escapaBombaIzq()}else{}
			
		}else if (objeto.esBomba()){
			self.huye(objeto, enemigo)
			}else{}
		
		
		 //metodo para que el jugador y el enemigo colisionen
	}
}

class ColiDer inherits Colisionadores{
	override method huye (objeto, enemigo){
			game.removeTickEvent("Persigue")
			
			enemigo.escapaBombaArriba()
			enemigo.escapaBombaDer()
			if (enemigo.position().y().roundUp()>enemigo.posicionPrevia().y().roundUp()){}else{
			enemigo.escapaBombaAbajo()}
			
			game.schedule(1000, {config.configurarSeguimiento(enemigo1)})
}
}


class ColiIzq inherits Colisionadores{
		override method huye (objeto, enemigo){
			game.removeTickEvent("Persigue")
			
			enemigo.escapaBombaArriba()
			enemigo.escapaBombaDer()
			if (enemigo.position().y().roundUp()>enemigo.posicionPrevia().y().roundUp()){}else{
			enemigo.escapaBombaAbajo()}
			
			game.schedule(1000, {config.configurarSeguimiento(enemigo1)})
	}
	
	override method colisiono(objeto, enemigo){	
		
		
		if(objeto.esCaja()){
			enemigo.soltarBomba(enemigo.position())
			if (enemigo.position() == game.at(23,9) ){
			enemigo.escapaBombaAbajo()}else{}
			
		}else if (objeto.esBomba()){
			self.huye(objeto, enemigo)
			}else{}
		
		
		 //metodo para que el jugador y el enemigo colisionen
	}
}



class Colimedio inherits Colisionadores{
		override method huye (objeto, enemigo){
			game.removeTickEvent("Persigue")
			enemigo.volver()
			game.schedule(1000, {config.configurarSeguimiento(enemigo1)})
			
	}
}