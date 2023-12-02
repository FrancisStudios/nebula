extends Node

# GLOBALS
var ENVIRONMENT = ENV.DEV
var GAMEMODE = GAMEMODES.SINGLEPLAYER

var CONFIGURATION_FILE
var CONFIG

func _ready():
	match ENVIRONMENT:
		ENV.PROD:
			pass
		ENV.DEV:
			CONFIGURATION_FILE = "res://src/conf/config.json"
		ENV.TEST:
			CONFIGURATION_FILE = "res://src/conf/config.json"
	
	CONFIG = IO.load_json_file(CONFIGURATION_FILE)

# ENUMS
enum ENV { PROD, DEV, TEST }
enum GAMEMODES { SINGLEPLAYER, MULTIPLAYER }
