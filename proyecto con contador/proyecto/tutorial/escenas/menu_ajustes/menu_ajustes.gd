extends Control

const RUTA_MENU_PRINCIPAL: String = "res://escenas/menu_principal/menu_principal.tscn"

@export var slider_volumen: HSlider
@export var boton_sonido: CheckButton
@export var boton_volver: Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slider_volumen.value = ControladorAudio.volumen
	boton_sonido.button_pressed = !ControladorAudio.silenciado
	
	slider_volumen.value_changed.connect(_on_volumen_cambiado)
	boton_sonido.toggled.connect(_on_sonido_alternado)
	boton_volver.pressed.connect(_volver)


func _on_volumen_cambiado(valor: float) -> void:
	ControladorAudio.establecer_volumen(valor)


func _on_sonido_alternado(activo: bool) -> void:
	ControladorAudio.establecer_silencio(!activo)


func _volver() -> void:
	get_tree().change_scene_to_file(RUTA_MENU_PRINCIPAL)
