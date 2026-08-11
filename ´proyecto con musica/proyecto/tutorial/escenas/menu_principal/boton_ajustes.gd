extends Button

@export var menu_ajustes: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_abrir_ajustes)


func _abrir_ajustes():
	get_tree().change_scene_to_packed(menu_ajustes)
