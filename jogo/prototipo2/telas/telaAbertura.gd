
extends TextureFrame

var fase1

func _ready():

	set_process(true)
	fase1 = preload("res://prototipo2/labirintos/prototipal/fases/faseTeste.scn")

func _process(delta):

	var confirmar = Input.is_action_pressed("ui_accept")
	
	if (confirmar == true):
		
		get_tree().change_scene_to(fase1)