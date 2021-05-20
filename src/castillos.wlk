const castleRock = new Castillo(tamanioMuralla=350)
const danerys = new Rey(castillo=castleRock)
const cocina = new Cuartos(perimetro=40)
const sala = new Cuartos(perimetro=100)
const jon = new Guardia(capacidad = 600, agotamiento=29,ambienteDelCastillo="sala", temor=20,castillo=castleRock)
const maester = new Burocrata(nombre="aemon", fechaNacimiento=1460, aniosExperiencia=50,panico=120,castillo=castleRock, temor=56)


const winterfell = new Castillo(tamanioMuralla=600)
const bran = new Rey(castillo=winterfell)
const sam = new Guardia(capacidad = 20,agotamiento=100,ambienteDelCastillo="salaa",temor=159,castillo=winterfell)
const cuervo = new Burocrata(nombre="cuervo",fechaNacimiento=20,aniosExperiencia=10000,panico=30,castillo=winterfell,temor=0)
const cocinaa = new Cuartos(perimetro=50)
const salaa= new Cuartos(perimetro=180)
const comedor = new Cuartos(perimetro=30)

const highGarden = new Castillo(tamanioMuralla=100)
const olenna = new Rey(castillo=highGarden)
const margaery = new Guardia(capacidad=100,agotamiento=10,ambienteDelCastillo="jardin",temor=50,castillo=highGarden)
const loras = new Burocrata(nombre="Loras Tyrell",fechaNacimiento=1890,aniosExperiencia=3,panico=80,castillo=highGarden,temor=400)
const jardin = new Cuartos(perimetro=600)
const pasillo = new Cuartos(perimetro=5)

class Castillo{
	var sequitos = []
	var estabilidad = 200
	var situacionDeCastillo = "fiesta" //hay dos estados fiesta y en guerra
	var resistencia = 0
	const tamanioMuralla 
	const ambientes = []
		
	method resistencia()= resistencia
	method agregarSequito(s){
		sequitos.add(s)
	} 
	method situacionDeCastillo()=situacionDeCastillo
	method ambientes()=ambientes
	
	method eliminarSubdito(s){
		sequitos.remove(s)
	}
	
	method agregarAmbiente(a){
		ambientes.add(a)
	}
	method sequitos(){
		return sequitos
	}
	method estadoDeCastillo(){
		if (self.estabilidad() > 100){
			return "Castillo permanece en pie"
		}
		else
			return "Castillo derrotado"
	}

	method capacidadDeLosGuardias(){
		return sequitos.sum{c=>c.capacidad()}
	}
	
	method estabilidad(){
			return estabilidad + self.capacidadDeLosGuardias()
	}

	method aumentarResistencia(b){
		resistencia +=b
	}
	//cuando la sumatoria del temor de los guardias es matoy a 120 se concidera que hay mucho temor entre sus moradores
	method muchoTemor(){
		return sequitos.sum{s=>s.temor()} < 120
	}
	method prepararDefensas(){
		sequitos.forEach{s=>s.realizarPlanEstratega()}
	}
	
	method aumentarEstabilidad(e){
		estabilidad = estabilidad + e
	}
	method restarEstabilidad(e){
		estabilidad -= e
	}
	
	method bajoAmenaza(){
		return estabilidad <= 125 and !self.muchoTemor()
	}
	
	method cantidadDeAmbientes(){
		return ambientes.size()
	}
	
	method sumaDePerimetros(){
		return ambientes.sum{c=>c.perimetro()}
	}
	method recibirAtaque(){//hay algo mal con esta cuenta y estabilidad
		self.prepararDefensas()
		estabilidad = estabilidad + (tamanioMuralla - self.cantidadDeAmbientes() - self.sumaDePerimetros() - self.resistencia())
		sequitos.forEach{s=>s.efectoDeRecibirAtaque()}	
	}
	
	
	}

class Guardia{
		var capacidad
		var agotamiento
		var ambienteDelCastillo
		var temor
		const castillo
		
		method aumentarTemor(t){
			temor +=t
		}
		
		method disminuirTemor(t){
			temor -=t
		}

		
		method realizarPlanEstratega(){
			castillo.aumentarResistencia(40)    //no está tan bueno eso ver después
		}
		
		method agotamiento()=agotamiento
		method capacidad(){
			return capacidad
		}
		
		method efectoPorLaFiesta(){
			agotamiento -= 10
		}

	method efectoDeRecibirAtaque(){
		agotamiento +=50
	}
	method temor()=temor
}

class Burocrata{
	const nombre
	const fechaNacimiento
	var aniosExperiencia
	const castillo
	var temor
	var capacidad = 0
	var panico
	
	method temor(){
		return temor
	}
	
	method aumentarTemor(b){
		temor +=b
	}
	
	method reducirTemor(t){
		temor -=t
	}
	method panico(){
		return panico
	}
	

	
	method efectoPorLaFiesta(){
		panico = 0}

	method realizarPlanEstratega(){
		if(panico<100){
			 castillo.aumentarResistencia(40) 
		}
		
	}
	
	method capacidad(){
		return capacidad
	}
	method efectoDeRecibirAtaque(){
		if (fechaNacimiento > 1840 or aniosExperiencia < 5){
			self.aumentarTemor(45)
		}
	}
}

	

class Rey{
	const castillo
	var castillosEnemigos= []
	
	method agregarCastilloEnemigo(c){
		castillosEnemigos.add(c)
	}
	
	method menorEstabilidad(){
		return castillosEnemigos.min{ce=>ce.estabilidad()}
	}
	method realizarFiesta(){
		if (!castillo.bajoAmenaza()){
			castillo.aumentarEstabilidad(39)
			castillo.sequitos().forEach{s=>s.efectoPorLaFiesta()}
		}
	}
	
	method castillo() = castillo

	method atacar(){
		self.menorEstabilidad().restarEstabilidad(150)
	}
}

class Cuartos{
	const perimetro
	
	method perimetro(){
		return perimetro
	}
}