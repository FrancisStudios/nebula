extends Node

var PATH_PREFIX = OS.get_executable_path().get_base_dir()

#Read up JSON dictionary:
func load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedFile = JSON.parse_string(dataFile.get_as_text())
		
		if parsedFile is Dictionary: return parsedFile
		else: print('File is invalid')
