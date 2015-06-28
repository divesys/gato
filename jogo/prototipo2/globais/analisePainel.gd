#esse script recebe os dados do atual painel da projeção para poder passar para os outros scripts

extends Node2D

 #extração de variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
var ajustaInterface #invoca o script ajustaInterface
var correcaoPosicao #extrai a variavel correcaoPosicao do script ajustaInterface 
 #extração de variaveis externas <

 #variaveis >
var analisando #booleano que notifica ao jogo que o painel ainda está sendo analisado, impedindo assim que qualquer ação dependente dessa analise seja tomada antes de obter a resposta
 #as variaveis a seguir são os valores que do painel que a projeção pode receber, não sera considerado o valor do painel onde a projeção se encontra se ela estiver na mesma posição que o gato, pois ela sempre retorna para essa posição apos fazer a analise(mas não atualiza os valores desse script)
var formaPainelAnalisado #recebe a forma do painel onde se encontra a projeção.
var mapa #o nó do mapa do jogo
var filhos_mapa #numero de nós filhos no mapa
var posicaoInicial #é a coordenada REAL da coordenada 0,0 com a medida paineis
var coordenadaPainel #a posição do paineis usando a medida paineis, a coordenada x é a coluna, a y e a linhae  a z é o andar
var posicaoPainelProcurado #é a posição do que está sendo procurado, em pixels
var painelAnalisado #é o painel que está sendo analisado no momento
 #variaveis <

func _ready():
	set_process(true)
	#captura os scripts externos >
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
	ajustaInterface = get_node("/root/ajustaInterface") #captura o script tratamentoResolucoes
	#captura os scripts externos <
	
	#inicializa valores padrões >
	mapa = get_node("/root/mapa")
	if(mapa != null):
		filhos_mapa = mapa.get_child_count()
	analisando = false
	#inicializa valores padrões <

func _process(delta):
	#atualiza os valores externos >
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	correcaoPosicao = ajustaInterface.get_correcao_posicao()
	#atualiza os valores externos <
	
	#seta a posição inicial >
	posicaoInicial = Vector2(correcaoPosicao.x,correcaoPosicao.y)
	#seta a posição inicial <
	
	#seta as coordenadas do painel (usando a medida paineis) >
	coordenadaPainel = Vector2((get_pos().x-posicaoInicial.x)/tamanhoPainel,(get_pos().y-posicaoInicial.y)/tamanhoPainel)
	#seta as coordenadas do painel (usando a medida paineis) <
	
func get_painel_pela_posicao(posicao_gato,posicao_painel): #acha um painel a (x,y) de distancia da posição do gato, em tiles
	posicaoPainelProcurado = Vector2(posicao_gato.x + (tamanhoPainel * posicao_painel.x) , posicao_gato.y + (tamanhoPainel *  posicao_painel.y))
	for i in range(filhos_mapa):
		painelAnalisado = mapa.get_child(i)
		if(painelAnalisado.is_in_group("painel")):
			if(painelAnalisado.get_pos() == posicaoPainelProcurado):
				formaPainelAnalisado = painelAnalisado.get_forma_painel()
 #funções get >
func get_analisando():
	return analisando

func get_forma_painel_analisado():
	return formaPainelAnalisado
 #funções get >	

 #funções set >
func set_analisando(estado):
	analisando = estado

func set_forma_painel_analisado(forma):
	formaPainelAnalisado = forma
 #funções set <

#funções reset >
func reset_forma_painel_analisado():
	formaPainelAnalisado = null
#funções reset <