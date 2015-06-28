
extends KinematicBody2D

 #extração de variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
 #extração de variaveis externas <

func _ready():

	set_process(true)
	
	#captura os scripts externos >
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
	#captura os scripts externos <
	
	set_pos(Vector2(0,0))
	
	pass
	
func _process(delta):
	#atualiza os valores externos >
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	#atualiza os valores externos <

func projetar(coordenada): #projeta a projeção a partir do gato usando a coordanada, em tiles
#	print(coordenada)
#	print(Vector2(coordenada.x * 216, coordenada.y * 216))
	set_pos(Vector2(coordenada.x * 216, coordenada.y * 216))
	
#func projetar_no_mapa(coordenada): #projeta a projeção a partir do tile 0,0 usando a coordenada, em tiles
#	set_global_pos(Vector2(coordenada.x * 216 + 20, coordenada.y * 216 + 32))
#	print(get_parent())
#	print(get_global_pos())