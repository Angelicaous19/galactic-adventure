class_name ContenedorMonedas
extends Node

const PUNTOS_POR_MONEDA: int = 10

var _total_monedas: int
var _monedas_recogidas: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var monedas := get_children()
	_total_monedas = monedas.size()
	
	for moneda in monedas:
		if ControladorGlobal.moneda_ya_recogida(_id_moneda(moneda.name)):
			# ya se había recogido antes de morir: se elimina sin volver a sumar puntos
			_monedas_recogidas += 1
			moneda.queue_free()
		else:
			moneda.contenedor_monedas = self
	
	if _total_monedas > 0 and _monedas_recogidas == _total_monedas:
		get_parent().get_parent().siguiente_nivel.call_deferred()


func moneda_recogida(nombre_moneda: String):
	_monedas_recogidas += 1
	ControladorGlobal.marcar_moneda_recogida(_id_moneda(nombre_moneda))
	ControladorGlobal.sumar_puntos(PUNTOS_POR_MONEDA)
	
	if _monedas_recogidas == _total_monedas:
		get_parent().get_parent().siguiente_nivel()


func _id_moneda(nombre_moneda: String) -> String:
	return "%d:%s" % [ControladorGlobal.nivel, nombre_moneda]
