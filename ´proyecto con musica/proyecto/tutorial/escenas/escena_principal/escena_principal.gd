extends Node2D

@export var niveles: Array[PackedScene]
@export var controlador_partida: ControladorPartida
@export var pantalla_derrota: PackedScene
@export var canvas_layer: CanvasLayer
@export var musica: AudioStreamPlayer2D
@export var musica_pausa: AudioStreamPlayer2D
@export var hud_puntuacion: CanvasItem
@export var hud_vidas: CanvasItem
@export var hud_boton_pausa: CanvasItem

var _nivel_actual: int = 1
var _nivel_instanciado: Node
var _juego_terminado: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ControladorGlobal.pausa_alternada.connect(_on_pausa_alternada)
	
	if ControladorGlobal.nivel > 1:
		_cargar_nivel()
	else:
		_crear_nivel(_nivel_actual)


func _crear_nivel(numero_nivel: int):
	_nivel_instanciado = niveles[numero_nivel - 1].instantiate()
	
	# la última escena del array es la pantalla de victoria: no es un nivel
	# jugable, así que se muestra como una interfaz de pantalla completa
	# (dentro del CanvasLayer) en vez de cómo contenido del mundo del juego.
	var es_pantalla_final := numero_nivel == niveles.size()
	if es_pantalla_final:
		canvas_layer.add_child(_nivel_instanciado)
	else:
		add_child(_nivel_instanciado)
	
	var hijos := _nivel_instanciado.get_children()
	for i in hijos.size():
		if hijos[i].is_in_group("personajes"):
			hijos[i].personaje_muerto.connect(_personaje_murio)
			break
	
	ControladorGlobal.nivel = numero_nivel
	controlador_partida.guardar_partida()
	
	if es_pantalla_final:
		_ocultar_hud()
		_terminar_juego()


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
	_ocultar_hud()
	_terminar_juego()
	canvas_layer.add_child(pantalla_derrota.instantiate())


func _ocultar_hud() -> void:
	hud_puntuacion.visible = false
	hud_vidas.visible = false
	hud_boton_pausa.visible = false


func _terminar_juego() -> void:
	_juego_terminado = true
	musica.stop()
	musica_pausa.stop()


func _on_pausa_alternada(pausado: bool) -> void:
	if _juego_terminado:
		return
	
	if pausado:
		musica.stop()
		musica_pausa.play()
	else:
		musica_pausa.stop()
		musica.play()
