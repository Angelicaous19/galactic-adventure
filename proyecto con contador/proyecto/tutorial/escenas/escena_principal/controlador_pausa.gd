extends Node

@export var menu_pausa: Control


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		_alternar_pausa()


func _alternar_pausa() -> void:
	get_tree().paused = !get_tree().paused
	menu_pausa.visible = get_tree().paused
