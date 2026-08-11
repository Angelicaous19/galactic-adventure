extends Control

const RUTA_MENU_PRINCIPAL: String = "res://escenas/menu_principal/menu_principal.tscn"

@export var label_puntuacion: Label
@export var boton_reiniciar: Button
@export var boton_menu: Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_puntuacion.text = "Puntuación final: %d" % ControladorGlobal.puntuacion
	boton_reiniciar.pressed.connect(_reiniciar)
	boton_menu.pressed.connect(_ir_a_menu)


func _reiniciar() -> void:
	ControladorGlobal.reiniciar_progreso()
	get_tree().reload_current_scene()


func _ir_a_menu() -> void:
	ControladorGlobal.reiniciar_progreso()
	get_tree().change_scene_to_file(RUTA_MENU_PRINCIPAL)
