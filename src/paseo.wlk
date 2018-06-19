// Nota 8 (ocho): Buen parcial más allá de algunos errores menores.

// 1) MB
// 2) B. Modifica los talles de las prendas, y lo hace antes de la validación. 
// 3) MB-. 
// 4) B+. No valida todas las reglas pedidas.
// 5) B-. Uso ineficiente de herencia / template method lleva a repetición de lógica.
// 6) MB.
// 7) B. Falta abstracción para saber si un ninio es pequenio.
// 8) B+. Usa las prendas como si fueran números al marcar uso de elementos de prenda par.

// Tests no andan!

import prendas.*

class Familia {

	var hijos = #{}

	method puedePasear() {
		return hijos.all({ hijo => hijo.puedeSalir() })
	}

	method prendasInfantables() {
		return hijos.map({ hijo => hijo.prendaMaximaCalidad() }).asSet()
	}

	method chiquitos() {
		// Sería bueno extraer la subtarea de decidir si un ninio es pequenio y no repetir esa lógica.
		return hijos.filter({ hijo => hijo.edad() < 4 }) 
	}

	method pasear() {
		self.chequearPaseo()
		hijos.forEach({ hijo => hijo.ponersePrenda()})
	}

	method chequearPaseo() {
		if (!self.puedePasear()) {
			self.error("solo puede salir a pasear una familia que puede salir")
		}
	}

}

class Ninio {

	var property talle
	var property edad
	var property prendas = #{}

	method puedeSalir() {
		// Falta chequear cantidad de prendas.
		return self.prendasConAbrigoMayorOIgual(3).size() >= 5 and self.promedioDeCalidadDePrendas() > 8
	}

	method prendasConAbrigoMayorOIgual(valor) {
		return prendas.filter({ prenda => prenda.nivelDeAbrigo() >= valor })
	}

	method promedioDeCalidadDePrendas() {
		return prendas.sum({ prenda => prenda.nivelDeCalidad(self) }) / prendas.size()
	}

	method prendaMaximaCalidad() {
		return prendas.max({ prenda => prenda.nivelDeCalidad(self) })
	}

	// Debería ser ponersePrendas, en plural
	method ponersePrenda() {
		prendas.forEach({ prenda => prenda.recibirUso()})
	}

}

class NinioProblematico inherits Ninio {

	var juguete

	override method puedeSalir() {
		// Repite bastante lógica de la superclase, podría evitarse.
		return self.prendasConAbrigoMayorOIgual(3).size() >= 4 and juguete.permitidoA(self) and self.promedioDeCalidadDePrendas() > 8
	}

}

class Juguete {

	var edadMinima = 0
	var edadMaxima = 0

	method permitidoA(ninio) {
		return ninio.edad().between(edadMinima, edadMaxima)
	}

}

