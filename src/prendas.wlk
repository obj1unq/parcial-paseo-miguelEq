object xs {

}

object s {

}

object m {

}

object l {

}

object xl {

}

class Prenda {

	var property talle = s
	var property desgaste = 0
	var abrigo = 3

	method nivelDeComodidad(ninio) {
		var comodidad = if (ninio.talle() == talle) 8 else 0
		return comodidad - (self.nivelDeDesgaste().min(3))
	}

	method nivelDeDesgaste() {
		return desgaste
	}

	method nivelDeCalidad(ninio) {
		return self.nivelDeAbrigo() + self.nivelDeComodidad(ninio)
	}

	method nivelDeAbrigo() {
		return abrigo
	}

	method recibirUso() {
		desgaste += 1
	}

}

class PrendaPar inherits Prenda {

	var property elementoIzquierdo
	var property elementoDerecho

	override method nivelDeComodidad(ninio) {
		var incomodidad = if (ninio.edad() < 4) 1 else 0
		return super(ninio) - incomodidad
	}

	override method nivelDeDesgaste() {
		return (elementoIzquierdo.nivelDeDesgaste() + elementoDerecho.nivelDeDesgaste()) / 2
	}

	method intercambiar(prenda) {
		elementoDerecho.talle(talle)
		elementoIzquierdo.talle(talle)
		prenda.elementoIzquierdo().talle(prenda.talle()) // Esta línea tiene efecto
		prenda.elementoDerecho().talle(prenda.talle()) // Esta también
		const derecho1 = elementoDerecho
		const derecho2 = prenda.elementoDerecho()
		self.chequear(prenda) // Recién acá se valida. Debería validar antes de producir ningún efecto.
		elementoDerecho = derecho2
		prenda.elementoDerecho(derecho1)
	}

	method chequear(prenda) {
		if (talle != prenda.talle()) {
			self.error("no se pueden cambiar prendas dediferentes talles")
		}
	}

	override method nivelDeAbrigo() {
		return elementoIzquierdo.abrigo() + elementoDerecho.abrigo()
	}

	override method recibirUso() {
		// ¿Los elementos son números? Es inconsistente con el resto de los usos.
		elementoDerecho += 1.2
		elementoIzquierdo += 0.8
	}

}

class ElementoDePrenda {

	var property talle = xs
	var property nivelDeDesgaste = 0
	var property abrigo = 1

}

class RopaLiviana inherits Prenda {

	override method nivelDeComodidad(ninio) {
		return super(ninio) + 2
	}

	override method nivelDeAbrigo() {
		return abrigoLiviano.abrigo()
	}

}

class RopaPesada inherits Prenda {
	// ¿No tiene código?
	// Falta poner 3 como valor default para el nivel de abrigo.
}

object abrigoLiviano {

	var property abrigo = 1

}

