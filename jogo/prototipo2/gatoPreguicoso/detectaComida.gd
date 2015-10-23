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
var distanciaComidaAnterior #é a distancia anterior da comida, em paineis
var distanciaComidaAtual #é a distancia atual da comida, em paineis
var aproximacaoComida #indica se a comida está mais distante ou mais proxima, vai ser usado quente ou frio para isso
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
		distanciaComidaAtual = posicaoGato.distance_to(posicaoComida)/tamanhoPainel
#		print(distanciaComida)
	#calcula a distancia da comida em paineis <
	#verifica se o gato acho a comida >
	if(distanciaComidaAtual == 0):
		get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina_total())
#		get_node("/root/comida").set_comida_posicionada(false)
		get_tree().change_scene_to(telaVitoria)
	
	if(distanciaComidaAnterior != null and distanciaComidaAtual != null):
		if(distanciaComidaAtual < distanciaComidaAnterior):
			aproximacaoComida = "quente" # o gato se aproximou da comida
		elif(distanciaComidaAtual > distanciaComidaAnterior):
			aproximacaoComida = "frio" # o gato se afastou da comida
		elif(distanciaComidaAtual == distanciaComidaAnterior):
			aproximacaoComida = "morno" # o gato não se moveu
	
#	print(aproximacaoComida)
#	print("atual: ", distanciaComidaAtual)
#	print("anterior: ", distanciaComidaAnterior)
		
 # funções get >
func get_distancia_comida_anterior():
	return distanciaComidaAnterior
	
func get_distancia_comida_atual():
	return distanciaComidaAtual
	
func get_aproximacao_comida():
	return aproximacaoComida
 # funções get >

 # funções set >
func set_distancia_comida_anterior(distancia):
	distanciaComidaAnterior = distancia
 # funções set <