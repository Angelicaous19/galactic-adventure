class_name ControladorPartida
extends Node

@export var partida: DatosPartida

var _ruta: String = "user://partida.tres"


func guardar_partida():
	partida.nivel = ControladorGlobal.nivel
	partida.muertes = ControladorGlobal.muertes
	partida.vidas = ControladorGlobal.vidas
	partida.puntuacion = ControladorGlobal.puntuacion
	
	ResourceSaver.save(partida, _ruta)


func cargar_partida():
	if ResourceLoader.exists(_ruta):
		partida = load(_ruta)
		
		ControladorGlobal.nivel = partida.nivel
		ControladorGlobal.muertes = partida.muertes
		ControladorGlobal.puntuacion = partida.puntuacion
		
		# compatibilidad con partidas guardadas antes de existir el sistema de vidas
		if partida.vidas > 0:
			ControladorGlobal.vidas = partida.vidas
		else:
			ControladorGlobal.vidas = ControladorGlobal.VIDAS_INICIALES
