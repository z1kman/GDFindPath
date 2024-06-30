extends Node

const M_C = preload("res://script/module_constants.gd")
const M_F_M = preload("res://script/module_file_manager.gd")

func  _ready() -> void:
	M_F_M.Print_All_File_In_Folder(M_C.PATH_FOLDER_DATA)
