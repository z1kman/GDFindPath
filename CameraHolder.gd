extends Node3D

var mouse_sensitivity := 0.2 # Чувствительность мыши при повороте
var mouse_zoom_step := 1 # Шаг при зумировании

@onready var _camera := $Camera3D

func  _input(event: InputEvent) -> void: 
	# Повороты камеры по мыши
	if event is InputEventMouseMotion:
		# Движение камеры по x и y
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			# Поворот камеры по X
			_camera.rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity))
			# Поворот CameraHolder по Y
			rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity))
	# Скролл колесиками мыши
	elif event is InputEventMouseButton:
		# Зум - 
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			var newVector = Vector3(0, 0, mouse_zoom_step)
			translate(newVector)
		# Зум +
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP: 
			var newVector = Vector3(0, 0, -mouse_zoom_step)
			translate(newVector)
