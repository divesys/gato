  #esse script ajusta a posição da interface, basicamente posiciona as regiões maiores como os barras de GUI e a área do jogo

extends Node

 #extração de variaveis externas >
var tratamentoResolucoes # invoca o script tratamentoResolucoes, responsavel pela resolucao e propoção da tela
var painelGlobal # invoca o script painelGlobal, responsavel pelo tamanho do painel
var orientacaoTela # extrai a variavel orientacaoTela do script tratamentoResolucoes
var proporcaoTela # extrai a variavel proporcaoTela do script tratamentoResolucoes
var menorLadoBase # extrai a variavel menorLadoBase do script tratamentoResolucoes
var maiorLadoBase # extrai a variavel maiorLadoBase do script tratamentoResolucoes
var tamanhoPainel # extrai a variavel tamanhoPainel do script painelGlobal
 #extração de variaveis externas <

const areaDoJogo = 0 #apenas uma constante para determina que certo valor se refere a área do jogo
const barraDuplaA = 1 #apenas uma constante para determina que certo valor se refere a um dos paineis duplos (nesse caso o A)
const barralDuplaB = 2 #apenas uma constante para determina que certo valor se refere a um dos paineis duplos (nesse caso o B)
const barraUnica = 3 #apenas uma constante para determina que certo valor se refere a o painel único
const tamanhoPadraoNode2D = 64 #é o valor do tamanho de um node padrão, deve ser utilizado para ajustar as posições, visto que se queremos um elemento a x pixels da tela, deveremos adicionar metade desse valor, visto que a engine conta a apartir do centro


 #variaveis >
var numeroBarrasGUI # determina o número de barras laterais de GUI, pode ser 1 ou 2
var posicaoAreaJogo #determina se a área do jogo esta a esquerda, ao centro ou a direita
var extensaoAreaJogo #determina a extensão da área do jogo
var extensaoPainelUnico #determina a extensão do painel único
var extensaoPainelDuplo #determina a extensão do painel duplo
 #o sentido da sequencia das regiões é da esquerda para direita no caso de paisagem e de cima para baixo no caso de retrato
var elementoRegiaoA #determina qual elemento que se encaixa na primeira região da tela
var elementoRegiaoB #determina qual elemento que se encaixa na segunda região da tela
var elementoRegiaoC #determina qual elemento que se encaixa na terceira região da tela
var posicaoRegiaoA #determina a posição da região A
var posicaoRegiaoB #determina a posição da região B
var posicaoRegiaoC #determina a posição da região C
var extensaoRegiaoA #determina o tamanho da região A
var extensaoRegiaoB #determina o tamanho da região B
var extensaoRegiaoC #determina o tamanho da região C
var correcaoPosicao #determina a correção da posição, se nescessaria
 #variaveis <

func _ready():
	
	set_process(true)
	
	#captura os scripts externos >
	tratamentoResolucoes = get_node("/root/tratamentoResolucoes") #captura o script tratamentoResolucoes
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
	#captura os scripts externos <
	
	#valores quando não está sendo levada em consideração a orientação ou não se sabe
	#inicializa valores padrão >
	numeroBarrasGUI = 2
	posicaoAreaJogo = "centro"
	#inicializa valores padrão <
	pass
	
func _process(delta):

	#atualiza os valores externos >
	orientacaoTela = tratamentoResolucoes.get_orientacao_tela()
	proporcaoTela = tratamentoResolucoes.get_proporcao_tela()
	menorLadoBase = tratamentoResolucoes.get_menor_lado_base()
	maiorLadoBase = tratamentoResolucoes.get_maior_lado_base()
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	#atualiza os valores externos <
	
	extensaoAreaJogo = Vector2(menorLadoBase,menorLadoBase)
	
	if(orientacaoTela == "paisagem"):
		extensaoPainelUnico = Vector2(maiorLadoBase-menorLadoBase,menorLadoBase)
		extensaoPainelDuplo = Vector2((maiorLadoBase-menorLadoBase)/2,menorLadoBase)
		if(numeroBarrasGUI == 2):
			correcaoPosicao = Vector2((tamanhoPadraoNode2D/2) - ((ceil((extensaoPainelDuplo.x/tamanhoPainel))-(extensaoPainelDuplo.x/tamanhoPainel))*tamanhoPainel),tamanhoPadraoNode2D/2)
			if(posicaoAreaJogo == "centro"):
				elementoRegiaoA = barraDuplaA
				elementoRegiaoB = areaDoJogo
				elementoRegiaoC = barralDuplaB
				extensaoRegiaoA = extensaoPainelDuplo
				extensaoRegiaoB = extensaoAreaJogo
				extensaoRegiaoC = extensaoPainelDuplo
				posicaoRegiaoA = Vector2(correcaoPosicao.x,correcaoPosicao.y)
				posicaoRegiaoB = Vector2(correcaoPosicao.x + extensaoRegiaoA.x,correcaoPosicao.y)
				posicaoRegiaoC = Vector2(correcaoPosicao.x + (extensaoRegiaoA.x + extensaoRegiaoB.x),correcaoPosicao.y)
	#debug >
#	print("orientação da tela: ",orientacaoTela)
#	print("proporção da tela: ",proporcaoTela)
#	print("menor lado da tela: ",menorLadoBase)
#	print("maior lado da tela: ",maiorLadoBase)
#	print("tamanho do painel: ",tamanhoPainel)
#	print("elemento na região A: ",elementoRegiaoA)
#	print("elemento na região B: ",elementoRegiaoB)
#	print("elemento na região C: ",elementoRegiaoC)
#	print("extensão da região A: ",extensaoRegiaoA)
#	print("extensão da região B: ",extensaoRegiaoB)
#	print("extensão da região C: ",extensaoRegiaoC)
#	print("posição da região A: ",posicaoRegiaoA)
#	print("posição da região B: ",posicaoRegiaoB)
#	print("posição da região C: ",posicaoRegiaoC)
#	print("número de paineis: ",numeroBarrasGUI)
#	print("posição da área do jogo: ",posicaoAreaJogo)
#	print("tamanho do node 2d: ",tamanhoPadraoNode2D)
	#debug <
	
func get_correcao_posicao():
	return correcaoPosicao