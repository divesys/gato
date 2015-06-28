
extends Node2D


 #extração de variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var analisaPainel #invoca o script global analisaPainel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
var projecao #extrai a função projeção do projetarGato
var formaAnalisada #extrai a variavel formaPainelAnalisado do script analisaPainel
var analisando #extrai a variavel analisando do script analisaPainel
 #extração de variaveis externas <

 #variaveis >
var gato #captura o no do gato
var andando #verifica se o gato está andando entre os paineis
var esperaProximoMovimento #impede que o jogador mova qualquer direcao enquanto não terminar de se mover
var passosTotal #o numero de passos que o gato da entre os tiles ao andar normalmente, serve para fazer o looping de animação após o jogador apertar uma tecla de movimento
var passosRestantes #o numero de passos que falta para o gato andar
var numeroCasasAndar #é o numero de casas que o gato vai andar num único movimento
var timer #timer dos passos
var yieldTimer #timer usado pro yields que não são o do passo
var passosIntervalo #o intervalo entre um passo e outro
var esperaIntervalo #um timer para esperar um intervalo
var esperaTotal #é o tempo total que devera demorar para o gato andar
 #variaveis <

func _ready():

	set_process(true)
	
	#captura os scripts externos >
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
	analisaPainel = get_node("root/analisaPainel") #captura o script analisaPainel
	projecao = get_parent().get_node("projecao") #captura o nó projecao
	analisaPainel = get_node("/root/analisaPainel") #captura o script analisaPainel	
	#captura os scripts externos <
	
	#inicializa variaveis >
	andando = false
	esperaProximoMovimento = false
	passosTotal = 30
	passosRestantes = passosTotal
	esperaTotal = 0.1
	esperaIntervalo = float(esperaTotal)/float(passosTotal)
	numeroCasasAndar = 1
#	print(esperaTotal)
#	print(passosTotal)
#	print(esperaIntervalo)
	timer = Timer.new()
	yieldTimer = Timer.new()
	add_child(timer)
	add_child(yieldTimer)
	timer.set_one_shot(true)
	yieldTimer.set_one_shot(true)
	timer.set_wait_time(esperaIntervalo)
#	yieldTimer.set_wait_time(0.2)
	#inicializa variaveis <
	pass
	
func _process(delta):
	#atualiza os valores externos >
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	analisando = analisaPainel.get_analisando()
#	print(analisando)
	#atualiza os valores externos <
	
	#atualiza o nó gato >
	gato = get_parent()
	#atualiza o nó gato ,
	
#	print("andando:",andando)
#	print("espera:",esperaProximoMovimento)
#	print(yieldTimer.get_time_left())
	#move o gato pra cima >
	if(Input.is_action_pressed("ui_up")==true and andando == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,-1))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			while(passosRestantes > 0 and esperaProximoMovimento == true):
	#			print(passosRestantes)
				gato.translate(Vector2(0,(float(-tamanhoPainel)/passosTotal)))
				passosRestantes -= float(1)/numeroCasasAndar
	#			print(timer.get_wait_time())
				timer.start()
				yield(timer,"timeout")
	#			print(gato.get_pos())
				if(passosRestantes < 0):
					passosRestantes = 0
				if(passosRestantes == 0):
					esperaProximoMovimento = false
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))
		analisaPainel.reset_forma_painel_analisado()
#		print(gato.get_pos())
	#move o gato pra cima <

	#move o gato pra baixo >
	if(Input.is_action_pressed("ui_down")==true and andando == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,1))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			while(passosRestantes > 0 and esperaProximoMovimento == true):
				gato.translate(Vector2(0,float(tamanhoPainel)/passosTotal))
				passosRestantes -= float(1)/numeroCasasAndar
				timer.start()
				yield(timer,'timeout')
	#			print(passosRestantes)
				if(passosRestantes < 0):
					passosRestantes = 0
				if(passosRestantes == 0):
					esperaProximoMovimento = false
	#			print(gato.get_pos())
			passosRestantes = passosTotal
	#		print(gato.get_pos())
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))
		analisaPainel.reset_forma_painel_analisado()
	#move o gato pra baixo <

	#move o gato pra direita >
	if(Input.is_action_pressed("ui_right")==true and andando == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(1,0))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			while(passosRestantes > 0 and esperaProximoMovimento == true):
	#			print(passosRestantes)
				gato.translate(Vector2(float(tamanhoPainel)/passosTotal,0))
				passosRestantes -= float(1)/numeroCasasAndar
				timer.start()
				yield(timer,'timeout')
	#			print(gato.get_pos())
				if(passosRestantes < 0):
					passosRestantes = 0
				if(passosRestantes == 0):
					esperaProximoMovimento = false
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))
	#		print(gato.get_pos())
		analisaPainel.reset_forma_painel_analisado()
	#move o gato pra direita <
	
	#move o gato pra esquerda >
	if(Input.is_action_pressed("ui_left")==true and andando == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(-1,0))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			while(passosRestantes > 0 and esperaProximoMovimento == true):
	#			print(passosRestantes)
				gato.translate(Vector2(float(-tamanhoPainel)/passosTotal,0))
				passosRestantes -= float(1)/numeroCasasAndar
				timer.start()
				yield(timer,'timeout')
	#			print(gato.get_pos())
				if(passosRestantes < 0):
					passosRestantes = 0
				if(passosRestantes == 0):
					esperaProximoMovimento = false
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))
	#		print(gato.get_pos())
		analisaPainel.reset_forma_painel_analisado()
	#move o gato pra esquerda <
	
	#libera o movimento <
	if ((Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and Input.is_action_pressed("ui_right")==false and Input.is_action_pressed("ui_left")==false and andando==true)):
		andando = false
#		print("aqui")
	#libera o movimento <
	
	set_pos(gato.get_pos()) #atualiza a posição do script em relação ao gato