	#esse script cuida do posicionamento do painel direito
extends Panel

 #extração de variaveis externas >
var detectaComida # invoca o script detectaComida
var scriptDistanciaMaxima # invoca o script distanciaMaxima
var distanciaAtual # extrai a variavel distanciaAtual do script detectaComida
var aproximacaoComida # extrai a variavel aproximacaoComida do script detectaComida
var distanciaMaxima # extrai a variabel distanciaMaxima do script distanciaMaxima
 #extração de variaveis externas <

 # variaveis >
var medidorDistancia # representa o sensor de distancia
var quente # representa o circulo do quente
var frio # representa o circulo do frio
var mapa # é o mapa da fase
var corVermelha # quantidade de vermelhor
var corAzul # quantidade de azul
 # variaveis <

 # constantes >
const CORVERDE = 0 # quantidade de verde
const AZULDISTMAXIMA = 1 # valor do azul na distancia maxima
 # constantes <

func _ready():
	set_process(true)
	#captura os scripts externos >
	detectaComida = get_node("/root/fase/gatoPreguicoso/detectaComida")
	quente = get_node("sensorComida/quente")
	frio = get_node("sensorComida/frio")
	medidorDistancia = get_node("sensorComida/medidorDistancia")
	scriptDistanciaMaxima = get_node("/root/distanciaMaxima")
	#captura os scripts externos <

func _process(delta):

	if(scriptDistanciaMaxima.get_distancia_maxima() != null):
		distanciaMaxima = scriptDistanciaMaxima.get_distancia_maxima()
		
	if(detectaComida != null):
		distanciaAtual = detectaComida.get_distancia_comida_atual()
		aproximacaoComida = detectaComida.get_aproximacao_comida()
	
	# cria a funcionalidade de quente ou frio no sensor de comida >
	if(aproximacaoComida == "quente"):
		quente.set_modulate(Color(255,0,0))
		frio.set_modulate(Color(255,255,255))
	elif(aproximacaoComida == "frio"):
		quente.set_modulate(Color(255,255,255))
		frio.set_modulate(Color(0,0,255))
	elif(aproximacaoComida == "morno"):
		quente.set_modulate(Color(255,255,255))
		frio.set_modulate(Color(255,255,255))
	# cria a funcionalidade de quente ou frio no sensor de comida <
	
	# cria a funcionalidade de medir a distancia da comida atraves de um gradiente de cores >
	if(distanciaAtual > 0):
		if(distanciaMaxima != null):
			corAzul = float(distanciaAtual*AZULDISTMAXIMA/distanciaMaxima)
			corVermelha = AZULDISTMAXIMA - corAzul
	elif(distanciaAtual == 0):
		corAzul = 0
		corVermelha = 255
	if(distanciaMaxima != null):
		medidorDistancia.set_modulate(Color(corVermelha,CORVERDE,corAzul))
	print(medidorDistancia.get_modulate())
	# cria a funcionalidade de medir a distancia da comida atraves de um gradiente de cores <
	
#	print(distanciaMaxima)
	
