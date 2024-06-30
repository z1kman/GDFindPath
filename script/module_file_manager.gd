extends RefCounted

static func Print_File(filepath: String) -> void:
	var text: String = FileAccess.open(filepath, FileAccess.READ).get_as_text()
	print(text)
	
static func Print_All_File_In_Folder(filepath_folder: String) -> void:
	for file in DirAccess.get_files_at(filepath_folder):
		print(file)
		Print_File(filepath_folder + file)
		

