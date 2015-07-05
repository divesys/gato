
extends TextureFrame

var controlaFases

var fase

func _ready():

	set_process(true)
	
	get_node("MenuContinuar/MenuContinuar_Continuar").grab_focus()


func _process(delta):

	controlaFases = get_node("/root/controlaFases")
	var confirmar = Input.is_action_pressed("ui_accept")
	var continuar = get_node("MenuContinuar/MenuContinuar_Continuar").has_focus()
	var sair = get_node("MenuContinuar/MenuContinuar_Sair").has_focus()
	
	fase = controlaFases.get_proxima_fase()
	
	if (continuar == true):
	
		if (confirmar == true):
		
			get_tree().change_scene_to(fase)
			
	elif (sair == true):
	
		if(confirmar == true):
		
			OS.get_main_loop().quit()
