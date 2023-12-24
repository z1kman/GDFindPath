extends Node3D

var mouse_sensitivity := 0.1

@onready var _camera := $Camera3D

func  _input(event: InputEvent) -> void: 
	# Передвижение мыши
	if event is InputEventMouseMotion:
		# Движение камеры по x и y
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			_camera.rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity))
			rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity))
			_camera.rotation_degrees.x = clamp(_camera.rotation_degrees.x, -89.9, 89.9)
	## Скролл колесиками мыши
	#elif event is InputEventMouseButton: 
		
			
