extends Node2D

@onready var fondo_calido = $Fondo_luz_cálida
@onready var fondo_uv = $Fondo_luz_UV

var modo_uv: bool = false

func _ready():
	_aplicar_luces()

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		modo_uv = not modo_uv
		_aplicar_luces()
		get_tree().call_group("piezas", "set_modo_luz_uv", modo_uv)
		print("¡Luz cambiada! Modo UV: ", modo_uv)

func _aplicar_luces():
	if fondo_calido:
		fondo_calido.visible = not modo_uv
	if fondo_uv:
		fondo_uv.visible = modo_uv
