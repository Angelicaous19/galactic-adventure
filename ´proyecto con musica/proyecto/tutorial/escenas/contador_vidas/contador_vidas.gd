extends Control

@export var contenedor: HBoxContainer
@export var textura_llena: Texture2D
@export var textura_vacia: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ControladorGlobal.vidas_actualizadas.connect(_actualizar_corazones)
	_actualizar_corazones()


func _actualizar_corazones() -> void:
	for hijo in contenedor.get_children():
		hijo.queue_free()
	
	for i in ControladorGlobal.VIDAS_INICIALES:
		var corazon := TextureRect.new()
		corazon.texture = textura_llena if i < ControladorGlobal.vidas else textura_vacia
		corazon.custom_minimum_size = Vector2(28, 28)
		corazon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		corazon.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		contenedor.add_child(corazon)
