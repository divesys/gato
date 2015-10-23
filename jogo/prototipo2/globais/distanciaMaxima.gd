	#determina a distancia maxima do mapa

extends Node2D

 #variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
 #variaveis externas <

 #variaveis >
var extremoSuperior # é o painel extremo superior
var extremoInferior # é o painel extremo inferior
var distanciaMaxima # é a distancia entre os paineis extremos
var filhos_mapa # numero de nós filhos no mapa
var painelAnalisado # é o painel que está sendo analisado no momento
 #variaveis <

func _ready():

	painelGlobal = get_node("/root/painelGlobal")
	
func determina_distancia_maxima(mapa):
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	filhos_mapa = mapa.get_child_count()
	for i in range(filhos_mapa):
		painelAnalisado = mapa.get_child(i)
		if(painelAnalisado.is_in_group("painel")):
			if(painelAnalisado.get_extremo_superior() == true):
				extremoSuperior = painelAnalisado.get_pos()
			elif(painelAnalisado.get_extremo_inferior() == true):
				extremoInferior = painelAnalisado.get_pos()
	distanciaMaxima = extremoSuperior.distance_to(extremoInferior)/tamanhoPainel
	
func get_distancia_maxima():
	return distanciaMaxima
	
func set_distancia_maxima(distancia):
	distanciaMaxima = distancia
	
