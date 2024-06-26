import wollok.game.*
import config.*
import otros.*
import bombas.*
import mejoras.*
import bombita.*
import Colisionadores.*

const personajes = ["elChe.png", "BOMBITARODRIGUEZ.PNG", "peron64.png", "milei.png"]


object pantallaInicio {
	var property estainicio = true
	var property elegido = 0
	var property estaeligiendo = true
	method cambio(){
		if (estaeligiendo){
			if (elegido == 0){
				elegido = 1
				botonpersonaje.image("Botonpjseleccionado.png")
				botoninicio.image("Botoninicio.png")
			}else {
				botonpersonaje.image("Botonpj.png")
				botoninicio.image("Botoninicioseleccionado.png")
				elegido =0
			}}
	}
	
	
	
	method On(){
		
		game.clear()
		game.addVisual(botoninicio)
		game.addVisual(botonpersonaje)
		config.configurarTeclas()
		
	}
	
	method eligio(){
		if (elegido == 0){
			botoninicio.elegido()}
			else if (elegido == 1){
				botonpersonaje.elegido()
			}else{
				game.clear()
				elegido = 0
				botonpersonaje.image("Botonpj.png")
				botoninicio.image("Botoninicioseleccionado.png")
				self.vuelveinicio()
			
		}
		}
		
	method vuelveinicio(){
				
				botonpersonaje.puedeelegir(false)
				estaeligiendo = true
				config.borraTeclas()
				self.On()
	}
	
	
	method chequea(){
	
			return estainicio
		
		
	}
	
}


class Botones{
	var property position 
	var property image
	var property puedeelegir = false
	
	
	method elegido(){
		
		
	}
	
}

object botoninicio inherits Botones(position = game.at(11, 5), image = "Botoninicioseleccionado.png"){
	override method elegido(){
		pantallaInicio.estainicio(false)
		game.clear()
		config.borraTeclas()
		iniciarCajas.llenoVector()
		game.schedule(500, {iniciarJugador1.iniciar()
		iniciarParedes.iniciar()})
	
		
	}
}


object botonpersonaje inherits Botones(position = game.at(11, 2), image = "Botonpj.png"){
	var cambiapersonaje = 0
	
	override method elegido(){
		game.clear()
		config.borraTeclas()
		game.addVisual(muestra)
		config.configurarTeclas()
		self.puedeelegir(true)
		pantallaInicio.estainicio(true)
		
		
		
		
	}
	
	method selPersonaje(){
			if (cambiapersonaje < personajes.size()-1){
			cambiapersonaje = cambiapersonaje+1}else{cambiapersonaje = 0}
			muestra.image(personajes.get(cambiapersonaje))
			imagenElegida.imagenelegida(muestra.image())
		
	}
}

