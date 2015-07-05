
extends Node2D

func _ready():
	set_process(true)
	
func _process(delta):
	
	if(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_up")):
		get_node("/root/gatoGlobal").set_direcao("cima")
#		print(get_node("/root/gatoGlobal").get_direcao())

	elif(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_down")):
		get_node("/root/gatoGlobal").set_direcao("baixo")
#		print(get_node("/root/gatoGlobal").get_direcao())
		
	elif(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_left")):
		get_node("/root/gatoGlobal").set_direcao("esquerda")
#		print(get_node("/root/gatoGlobal").get_direcao())
		
	elif(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_right")):
		get_node("/root/gatoGlobal").set_direcao("direita")
#		print(get_node("/root/gatoGlobal").get_direcao())