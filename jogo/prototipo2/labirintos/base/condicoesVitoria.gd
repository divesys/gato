
extends Node2D

var gatoGlobal
var estamina
var detectaComida
var distanciaComida

export(bool) var vitoriaDetectarComida
export(bool) var derrotaSemEstamina

func _ready():
	gatoGlobal = get_node("/root/gatoGlobal")
	estamina = gatoGlobal.get_estamina()
	detectaComida = get_parent().get_node("gatoPreguicoso/detectaComida")
	set_process(true)
	
func _process(delta):
	pass