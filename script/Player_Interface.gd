extends Node2D

# Nodes
@onready var player_camera: Node3D = $"../cameraBase"
@onready var player_camera_visibleunit_Aread3D: Area3D = $"../cameraBase/visibleunits_area3D"
@onready var ui_select_rectangle: NinePatchRect = $ui_dragbox

# Variables
@onready var BoxSelectionUnits_Visible: Dictionary = {}

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
	ui_select_rectangle.visible = false
	player_camera_visibleunit_Aread3D.body_entered.connect(unit_entered)
	player_camera_visibleunit_Aread3D.body_exited.connect(unit_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
