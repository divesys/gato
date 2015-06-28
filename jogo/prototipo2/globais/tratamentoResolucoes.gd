 #esse script trata das resoluções e proporções da tela do jogo, ele determina o menor lado e também a proporção ideal

extends Node

 #variaveis >
var resolucaoAtual
var proporcaoTelaAtual #determina a proporção entre a resolução maior e a menor, tal valor sera usado para determinar qual é a resolução de base (por exemplo, se o resultado for igual a 16/9 então devera ser usada a resolução 1920/1080 e por consequencia o painel tera 216 de lado, visto que é 1080/5 (o menor tamanho/5) )
var proporcaoTelaBase #determina qual proporcaoTela devera ser usada como base
var orientacaoTela #paisagem ou retrato
var menorLadoAtual #é o menor lado da resolução atual
var maiorLadoAtual #é o maior lado da resolução atual
var menorLadoBase #é o menor lado da resolução de base
var maiorLadoBase #é o maior lado da resolução de base
var forcarOrientacao #se verdadeiro, a orientação determinada pelo úsuario ira ser forçada, ou seja, ira ingorar a verdadeira orientação da tela
var forcarProporcao #se verdadeiro, a proporção determinada pelo úsurio ira ser forçada, ou seja, ira ignorar a verdadeira proporção da tela (nesse caso ele ira determinar a resolução numa lista e o sistema ira escolher a proporção apropiada, isso devera ser resolvido num script externo)

 #constantes >
const MAIOR_LADO_BASE = 1920
const proporcaoTela_16_9 = floor((float(16)/float(9))*10) #a resolução base dessa proporção é 1920X1080
const MENOR_LADO_16_9 = 1080
const proporcaoTela_16_10 = floor((float(16)/float(10))*10) #a resolução base dessa proporção é 1920X1200
const MENOR_LADO_16_10 = 1200
const proporcaoTela_4_3 = floor((float(4)/float(3))*10) #a resolução base dessa proporção é 1920X1440
const MENOR_LADO_4_3 = 1440
const proporcaoTela_3_2 = floor((float(3)/float(2))*10) #a resolução de base dessa proporção é 1920X1280
const MENOR_LADO_3_2 = 1280
 #constantes <

func _ready():
	
	set_process(true)
	
	pass
	
func _process(delta):

	#captura a resolucao do sistema >
	resolucaoAtual = Vector2(OS.get_window_size().x,OS.get_window_size().y)
#	resolucaoAtualX = OS.get_window_size().x #captura a largura do sistema
#	resolucaoAtualY = OS.get_window_size().y #captura a altura do sistema
	#captura a resolucao do sistema <
	
	#determina a proporção atual baseada no maior lado/menor lado >
	if(resolucaoAtual.x > resolucaoAtual.y):
		proporcaoTelaAtual = floor((resolucaoAtual.x/resolucaoAtual.y)*10)
		menorLadoAtual = resolucaoAtual.y
		maiorLadoAtual = resolucaoAtual.x
		orientacaoTela = "paisagem"
	elif(resolucaoAtual.x < resolucaoAtual.y):
		proporcaoTelaAtual = floor((resolucaoAtual.y/resolucaoAtual.x)*10)
		menorLadoAtual = resolucaoAtual.x
		maiorLadoAtual = resolucaoAtual.y
		orientacaoTela = "retrato"
	#determina a proporção atual baseada no maior lado/menor lado <
	
	#determina a proporção de base >
	maiorLadoBase = MAIOR_LADO_BASE
	if(proporcaoTelaAtual == proporcaoTela_16_9):
		proporcaoTelaBase = "16:9"
		menorLadoBase = MENOR_LADO_16_9
	elif(proporcaoTelaAtual == proporcaoTela_16_10):
		proporcaoTelaBase = "16:10"
		menorLadoBase = MENOR_LADO_16_10
	elif(proporcaoTelaAtual == proporcaoTela_4_3):
		proporcaoTelaBase = "4:3"
		menorLadoBase = MENOR_LADO_4_3
	elif(proporcaoTelaAtual == proporcaoTela_3_2):
		proporcaoTelaBase = "3:2"
		menorLadoBase = MENOR_LADO_3_2
	elif(proporcaoTelaAtual > proporcaoTela_4_3 and proporcaoTelaAtual <= proporcaoTela_3_2):
		proporcaoTelaBase = "3:2"
		menorLadoBase = MENOR_LADO_3_2
	elif(proporcaoTelaAtual > proporcaoTela_16_9):
		proporcaoTelaBase = "16:9"
		menorLadoBase = MENOR_LADO_16_9
	elif(proporcaoTelaAtual < proporcaoTela_4_3):
		proporcaoTelaBase = "4:3"
		menorLadoBase = MENOR_LADO_4_3
	else:
		proporcaoTelaBase = "erro"
		menorLadoBase = null
	#determina a proporção de base <
	
	if(orientacaoTela == "paisagem"):
		get_tree().set_screen_stretch(1,2,Vector2(maiorLadoBase,menorLadoBase))
	elif(orientacaoTela == "retrato"):
		get_tree().set_screen_stretch(1,3,Vector2(menorLadoBase,maiorLadoBase))
	
	#testes de resolução >
#	print("resolução atual x: ",resolucao_atual_x)
#	print("resolução atual y: ",resolucao_atual_y)
#	print("proporção atual: ",proporcaoTela_atual)
#	print("proporção de base: ",proporcaoTela_base)
#	print("proporção 16/9: ",proporcaoTela_16_9)
#	print("proporção 16/10: ",proporcaoTela_16_10)
#	print("proporção 4/3: ",proporcaoTela_4_3)
#	print("proporção 3/2: ",proporcaoTela_3_2)
#	print("menor lado: ",menor_lado)
#	print("orientação da tela: ",orientacaoTela)
	#testes de resolução <

 #funções get >
func get_menor_lado_atual():
	return menorLadoAtual
	
func get_maior_lado_atual():
	return maiorLadoAtual

func get_menor_lado_base():
	return menorLadoBase

func get_maior_lado_base():
	return maiorLadoBase
	
func get_proporcao_tela():
	return proporcaoTelaBase
	
func get_orientacao_tela():
	return orientacaoTela
	
func get_forcar_orientacao():
	return forcarOrientacao
	
func get_forcar_proporcao():
	return forcarProporcao
 #funções get <

#funções set >
func set_forcar_orientacao(valor,orientacao):
	forcarOrientacao = valor
	orientacaoTela = orientacao
	
func set_forcar_proporcao(valor,proporcao):
	forcarProporcao = valor
	proporcaoTelaBase = proporcao
#funções set <