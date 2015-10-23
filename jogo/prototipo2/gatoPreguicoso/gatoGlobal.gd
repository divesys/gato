 #guarda valores importantes do gato que precisam de acesso global, como sua estamina

extends Node2D

 #extração de variaveis externas >
var ajustaInterface #invoca o script ajustaInterface
var correcaoPosicao #extrai a variavel correcaoPosicao do script ajustaInterface
var telaDerrota #leva até a tela de derrota
 #extração de variaveis externas <

 #variaveis >
var gato # é o nó do gato
var estaminaTotal #a estamina total do gato
var estamina #a estamina atual do gato
var estaminaHUD # PROVISORIO!!!!!! estamina do HUD
var posicaoInicial #a posição inicial do gato, em paineis. Por padrão é 0,0 mas pode ser sobreposta pela fase se assim for decidido
var estado # é o estado atual do gato (andando, caindo no buraco, pulando etc)
var direcao # é a direção para aonde o gato está virado
var travado # se o gato está travado para se mover
var emJogo # verifica se o gato está em jogo
var ativandoArmadilha
var timer # um timer para poder esperar um tempo
var timerAdicionado # repreenta que o timer foi adicionado
 #variaveis <

func _ready():
	#captura os scripts externos <
	ajustaInterface = get_node("/root/ajustaInterface") #captura o script tratamentoResolucoes
	#captura os scripts externos <
	
	#inicializa variaveis >
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(0.4)
	travado = false
	direcao = "baixo"
	estaminaTotal = 230
	estamina = estaminaTotal
	ativandoArmadilha = false
	timerAdicionado = false
	#inicializa variaveis <
	
	set_process(true)

func _process(delta):

	telaDerrota = get_node("/root/controlaFases").get_tela_derrota()
	if(get_node("/root/fase/mapa") == null):
		emJogo = false
	elif(get_node("/root/fase/mapa") != null):
		emJogo = true
	if(estamina <= 0 and emJogo == true):
#		get_node("/root/comida").set_comida_posicionada(false)
		if(timerAdicionado == false):
			timerAdicionado = true
			add_child(timer)
			timer.start()
#			print(timer.get_time_left())
			yield(timer,'timeout')
			timerAdicionado = false
			get_tree().change_scene_to(telaDerrota)
		
	


 #funções get >
func get_estamina():
	return estamina
	
func get_estamina_total():
	return estaminaTotal
	
func get_posicao_gato():
	gato.get_pos()
	
func get_estado():
	return estado
	
func get_direcao():
	return direcao

func get_travado():
	return travado
	
func get_ativando_armadilha():
	return ativandoArmadilha
	
func get_gato(): # retorna o nó do gato
	return gato
 #funções get <

 #funções set >
func set_estamina(valor):
	estamina = valor

func set_estamina_total(valor):
	estaminaTotal = valor
	
func set_gato(no): # seta o nó do gato
	gato = no
	
func set_estado(valor):
	estado = valor

func set_direcao(sentido):
	direcao = sentido
	
func set_travado(bolleano):
	travado = bolleano
	
func set_ativando_armadilha(bolleano):
	ativandoArmadilha = bolleano
 #funções set <

func reset_estamina():
	estamina = estaminaTotal