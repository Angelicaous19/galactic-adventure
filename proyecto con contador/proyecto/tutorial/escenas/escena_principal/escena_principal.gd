extends Node2D

@export var niveles: Array[PackedScene]
@export var controlador_partida: ControladorPartida
@export var pantalla_derrota: PackedScene

var _nivel_actual: int = 1
var _nivel_instanciado: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ControladorGlobal.nivel > 1:
		_cargar_nivel()
	else:
		_crear_nivel(_nivel_actual)


func _crear_nivel(numero_nivel: int):
	_nivel_instanciado = niveles[numero_nivel - 1].instantiate()
	add_child(_nivel_instanciado)
	
	var hijos := _nivel_instanciado.get_children()
	for i in hijos.size():
		if hijos[i].is_in_group("personajes"):
			hijos[i].personaje_muerto.connect(_personaje_murio)
			break
	
	ControladorGlobal.nivel = numero_nivel
	controlador_partida.guardar_partida()


func _eliminar_nivel():
	_nivel_instanciado.queue_free()


func _personaje_murio():
	if ControladorGlobal.vidas <= 0:
		_mostrar_pantalla_derrota()
	else:
		_reiniciar_nivel()


func _reiniciar_nivel():
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)


func siguiente_nivel():
	_nivel_actual += 1
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)


func _cargar_nivel():
	_nivel_actual = ControladorGlobal.nivel
	_crear_nivel.call_deferred(_nivel_actual)


func _mostrar_pantalla_derrota():
	_eliminar_nivel()
	add_child(pantalla_derrota.instantiate())
