	#esse script cuida do posicionamento do painel direito
extends Panel

 #extração de variaveis externas >
var detectaComida # invoca o script gatoGlobal
var distancia # extrai a variavel estamina do script gatoGlobal
 #extração de variaveis externas <

func _ready():
	set_process(true)
	detectaComida = get_node("/root/fase/gatoPreguicoso/detectaComida")
	#captura os scripts externos >
	#captura os scripts externos <
	pass

func _process(delta):
	if(detectaComida != null):
		distancia = detectaComida.get_distancia_comida()
		get_node("distanciaComida/distanciaComidaValor").set_text(var2str(distancia	))