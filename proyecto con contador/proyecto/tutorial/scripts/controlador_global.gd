extends Node

signal muertes_actualizado
signal vidas_actualizadas
signal puntuacion_actualizada
signal partida_perdida

const VIDAS_INICIALES: int = 4

var nivel: int
var muertes: int
var vidas: int = VIDAS_INICIALES
var puntuacion: int
var monedas_recogidas: Dictionary = {}


func sumar_muerte():
	muertes += 1
	muertes_actualizado.emit()


func perder_vida():
	vidas -= 1
	vidas_actualizadas.emit()
	
	if vidas <= 0:
		partida_perdida.emit()


func sumar_puntos(cantidad: int = 10):
	puntuacion += cantidad
	puntuacion_actualizada.emit()


func marcar_moneda_recogida(id_moneda: String) -> void:
	monedas_recogidas[id_moneda] = true


func moneda_ya_recogida(id_moneda: String) -> bool:
	return monedas_recogidas.has(id_moneda)


func reiniciar_progreso():
	nivel = 1
	muertes = 0
	vidas = VIDAS_INICIALES
	puntuacion = 0
	monedas_recogidas.clear()
	
	muertes_actualizado.emit()
	vidas_actualizadas.emit()
	puntuacion_actualizada.emit()
