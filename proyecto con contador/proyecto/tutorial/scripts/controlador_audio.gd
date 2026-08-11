extends Node

const RUTA_AJUSTES: String = "user://ajustes.cfg"

var volumen: float = 1.0
var silenciado: bool = false

var _bus_master: int


func _ready() -> void:
	_bus_master = AudioServer.get_bus_index("Master")
	
	_cargar_ajustes()
	_aplicar_volumen()
	_aplicar_silencio()


func establecer_volumen(valor: float) -> void:
	volumen = clampf(valor, 0.0, 1.0)
	_aplicar_volumen()
	_guardar_ajustes()


func establecer_silencio(activo: bool) -> void:
	silenciado = activo
	_aplicar_silencio()
	_guardar_ajustes()


func _aplicar_volumen() -> void:
	var db: float = -80.0 if volumen <= 0.0 else linear_to_db(volumen)
	AudioServer.set_bus_volume_db(_bus_master, db)


func _aplicar_silencio() -> void:
	AudioServer.set_bus_mute(_bus_master, silenciado)


func _guardar_ajustes() -> void:
	var config := ConfigFile.new()
	config.set_value("audio", "volumen", volumen)
	config.set_value("audio", "silenciado", silenciado)
	config.save(RUTA_AJUSTES)


func _cargar_ajustes() -> void:
	var config := ConfigFile.new()
	if config.load(RUTA_AJUSTES) == OK:
		volumen = config.get_value("audio", "volumen", volumen)
		silenciado = config.get_value("audio", "silenciado", silenciado)
