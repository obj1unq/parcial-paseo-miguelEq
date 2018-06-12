import prendas.*

//Esta clase no debe existir, 
//está para que el test compile al inicio del examen
//al finalizar el examen hay que borrar esta clase
/* 
class XXX {
	var talle= null
	var desgaste= null
	var min= null
	var max= null
	var prendas= null
	var ninios= null
	var edad= null
	var juguete = null
	var abrigo = null
*/
//
//Objetos usados para los talles



class Familia{
	var hijos=#{}
    method puedePasear(){
    	return hijos.all({hijo=>hijo.puedeSalir()})
    }
    
    method prendasInfantables(){
    	return hijos.map({hijo=>hijo.prendaMaximaCalidad()}).asSet()
    }
    
    method chiquitos(){
    	return hijos.filter({hijo=>hijo.edad() < 4})
    }
    
    method pasear(){
    	self.chequearPaseo()
    		hijos.forEach({hijo=> hijo.ponersePrenda()})
    	}
   
    method chequearPaseo(){
    	if(!self.puedePasear()){
    		self.error("solo puede salir a pasear una familia que puede salir")
    	}
    }
}

class Ninio{
	var property talle
	var property edad
	var property prendas=#{}
	
	method puedeSalir(){
		return self.prendasConAbrigoMayorOIgual(3).size()>=5 and self.promedioDeCalidadDePrendas() > 8
	}
	
	method prendasConAbrigoMayorOIgual(valor){
		return prendas.filter({prenda=>prenda.nivelDeAbrigo() >=valor})
	}
	
	method promedioDeCalidadDePrendas(){
		return prendas.sum({prenda=> prenda.nivelDeCalidad(self)}) / prendas.size()
	}
	
	method prendaMaximaCalidad(){
		return prendas.max({prenda=>prenda.nivelDeCalidad(self)})
	}
	
	method ponersePrenda(){
	   prendas.forEach({prenda=>prenda.recibirUso()})	
	}
}

class NinioProblematico inherits Ninio{
	var juguete
	
	override method puedeSalir(){
		return self.prendasConAbrigoMayorOIgual(3).size()>=4 and juguete.permitidoA(self) and self.promedioDeCalidadDePrendas() > 8
	}
}

class Juguete{
	var edadMinima=0
	var edadMaxima=0
	
	method permitidoA(ninio){
		return ninio.edad().between(edadMinima,edadMaxima)
	}
}