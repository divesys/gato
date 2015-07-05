	#esse script lida com o sistema de detecção de comida e sua distancia
extends Node2D

 #extração de variaveis externas >
var comida #invoca o script global comida
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
var posicaoComida #extrai a variavel posicaoComida do script comida
 #extração de variaveis externas <

 #variaveis >
var posicaoGato #é a posição do gato
var distanciaComida #é a distancia da comida, em paineis
var telaVitoria
 #variaveis <

func _ready():

	set_process(true)
	
func _process(delta):

	#atualiza os valores externos >
	comida = get_node("/root/comida")
	painelGlobal = get_node("/root/painelGlobal")
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	posicaoComida = comida.get_posicao_comida()
	telaVitoria = get_node("/root/controlaFases").get_tela_vitoria()
	#atualiza os valores externos >
	
	#calcula a distancia da comida em paineis >
	if(get_node("/root/fase/mapa") != null):
		posicaoGato = get_parent().get_pos()
#		print(posicaoGato)
#		print(posicaoComida)
		distanciaComida = round(posicaoGato.distance_to(posicaoComida)/tamanhoPainel)
#		print(distanciaComida)
	#calcula a distancia da comida em paineis <
	#verifica se o gato acho a comida >
	if(distanciaComida == 0):
		get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina_total())
#		get_node("/root/comida").set_comida_posicionada(false)
		get_tree().change_scene_to(telaVitoria)
		
 #funções get >
func get_distancia_comida():
	return distanciaComida
 #funções get >