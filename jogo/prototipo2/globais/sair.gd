
extends Node2D

func _ready():
	set_process(true)
	
func _process(delta):
	if(Input.is_action_pressed("sair") == true):
		OS.get_main_loop().quit()