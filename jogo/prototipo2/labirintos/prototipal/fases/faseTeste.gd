	#da atribuições gerais de cada fase, como a estamina total, além de posicionar o gato no mapa. Por padrão ele fica na posição 0,0, mas pode ser apropriado posicionar em outro lugar
extends Node2D

 # extração de variaveis externas >
var comida # invoca o script comida
var gatoGlobal # invoca o script gatoGlobal
var controlaFases # invoca o script controlaFases
var distanciaMaxima # invoca o script distanciaMaxima
 # extração de variaveis externas <

 #variaveis >
var gato # é o nó do gato
 #variaveis <

var mapa # é o mapa da fase
func _ready():

	# inicializa variaveis >
	mapa = get_node("/root/fase/mapa")
	comida = get_node("/root/comida")
	gatoGlobal = get_node("/root/gatoGlobal")
	gato = get_node("gatoPreguicoso")
	distanciaMaxima = get_node("/root/distanciaMaxima")
	controlaFases = get_node("/root/controlaFases")
	#inicializa variaveis >
	
	if(mapa != null):
		comida.gera_vetor_comida(mapa)
		comida.posiciona_comida(mapa)
		comida.limpa_vetor_comida()
		gatoGlobal.set_gato(gato)
		gatoGlobal.set_estamina_total(230)
		gatoGlobal.reset_estamina()
		gato.get_node("Sprite").set_texture(preload("res://prototipo2/gatoPreguicoso/textures/parado/baixo/gatoParadoBaixo1.png"))
		gato.get_node("AnimationPlayer").play("gatoParadoBaixo")
		controlaFases.set_mundo_atual("prototipal")
		controlaFases.set_numero_fase_atual(1)
		controlaFases.set_fase_atual(preload("res://prototipo2/labirintos/prototipal/fases/faseTeste.scn"))
		controlaFases.set_proxima_fase(preload("res://prototipo2/labirintos/prototipal/fases/faseTesteArmadilha.scn"))
		controlaFases.set_tela_vitoria(preload("res://prototipo2/telas/vitoria.scn"))
		controlaFases.set_tela_derrota(preload("res://prototipo2/telas/derrota.scn"))
		distanciaMaxima.determina_distancia_maxima(mapa)
#		print(posicaoComida)
#		print(filhos_mapa)
	pass


