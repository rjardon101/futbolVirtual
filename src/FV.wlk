class Jugador {
	
	var visionDeJuego
	var visionDeLosCompanieros
	var potencia
	var habilidadDeLosPases
	

	method valorIntrinseco()
	
	method visionGeneral()
	
	method presicionDeJugador() {
		return   3 * self.valorIntrinseco() + habilidadDeLosPases
		}
		
	method sumaEntrePasesYVisonGeneral() {
		return self.visionGeneral() + habilidadDeLosPases
	}	
	
	method sumaEntrePasesYValorIntrinseco() {
		return habilidadDeLosPases + self.valorIntrinseco()
	}
	
	method sumaEntreValorIntrinsecoYVisionGeneral() {
		return self.visionGeneral() + self.valorIntrinseco()
	}
	
}

class Defensor inherits Jugador {
	
	var  quite
	
	override method valorIntrinseco() = quite
	
	override method visionGeneral() {
		return visionDeLosCompanieros + visionDeJuego
	}
}

class Atacante inherits Jugador {
	
	var  anotacion
	
	override method valorIntrinseco() = anotacion
	
	override method visionGeneral() {
		return visionDeJuego + habilidadDeLosPases
	}
	
}

class Equipo {
	
	var jugadores = #{}
	var liga = #{}
	
	
	method pedidoDeJugador(unJugador, pedido) 
	
	method jugadorMasPotente() {
		return jugadores.max({jugador => jugador.pontencia()})
		
	}
	
	method presicionDeEquipo() {
		return jugadores.sum({jugador  =>  3 * jugador.valorIntrinseco() + jugador.habilidadDeLosPases() })
	}
	
	method visionDeEquipo() {
		return jugadores.sum({jugador => jugador.visionGeneral()})
	}
	
	method promedioDePresicion() {
		return self.presicionDeEquipo() * jugadores.size() / 100
	}
	
	method esEquilibrado() {
		
	}
} 

class Liga {
	
	var listaDeEquipos = #{}
	
	method equipoConMasVision() {
		(listaDeEquipos.map({equipo => equipo.visionDeEquipo() })).max()
	}
	
}

class Representante {
	
	var tipoDeRepresentante
	 
	method esUnClub(bool) {
		tipoDeRepresentante = bool
	}
	
	method esUnaPersona(bool) {
		return !self.esUnClub(bool)
	}
	
	method pedidoDePotencia(unJugador, pedido) {
        return unJugador.potencia() >= pedido 		
		
	}
	
	method pedidoDeVision(unJugador, pedido) {
		return unJugador.visionGeneral() >= pedido
	}
	
	method pedidoCombiando(unJugador, pedidoMin, pedidoMax) {
		return pedidoMin < (unJugador.visionGeneral() + unJugador.habilidadDeLosPases() + unJugador.presicionDeJugador()) < pedidoMax
	}
	
}

class EquipoLirico inherits Equipo {
	
	override method pedidoDeJugador(unJugador, pedido) {
		return unJugador.presicionDeJugador() + 2 > self.promedioDePresicion() and not self.esJugadorDescartable(unJugador)
	}
	
	method esJugadorDescartable(unJugador) {
		return (unJugador.visionGeneral() + unJugador.presicionDeJugador()) < 5
	}
	
}

class EquipoRustico inherits Equipo {
	
	method jugadoresPotentes(valorDePotencia) {
		return jugadores.filter({jugador => jugador.potencia() >= valorDePotencia}).asSet()
	}
	
	method hayPocosJugadoresotentes(valorDePotencia) {
		return self.jugadoresPotentes(valorDePotencia).size() < 3
	}
	
	method jugadorPedido(unJugador) {
		return unJugador.potencia() > unJugador.habilidadDeLosPases()
	}
	
	override method pedidoDeJugador(unJugador, valorDePotencia) {
		return self.jugadorPedido(unJugador) and self.hayPocosJugadoresotentes(valorDePotencia)
	}
	
}

class EquipoOrganizado inherits Equipo {
	
	
	method esJugadorDescartable(unJugador) {
		return (unJugador.visionGeneral() < 5 and unJugador.habilidadDeLosPases() < 5) or (unJugador.habilidadDeLosPases() < 5 and unJugador.valorIntrinseco() < 5) or (unJugador.visionGeneral() < 5 and unJugador.valorIntrinseco() < 5)
	}
	
	override method pedidoDeJugador(unJugador, pedido) {
		return (unJugador.visionGeneral() > 8 and unJugador.habilidadDeLosPases() > 8) or (unJugador.habilidadDeLosPases() > 8 and unJugador.valorIntrinseco() > 8) or (unJugador.visionGeneral() > 8 and unJugador.valorIntrinseco() > 8)
	}

	
}


































