	#esse script é a base de todas as armadilhas
	
extends Node2D

 # variaveis >
export(bool) var gatilhoInterno # verdadeiro se o gatilho for interno
export(int, 1000) var indiceArmadilha # um indice numerico para perimitir que gatilhos externos ativem a armadilha
export(bool) var aerea # indica se a armadilha é ativadda pelo pulo
var ativada #verdadeiro se a armadilha foi ativada
 # variaveis <

func _ready():

	ativada = false

 # funções get >
func get_gatilho_interno():
	return gatilhoInterno
	
func get_indice_armadilha():
	return indiceArmadilha
	
func get_ativada():
	return ativada
	
func get_aerea():
	return aerea
 # funções get <

 # funções set >
func set_ativada(estado):
	ativada = estado
 # funções set <