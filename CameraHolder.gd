extends Node3D

# https://youtu.be/QitqbSHEYas

@export var acceleration = 25.0
@export var moveSpeed = 5.0
@export var mouseSensitivity = 0.005
@export var mouseZoomStep = 1

var velocity = Vector3.ZERO
var lookAngles = Vector2.ZERO


	
# Вызывается каждый фрейм
# Delta - это прошедшее время от предыдущего кадра
func _process(delta):
	lookAngles.y = clamp(lookAngles.y, PI / -2, PI / 2)
	set_rotation(Vector3(lookAngles.y, lookAngles.x, 0))
	var direction = updateDirection();
	if direction.length_squared() > 0:
		velocity += direction * acceleration * delta
	if velocity.length() > moveSpeed:
		velocity = velocity.normalized() * moveSpeed
	translate(velocity * delta)

func _input(event):
	# Повороты камеры по мыши
	if event is InputEventMouseMotion:
		# Движение камеры по x и y
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			lookAngles += event.relative * mouseSensitivity
	# Скролл колесиками мыши
	elif event is InputEventMouseButton:
		# Зум - 
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			var newVector = Vector3(0, 0, mouseZoomStep)
			translate(newVector)
		# Зум +
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP: 
			var newVector = Vector3(0, 0, -mouseZoomStep)
			translate(newVector)
		
func updateDirection():
	var dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		dir += Vector3.FORWARD
	if Input.is_action_pressed("move_backward"):
		dir += Vector3.BACK
	if Input.is_action_pressed("move_left"):
		dir += Vector3.LEFT
	if Input.is_action_pressed("move_right"):
		dir += Vector3.RIGHT
	if Input.is_action_pressed("move_up"):
		dir += Vector3.UP
	if Input.is_action_pressed("move_down"):
		dir += Vector3.DOWN
		
	if dir == Vector3.ZERO:
		velocity = Vector3.ZERO
	
	return dir.normalized()
	
	
#extends Node3D
#
#var mouse_sensitivity := 0.2 # Чувствительность мыши при повороте
#var mouse_zoom_step := 1 # Шаг при зумировании
#
#@onready var _camera := $Camera3D
#
#func  _input(event: InputEvent) -> void: 
	## Повороты камеры по мыши
	#if event is InputEventMouseMotion:
		## Движение камеры по x и y
		#if event.button_mask == MOUSE_BUTTON_RIGHT:
			## Поворот CameraHolder по Y
			#rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity))
			## Поворот камеры по X
			#rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity))
	## Скролл колесиками мыши
	#elif event is InputEventMouseButton:
		## Зум - 
		#if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#var newVector = Vector3(0, 0, mouse_zoom_step)
			#translate(newVector)
		## Зум +
		#elif event.button_index == MOUSE_BUTTON_WHEEL_UP: 
			#var newVector = Vector3(0, 0, -mouse_zoom_step)
			#translate(newVector)
