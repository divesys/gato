#esse script da os atributos gerais a todas as casas (ou seja, atributos que não existem nas paredes), essa cena só funciona perfeitamente instanciada a um painel e não tem menor sentido de existencia sem ser dessa forma

extends Node2D

 #extração de variaveis externas >
#var painel #invoca o script painel.gd, responsavel pela base de todos paineis do jogo
 #extração de variaveis externas <

 #variaveis >
export(int) var exaustao #valor de exaustao de uma casa qualquer
export(String, "prototipo","natural","luxuoso") var categoria #categoria do painel, utilizada por certas habilidades e efeitos
#quanto aos sentidos de entrada: livre = todas direções validas, vertical = cima e baixo, horizontal = esquerda e direita. além disso, temos cima,baixo,esquerda e direita(que só permite essas direções) e não-cima,não-baixo,não-esquerda e não-direita(que não permite apenas essas direções)
export(String,"livre","não-cima","não-baixo","não-esquerda","não-direita","vertical","horizontal","cima-esquerda","cima-direita","baixo-esquerda","baixo-direita","cima","baixo","esquerda","direita") var sentidoEntrada #determina quais são os sentidos de entrada validos 
export(String,"comum","armadilha","gatilho","efeito","recuperação","deslocamento","elevador") var tipo
 #variaveis <

func _ready():

#	painel = get_parent() #captura o script painel, que deve ser o pai desse nó, SEMPRE
#	set_process(true)
	pass

#func _process(delta):

	#tratamento de erros >
	#tratamento de erros <

	#debug >
#	print("exaustão: ",exaustao)
#	print("categoria: ",categoria)
#	print("sentido de entrada: ",sentidoEntrada)
	#debug <

#	pass

 #funções get >
func get_exaustao():
	return exaustao
	
func get_categoria():
	return categoria
	
func get_sentidoEntrada():
	return sentidoEntrada
 #funções get <

 #funções set >
func set_exaustao(novaExaustao):
	exaustao = novaExaustao
	
func set_categoria(novaCategoria):
	categoria = novaCategoria
	
func set_sentidoEntrada(novoSentidoEntrada):
	sentidoEntrada = novoSentidoEntrada
 #funções set <