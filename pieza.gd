extends Sprite2D

@onready var area_2d = $Area2D
@onready var aura = $Aura
@onready var sombra = $Sombra

var velocidad_movimiento = 180.0
var velocidad_rotacion = 2.0
var esta_seleccionada = false

# Configuración del sistema de alineación
@export var angulo_objetivo: float = 0.0
@export var tolerancia: float = 0.1
var esta_alineado: bool = false

# Estados de la pieza
var modo_luz_uv: bool = false
var esta_sucio: bool = true
var tiene_pegamento: bool = false

# Texturas individuales para cada estado
@export var tex_normal: Texture2D
@export var tex_sucia: Texture2D
@export var tex_verde: Texture2D
@export var tex_pegamento_cafe: Texture2D
@export var tex_pegamento_verde: Texture2D
@export var tex_uv: Texture2D

# Unión de piezas
@export var posicion_objetivo: Vector2
@export var distancia_union: float = 25.0
@export var velocidad_union: float = 14.0
var esta_unida: bool = false

# Sombra en la pared (color café fijo, sin cambiar textura)
@export var offset_sombra: Vector2 = Vector2(-30, -85)
@export var color_sombra: Color = Color(1.0, 1.0, 1.0, 0.9)

func _ready():
	add_to_group("piezas")
	esta_seleccionada = false
	
	if aura:
		aura.visible = false
		aura.scale = Vector2(1.0, 1.0)
		aura.modulate = Color(1.0, 1.0, 1.0, 1.0)
		aura.z_index = -1

	if sombra:
		sombra.visible = true
		sombra.top_level = true
		if sombra.texture == null and tex_normal != null:
			sombra.texture = tex_normal
		sombra.modulate = color_sombra

	actualizar_apariencia()
	_actualizar_sombra()

func _physics_process(delta):
	if esta_unida:
		_procesar_union(delta)
		_actualizar_sombra()
		return
		
	if esta_seleccionada:
		if Input.is_action_pressed("ui_left"):
			rotation -= velocidad_rotacion * delta
		if Input.is_action_pressed("ui_right"):
			rotation += velocidad_rotacion * delta
			
		var direccion = Vector2.ZERO
		if Input.is_key_pressed(KEY_W):
			direccion.y -= 1
		if Input.is_key_pressed(KEY_S):
			direccion.y += 1
		if Input.is_key_pressed(KEY_A):
			direccion.x -= 1
		if Input.is_key_pressed(KEY_D):
			direccion.x += 1
			
		if direccion != Vector2.ZERO:
			var movimiento = direccion.normalized() * velocidad_movimiento * delta
			
			global_position.x += movimiento.x
			if _verificar_colision_actual():
				global_position.x -= movimiento.x
				
			global_position.y += movimiento.y
			if _verificar_colision_actual():
				global_position.y -= movimiento.y
		
	verificar_alineacion()
	_procesar_union(delta)
	_actualizar_sombra()

func _input(event):
	if esta_unida:
		return
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var distancia = global_position.distance_to(get_global_mouse_position())
		
		if distancia < 35:
			get_tree().call_group("piezas", "deseleccionar")
			esta_seleccionada = true
			z_index = 10
			print("Pieza seleccionada: ", name)
		else:
			esta_seleccionada = false
			z_index = 0
			
		_actualizar_aura()
		actualizar_apariencia()
		
	if esta_seleccionada and event is InputEventKey and event.pressed and event.keycode == KEY_C:
		if esta_sucio:
			esta_sucio = false
			print("¡Pieza limpia!")
			actualizar_apariencia()

	if esta_seleccionada and event is InputEventKey and event.pressed and event.keycode == KEY_P:
		if esta_sucio:
			print("⚠️ ¡Está sucia, límpiala con 'C' primero!")
		elif not tiene_pegamento:
			tiene_pegamento = true
			print("¡Pegamento aplicado!")
			actualizar_apariencia()

func verificar_alineacion():
	var diferencia = abs(wrapf(rotation - angulo_objetivo, -PI, PI))
	if diferencia <= tolerancia:
		if not esta_alineado:
			esta_alineado = true
	else:
		if esta_alineado:
			esta_alineado = false
	actualizar_apariencia()

func _verificar_colision_actual() -> bool:
	if _puede_unirse():
		return false
		
	if area_2d:
		for area in area_2d.get_overlapping_areas():
			var otra_pieza = area.get_parent()
			if otra_pieza != self and otra_pieza.is_in_group("piezas"):
				if otra_pieza.has_method("_puede_unirse") and otra_pieza._puede_unirse():
					continue
				return true
	return false

func actualizar_apariencia():
	var textura_actual = null
	
	if modo_luz_uv:
		if tex_uv: textura_actual = tex_uv
	elif esta_sucio:
		if tex_sucia: textura_actual = tex_sucia
	else:
		if esta_alineado:
			if tiene_pegamento:
				if tex_pegamento_verde: textura_actual = tex_pegamento_verde
			else:
				if tex_verde: textura_actual = tex_verde
		else:
			if tiene_pegamento:
				if tex_pegamento_cafe: textura_actual = tex_pegamento_cafe
			else:
				if tex_normal: textura_actual = tex_normal
				
	if textura_actual:
		texture = textura_actual

	_actualizar_aura()
	modulate = Color(1.0, 1.0, 1.0)

func set_modo_luz_uv(activo: bool):
	modo_luz_uv = activo
	actualizar_apariencia()

func _actualizar_aura():
	if aura:
		aura.visible = esta_seleccionada

func deseleccionar():
	esta_seleccionada = false
	z_index = 0
	_actualizar_aura()
	actualizar_apariencia()

func _puede_unirse() -> bool:
	return (not esta_sucio) and esta_alineado and tiene_pegamento

func _procesar_union(delta):
	if esta_unida:
		global_position = global_position.lerp(posicion_objetivo, velocidad_union * delta)
		rotation = lerp_angle(rotation, angulo_objetivo, velocidad_union * delta)
		return

	if _puede_unirse() and global_position.distance_to(posicion_objetivo) <= distancia_union:
		esta_unida = true
		esta_seleccionada = false
		z_index = 2
		_actualizar_aura()
		actualizar_apariencia()
		_actualizar_sombra()
		print("¡Pieza unida: ", name)

func _actualizar_sombra():
	if not sombra:
		return

	sombra.visible = true
	sombra.scale = global_scale
	sombra.rotation = global_rotation
	sombra.global_position = global_position + offset_sombra
