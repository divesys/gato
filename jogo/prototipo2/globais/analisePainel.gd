#esse script recebe os dados do atual painel da projeção para poder passar para os outros scripts

extends Node2D

 #extração de variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
#var ajustaInterface #invoca o script ajustaInterface
#var correcaoPosicao #extrai a variavel correcaoPosicao do script ajustaInterface 
 #extração de variaveis externas <

 #variaveis >
var analisando #booleano que notifica ao jogo que o painel ainda está sendo analisado, impedindo assim que qualquer ação dependente dessa analise seja tomada antes de obter a resposta
 #as variaveis a seguir são os valores que do painel que a projeção pode receber, não sera considerado o valor do painel onde a projeção se encontra se ela estiver na mesma posição que o gato, pois ela sempre retorna para essa posição apos fazer a analise(mas não atualiza os valores desse script)
var formaPainelAnalisado #recebe a forma do painel analisado.
var coordenadaPainelAnalisado #receve a coordenada do painel analisado, em paineis.
var exaustaoCasaAnalisada #recebe a exaustão do painel analisado, se ele for uma casa
var tipoCasaAnalisada #recebe o tipo do painel analisado, se ele for uma casa
var gatilhoInternoArmadilhaAnalisada #recebe a armadilha analisada tem gatilho interno
var ativadaArmadihaAnalisada #recebe se a armadilha analisada está ativada
var mapa #o nó do mapa do jogo
var filhos_mapa #numero de nós filhos no mapa
#var posicaoInicial #é a coordenada REAL da coordenada 0,0 com a medida paineis
#var coordenadaPainel #a posição do paineis usando a medida paineis, a coordenada x é a coluna, a y e a linha
var posicaoPainelProcurado #é a posição do que está sendo procurado, em pixels
var painelAnalisado #é o painel que está sendo analisado no momento
var casaAnalisada #é a casa que está sendo analisada no momento
var armadilhaAnalisada #é a armadilha que está sendo analisada no momento
#var armadilhaEspecificaAnalisada #é o nó especifico da armadilha analisada, indiferente de qual seja.
 #variaveis <

func _ready():
	set_process(true)
	#captura os scripts externos >
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
#	ajustaInterface = get_node("/root/ajustaInterface") #captura o script tratamentoResolucoes
	#captura os scripts externos <
	
	#inicializa valores padrões >
#	print(filhos_mapa)
	analisando = false
	ativadaArmadihaAnalisada = false
	#inicializa valores padrões <

func _process(delta):
	#atualiza os valores externos >
	tamanhoPainel = painelGlobal.get_tamanho_painel()
#	correcaoPosicao = ajustaInterface.get_correcao_posicao()
	#atualiza os valores externos <
	
	#atualiza valores >
	mapa = get_node("/root/fase/mapa")
	if(mapa != null):
		filhos_mapa = mapa.get_child_count()
	#atualiza valores <
	
	#seta a posição inicial >
#	posicaoInicial = Vector2(correcaoPosicao.x,correcaoPosicao.y)
	#seta a posição inicial <
	
	#seta as coordenadas do painel (usando a medida paineis) >
#	coordenadaPainel = Vector2((get_pos().x-posicaoInicial.x)/tamanhoPainel,(get_pos().y-posicaoInicial.y)/tamanhoPainel)
	#seta as coordenadas do painel (usando a medida paineis) <
	
func get_painel_pela_posicao(posicao_gato,posicao_painel): #acha um painel a (x,y) de distancia da posição do gato, em tiles
	posicaoPainelProcurado = Vector2(posicao_gato.x + (tamanhoPainel * posicao_painel.x) , posicao_gato.y + (tamanhoPainel *  posicao_painel.y))
#	print(posicaoPainelProcurado)
	for i in range(filhos_mapa):
		painelAnalisado = mapa.get_child(i)
		if(painelAnalisado.is_in_group("painel")):
			if(painelAnalisado.get_pos() == posicaoPainelProcurado):
				formaPainelAnalisado = painelAnalisado.get_forma_painel()
#				print(painelAnalisado.get_name())
#				print(formaPainelAnalisado)
				coordenadaPainelAnalisado = painelAnalisado.get_coordenada_painel()
#				print("coordenadaPainelAnalisado", "    ", posicaoPainelProcurado)
				if(formaPainelAnalisado == "casa"):
					casaAnalisada = painelAnalisado.get_child(0)
#					print(casaAnalisada.get_name())
					exaustaoCasaAnalisada = casaAnalisada.get_exaustao()
#					print(exaustaoCasaAnalisada)
					tipoCasaAnalisada = casaAnalisada.get_tipo()
#					print(tipoCasaAnalisada)
					if(tipoCasaAnalisada == "armadilha"):
						armadilhaAnalisada = casaAnalisada.get_child(0)
						gatilhoInternoArmadilhaAnalisada = armadilhaAnalisada.get_gatilho_interno()
						if(gatilhoInternoArmadilhaAnalisada == true):
							ativadaArmadihaAnalisada = armadilhaAnalisada.get_ativada()
#							print(ativadaArmadihaAnalisada)


 #funções get >
func get_analisando():
	return analisando

func get_forma_painel_analisado():
	return formaPainelAnalisado
	
func get_exaustao_casa_analisada():
	return exaustaoCasaAnalisada
	
func get_tipo_casa_analisada():
	return tipoCasaAnalisada
	
func get_gatilho_interno_armadilha_analisada():
	return gatilhoInternoArmadilhaAnalisada
	
func get_ativada_armadilha_analisada():
	return ativadaArmadihaAnalisada

func get_no_painel():
	return painelAnalisado

func get_no_armadilha():
	return armadilhaAnalisada.get_child(0)
 #funções get >	

 #funções set >
func set_analisando(estado):
	analisando = estado

func set_forma_painel_analisado(forma):
	formaPainelAnalisado = forma
	
func set_exaustao_casa_analisada(exaustao):
	exaustaoCasaAnalisada = exaustao
	
 #funções set <

#funções reset >
func reset_painel_analisado():
	formaPainelAnalisado = null
	exaustaoCasaAnalisada = null
#funções reset <