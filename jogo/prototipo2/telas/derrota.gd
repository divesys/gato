
extends TextureFrame

var fase
var gatoGlobal
var estamina

func _ready():


	set_process(true)
	get_node("MenuContinuar/MenuContinuar_Continuar").grab_focus()
	get_node("/root/gatoGlobal")
#	print("derrotado")
	

func _process(delta):
	fase = get_node("/root/controlaFases").get_fase_atual()
	var confirmar = Input.is_action_pressed("ui_accept")
	var continuar = get_node("MenuContinuar/MenuContinuar_Continuar").has_focus()
	var sair = get_node("MenuContinuar/MenuContinuar_Sair").has_focus()
	
	if (continuar == true):
	
		if (confirmar == true):
	
			get_tree().change_scene_to(fase)
			
	elif (sair == true):
	
		if(confirmar == true):
		
			OS.get_main_loop().quit()
