 #esse script trata das propriedas globais dos paineis
 #mais especificamente o tamanho do painel

extends Node2D

 #extração de variaveis externas >
var tratamentoResolucoes # invoca o script tratamentoResolucoes, responsavel pela resolucao e propoção da tela
var maior_lado # extrai a variavel maiorLadoBase do script tratamentoResolucoes
var menor_lado # extrai a variavel menorLadoBase do script tratamentoResolucoes
var proporcao # extrai a proporçãoBase do script tratamentoResolucoes
 #extracao de variaveis externas <

 #variaveis >
 #o tamanho do painel determina a medida painel, então quando se diz que o mapa tem 20 paineis de largura
 #ele terá 20 vezes o valor tamanho_painel em pixels.
 #logo 1 painel = tamanho_painel
var paineisPorTela # o número de paineis por tela, tanto horizontalmente como verticalmente. É importante ressaltar que isso é uma medida que representa o números de paineis numa tela por padrão. Esse valor não se altera se a camera ficar mais distante.
var tamanho_painel #tamanho do lado do painel em px
# #variaveis <

func _ready():

	#inicializa variaveis >
	paineisPorTela = 5 # inicializa o número de paineis por tela
	#inicializa variaveis <
	
	#captura os scripts externos >
	tratamentoResolucoes = get_node("/root/tratamentoResolucoes") #captura o script tratamentoResolucoes
	#captura os scripts externos <
	
	set_process(true)

	pass
	
func _process(delta):
	
	#atualiza os valores externos >
	menor_lado = tratamentoResolucoes.get_menor_lado_base() #captura o valor atual do menor lado
	proporcao = tratamentoResolucoes.get_proporcao_tela() #captura a proporção atual
	#atualiza os valores externos <
	
	#determina o tamanho do painel >
	tamanho_painel = menor_lado/paineisPorTela
	#determina o tamanho do painel <
	
	#debug >
#	print("menor lado: ",menor_lado)
#	print("proporção: ",proporcao)
#	print("tamanho do painel: ",tamanho_painel)
	#debug <
	
	pass
 #funções get >
func get_tamanho_painel():
	return tamanho_painel
  #funções get <

