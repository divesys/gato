
extends Node2D

var perdaExaustao = 60

func ativa_armadilha():
	get_parent().set_ativada(true)
	get_node("spriteAlcapao/AnimationPlayer").play("moverAlcapao")
	get_parent().get_parent().get_parent().set_forma_painel("abismo")