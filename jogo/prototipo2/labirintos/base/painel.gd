#esse script é a base dos paineis, sua principal função é passar para o mapa que existe um painel em certa posição
#além disso, ele ira passar para o mapa que aquele painel é uma parede ou uma casa

extends Node2D

 #extração de variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
var ajustaInterface #invoca o script ajustaInterface
var correcaoPosicao #extrai a variavel correcaoPosicao do script ajustaInterface 
var analisaPainel #invoca o script analisa painel 
 #extração de variaveis externas <

 #variaveis >
export(bool) var extremoSuperior # verdadeiro se for o painel extremo superior (o painel superior esquerdo)
export(bool) var extremoInferior # verdadeiro se for o painel extremo inferior (o painel inferior direito)
export(bool) var passivelComida #verifica se a casa é passivel de ter comida.
export(String, "parede","casa","abismo") var formaPainel #determina a forma do painel, que pode ser parede ou casa
export(String, "prototipal","castelo") var familia #determina a família do painel, basicamente é o tema e no momento tem uma função mais visual, porém podera ser bem útil num futuro editor de fases
export(String, "nenhuma","cima","baixo","esquerda","direita","vertical","horizontal","cima-esquerda","cima-direita","baixo-esquerda","baixo-direita","não-cima","não-baixo","não-esquerda","não-direita") var direcao #é a direção do painel, pode ter uma direção espeficica(cima,baixo,esquerda,direita) uma direção bilateral(vertical,horizontal) ou nenhum direção. A direção é utilizada em algumas paineis
export(float, 0,4,2) var numeroDirecoes # indica o numero de direcoes validas, pode ser 0,2 ou 4
export(bool) var girarComDirecao #gira 90 graus para paineis com quatro direções e espelha paineis com duas direções  
export(Vector3) var coordenadaPainel #a posição do paineis usando a medida paineis, a coordenada x é a coluna, a y e a linhae  a z é o andar
var temComida #verdadeiro se o painel tem a comida
var andarPainel #o andar onde se localiza o painel, por padrão esse valor é 1
var posicaoInicial #é a coordenada REAL da coordenada 0,0 com a medida paineis
 #variaveis <
func _ready():

	set_process(true)
	#inicializa valores padrões >
	andarPainel = 1
	coordenadaPainel = Vector3(0,0,andarPainel)
	#inicializa valores padrões <
	
	#captura os scripts externos >
	ajustaInterface = get_node("/root/ajustaInterface") #captura o script tratamentoResolucoes
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
	analisaPainel = get_node("/root/analisaPainel") #captura o script analisaPainel
	#captura os scripts externos <
	
	pass
	
func _process(delta):
	
	#atualiza os valores externos >
	correcaoPosicao = ajustaInterface.get_correcao_posicao()
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	#atualiza os valores externos <
	#seta a posição inicial >
	posicaoInicial = Vector2(0,0)
	#seta a posição inicial <
	
	#seta as coordenadas do painel (usando a medida paineis) >
	coordenadaPainel = Vector3((ceil(get_pos().x/tamanhoPainel)),ceil((get_pos().y)/tamanhoPainel),andarPainel)
#	print(coordenadaPainel)
	#seta as coordenadas do painel (usando a medida paineis) <
	#tratamento de erros >
	if(formaPainel == null):
		print("forma do painel ",get_name()," nula")
	elif(formaPainel != "casa" and formaPainel != "parede" and formaPainel != "abismo"):
		print("forma do painel ",get_name()," invalida")
	#tratamento de erros <
	
	
	#debug >
#	print("coordenada do ",get_name(),": ",coordenadaPainel)
#	print("forma do painel: ",formaPainel)
	#debug <
	pass

 #funções get >
func get_forma_painel():
	return formaPainel
	
func get_coordenada_painel():
	return coordenadaPainel
	
func get_passivel_comida():
	return passivelComida
	
func get_extremo_superior():
	return extremoSuperior
	
func get_extremo_inferior():
	return extremoInferior
 #funções get <

 #funções set >
func set_forma_painel(forma):
	formaPainel = forma
 #funções set <