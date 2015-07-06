
extends Node2D

var animacaoGato # é o nó do gato

func _ready():
	animacaoGato = get_parent().get_node("AnimationPlayer")
	set_process(true)
	
func _process(delta):
	
	if(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_up")):
		get_node("/root/gatoGlobal").set_direcao("cima")
		animacaoGato.play("gatoParadoCima")
#		print(get_node("/root/gatoGlobal").get_direcao())

	elif(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_down")):
		get_node("/root/gatoGlobal").set_direcao("baixo")
		animacaoGato.play("gatoParadoBaixo")
#		print(get_node("/root/gatoGlobal").get_direcao())
		
	elif(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_left")):
		get_node("/root/gatoGlobal").set_direcao("esquerda")
		animacaoGato.play("gatoParadoEsquerda")
#		print(get_node("/root/gatoGlobal").get_direcao())
		
	elif(Input.is_action_pressed("travarGato") and Input.is_action_pressed("ui_right")):
		get_node("/root/gatoGlobal").set_direcao("direita")
		animacaoGato.play("gatoParadoDireita")
#		print(get_node("/root/gatoGlobal").get_direcao())