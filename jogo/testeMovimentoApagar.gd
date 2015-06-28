
extends KinematicBody2D


 #extração de variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
 #extração de variaveis externas <

 #variaveis >
var andando #verifica se o gato está andando entre os paineis
var esperaProximoMovimento #impede que o jogador mova qualquer direcao enquanto não terminar de se mover
var passosTotal #o numero de passos que o gato da entre os tiles ao andar normalmente, serve para fazer o looping de animação após o jogador apertar uma tecla de movimento
var passosRestantes #o numero de passos que falta para o gato andar
var timer
var passosIntervalo #o intervalo entre um passo e outro
var esperaIntervalo #um timer para esperar um intervalo
var esperaTotal #é o tempo total que devera demorar para o gato andar
 #variaveis <

func _ready():

	set_process(true)
	
	#captura os scripts externos >
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
	#captura os scripts externos <
	
	#inicializa variaveis >
	andando = false
	esperaProximoMovimento = false
	passosTotal = 10
	passosRestantes = passosTotal
	esperaTotal = 0.5
	esperaIntervalo = esperaTotal/passosTotal
	timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(false)
	timer.set_wait_time(esperaIntervalo)
	#inicializa variaveis <
	pass
	
func _process(delta):
	#atualiza os valores externos >
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	#atualiza os valores externos <
	
#	print("andando:",andando)
#	print("espera:",esperaProximoMovimento)

	#move o gato pra cima >
	if(Input.is_action_pressed("ui_up")==true and andando == false and esperaProximoMovimento == false):
		andando = true
		esperaProximoMovimento = true
#		print("antes aqui")
		while(passosRestantes > 0 and esperaProximoMovimento == true):
#			print(passosRestantes)
			translate(Vector2(0,float(-tamanhoPainel)/passosTotal))
			passosRestantes -= 1
			timer.start()
			yield(timer,'timeout')
			print(get_pos())
			if(passosRestantes == 0):
				esperaProximoMovimento = false
		passosRestantes = passosTotal
		set_pos(Vector2(get_pos().x,round(get_pos().y)))
#		print(get_pos())
	#move o gato pra cima <

	#move o gato pra baixo >
	if(Input.is_action_pressed("ui_down")==true and andando == false and esperaProximoMovimento == false):
		andando = true
		esperaProximoMovimento = true
#		print("antes aqui")
		while(passosRestantes > 0 and esperaProximoMovimento == true):
#			print(passosRestantes)
			translate(Vector2(0,float(tamanhoPainel)/passosTotal))
			passosRestantes -= 1
			timer.start()
			yield(timer,'timeout')
			print(get_pos())
			if(passosRestantes == 0):
				esperaProximoMovimento = false
		passosRestantes = passosTotal
		set_pos(Vector2(get_pos().x,round(get_pos().y)))
#		print(get_pos())
	#move o gato pra baixo <

	#move o gato pra direita >
	if(Input.is_action_pressed("ui_right")==true and andando == false and esperaProximoMovimento == false):
		andando = true
		esperaProximoMovimento = true
#		print("antes aqui")
		while(passosRestantes > 0 and esperaProximoMovimento == true):
#			print(passosRestantes)
			translate(Vector2(float(tamanhoPainel)/passosTotal,0))
			passosRestantes -= 1
			timer.start()
			yield(timer,'timeout')
			print(get_pos())
			if(passosRestantes == 0):
				esperaProximoMovimento = false
		passosRestantes = passosTotal
		set_pos(Vector2(get_pos().x,round(get_pos().y)))
#		print(get_pos())
	#move o gato pra direita <
	
	#move o gato pra esquerda >
	if(Input.is_action_pressed("ui_left")==true and andando == false and esperaProximoMovimento == false):
		andando = true
		esperaProximoMovimento = true
#		print("antes aqui")
		while(passosRestantes > 0 and esperaProximoMovimento == true):
#			print(passosRestantes)
			translate(Vector2(float(-tamanhoPainel)/passosTotal,0))
			passosRestantes -= 1
			timer.start()
			yield(timer,'timeout')
			print(get_pos())
			if(passosRestantes == 0):
				esperaProximoMovimento = false
		passosRestantes = passosTotal
		set_pos(Vector2(get_pos().x,round(get_pos().y)))
#		print(get_pos())
		
	if ((Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and Input.is_action_pressed("ui_right")==false and Input.is_action_pressed("ui_left")==false and andando==true)):
		andando = false
#		print("aqui")
	#move o gato pra esquerda <