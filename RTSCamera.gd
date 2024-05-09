extends Node3D

# camera move
@export_range(0, 100, 1) var camera_move_speed: float = 20.0

# camera pan
@export_range(0, 32, 4) var camera_automatic_pan_margin:int = 16
@export_range(0, 32, 4) var camera_automatic_pan_speed:float = 12

# camera zoom
var camera_zoom_direction = 0
@export_range(0, 100, 1) var camera_zoom_speed = 40.0
@export_range(0, 100, 1) var camera_zoom_min = 10.0
@export_range(0, 100, 1) var camera_zoom_max = 25.0
@export_range(0, 2, 0.1) var camera_zoom_speed_damp = 0.92

# Flags
var camera_can_move_base = true
var camera_can_process = true
var camera_can_zoom = true
var camera_can_automatic_pan = true

# Nodes
@onready var camera_socket = $cameraSocket
@onready var camera = $cameraSocket/Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void :
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if !camera_can_process: return
	camera_base_move(delta)
	camera_zoom_update(delta)
	camera_automatic_pan(delta)
	
func _unhandled_input(event) -> void:
	if event.is_action("camera_zoom_in"):
		camera_zoom_direction = -1
	elif event.is_action("camera_zoom_out"):
		camera_zoom_direction =  1
	
	
# base move (WASD)
func camera_base_move(delta: float) -> void:
	if !camera_can_move_base: return
	var velocity_direction: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("camera_move_forward"):
		velocity_direction -= transform.basis.z
	if Input.is_action_pressed("camera_move_backward"):
		velocity_direction += transform.basis.z
	if Input.is_action_pressed("camera_move_right"):
		velocity_direction += transform.basis.x
	if Input.is_action_pressed("camera_move_left"):
		velocity_direction -= transform.basis.x
	
	position += velocity_direction.normalized() * delta * camera_move_speed

func camera_zoom_update(delta: float) -> void:
	if !camera_can_zoom: return
	
	var new_zoom = clamp(camera.position.z + camera_zoom_speed * camera_zoom_direction * delta, camera_zoom_min, camera_zoom_max)
	camera.position.z = new_zoom
	camera_zoom_direction *= camera_zoom_speed_damp

func camera_automatic_pan(delta: float) -> void: 
	if !camera_can_automatic_pan: return
	
	var viewport_current: Viewport = get_viewport()
	var pan_direction: Vector2 = Vector2(-1, -1)
	var viewport_visible_rectangle: Rect2i = Rect2i(viewport_current.get_visible_rect())
	var viewport_size: Vector2i = viewport_visible_rectangle.size
	var current_mouse_position: Vector2 = viewport_current.get_mouse_position()
	var margin = camera_automatic_pan_margin
	var zoom_factor: float = camera.position.z * 0.1
	
	# X Pan
	if (current_mouse_position.x < margin) or (current_mouse_position.x > viewport_size.x - margin):
		if current_mouse_position.x > viewport_size.x / 2:
			pan_direction.x = 1
		translate(Vector3(pan_direction.x * delta * camera_automatic_pan_speed * zoom_factor, 0, 0) )
	# Y Pan
	if (current_mouse_position.y < margin) or (current_mouse_position.y > viewport_size.y - margin):
		if current_mouse_position.y > viewport_size.y / 2:
			pan_direction.y = 1
		translate(Vector3(0, 0, pan_direction.y * delta * camera_automatic_pan_speed * zoom_factor) )
