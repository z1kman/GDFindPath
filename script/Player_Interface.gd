extends Node2D

# Nodes
@onready var player_camera: Node3D = $"../cameraBase"
@onready var player_camera_visibleunit_Aread3D: Area3D = $"../cameraBase/visibleunits_area3D"
@onready var ui_dragbox: NinePatchRect = $ui_dragbox

# Constants
const min_drag_squared: int = 128

# Variables
@onready var BoxSelectionUnits_Visible: Dictionary = {}

# Internal Variables
var mouse_left_click: bool = false
var drag_rectangle_area: Rect2

func _ready():
	initialize_inteface()

func unit_entered(unit: Node3D) -> void: 
	var unit_id: int = unit.get_instance_id()
	if BoxSelectionUnits_Visible.keys().has(unit_id): return
	BoxSelectionUnits_Visible[unit_id] = unit.get_parent()
	print("unit_entered", unit_id)
	
func unit_exited(unit) -> void:
	var unit_id: int = unit.get_instance_id()
	if !BoxSelectionUnits_Visible.keys().has(unit_id): return
	print("unit_exiseted", unit_id)
	BoxSelectionUnits_Visible.erase(unit_id)
	

func  initialize_inteface() -> void:
	ui_dragbox.visible = false
	player_camera_visibleunit_Aread3D.body_entered.connect(unit_entered)
	player_camera_visibleunit_Aread3D.body_exited.connect(unit_exited)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_leftclick"): 
		drag_rectangle_area.position = get_global_mouse_position()
		ui_dragbox.position = drag_rectangle_area.position
		mouse_left_click = true
	if Input.is_action_just_released("mouse_leftclick"): 
		mouse_left_click = false
		cast_selection()

func cast_selection() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_left_click:
		if !ui_dragbox.visible:
			if drag_rectangle_area.size.length_squared() > min_drag_squared:
				ui_dragbox.visible = true
		
		else :
			update_ui_dragbox()
		
		drag_rectangle_area.size = get_global_mouse_position() - drag_rectangle_area.position

func update_ui_dragbox() -> void:
	ui_dragbox.size = abs(drag_rectangle_area.size)
	
	
	if drag_rectangle_area.size.x < 0: 
		ui_dragbox.scale.x = -1
	else: ui_dragbox.scale.x = 1
	
	if drag_rectangle_area.size.y < 0: 
		ui_dragbox.scale.y = -1
	else: ui_dragbox.scale.y = 1
	
