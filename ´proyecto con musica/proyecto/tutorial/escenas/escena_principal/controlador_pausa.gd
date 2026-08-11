extends Node


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		ControladorGlobal.alternar_pausa()
