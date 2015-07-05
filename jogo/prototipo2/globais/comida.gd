	#esse script posiciona a comida no mapa e escolhe o sprite da mesma, assim como determina a distancia da comida
	
extends Node2D

 #variaveis >
#var mapa #o nó do mapa do jogo
var filhos_mapa #numero de nós filhos no mapa
var painelAnalisado #é o painel que está sendo analisado no momento
var vetorComida = [] #é o vetor dos posiveis paineis de comida
var comidaCena #é o cena da comida que é instaciada no mapa
var comida #é o nó da comida que é instaciada no mapa
var indexComida #é a index da comida no vetorComida
var posicaoComida #é a posição da comida, em pixels
#var comidaPosicionada #verifica se a comida já foi posicionada
 #variaveis >
#
func _ready():
	pass
#	set_process(true)
	
#	comidaPosicionada = false
	#atualiza valores >
#	mapa = get_node("/root/fase/mapa")
#	if(mapa != null and comidaPosicionada == false):
#		filhos_mapa = mapa.get_child_count()

#		gera_vetor_comida()
#		posiciona_comida()		
#		comidaPosicionada = true
#		print(posicaoComida)
#		print(filhos_mapa)
#	print(filhos_mapa)
	#atualiza valores <
func gera_vetor_comida(mapa):
	filhos_mapa = mapa.get_child_count()
	for i in range(filhos_mapa):
		painelAnalisado = mapa.get_child(i)
		if(painelAnalisado.is_in_group("painel")):
			if(painelAnalisado.get_passivel_comida() == true):
#				print(Vector2(painelAnalisado.get_pos().x/216,painelAnalisado.get_pos().y/216))
				vetorComida.push_back(painelAnalisado.get_pos())
				
func limpa_vetor_comida():
	vetorComida.clear()
				
func posiciona_comida(mapa):
	comidaCena = preload("res://prototipo2/comida/comida.scn")	
	randomize()
	indexComida = randi() % vetorComida.size()
	comida = comidaCena.instance()
	mapa.add_child(comida)
	posicaoComida = vetorComida[indexComida]
	comida.set_pos(posicaoComida)

	
func get_posicao_comida():
	return posicaoComida
	
#func set_comida_posicionada(valor):
#	comidaPosicionada = valor