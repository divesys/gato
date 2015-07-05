
extends Node2D


 #extração de variaveis externas >
var painelGlobal #invoca o script painelGlobal, responsavel pelo tamanho do painel
var analisaPainel #invoca o script global analisaPainel
var gatoGlobal #invoca o script global gatoGlobal
var tamanhoPainel #extrai a variavel tamanhoPainel do script painelGlobal
var exaustaoPainel #extrai a variavel exaustao
var formaAnalisada #extrai a variavel formaPainelAnalisado do script analisaPainel
var tipoCasaAnalisada #extrai a variavel tipoCasaAnalisada do script analisaPainel
var ativadaArmadilhaAnalisada #extrai a variavel do script analisaPainel
var noArmadilha # é o nó da armadilha analisada
var analisando #extrai a variavel analisando do script analisaPainel
var exaustao #extrai a variavel exaustão do script gatoGlobal
var direcao # extrai a variavel direção do script gatoGlobal
 #extração de variaveis externas <

 #variaveis >
var gato #captura o no do gato
var andando #verifica se o gato está andando entre os paineis
var esperaProximoMovimento #impede que o jogador mova qualquer direcao enquanto não terminar de se mover
var passosTotal #o numero de passos que o gato da entre os tiles ao andar normalmente, serve para fazer o looping de animação após o jogador apertar uma tecla de movimento
var passosRestantes #o numero de passos que falta para o gato andar
var numeroCasasAndar #é o numero de casas que o gato vai andar num único movimento
var timer #timer dos passos
var timerAnimacao #timer de espera entre animações, é uma gambiarra enquanto não acho solução melhor
var passosIntervalo #o intervalo entre um passo e outro
var esperaIntervalo #um timer para esperar um intervalo
var esperaTotal #é o tempo total que devera demorar para o gato andar
var alterarTamanho # uma variavel que altera somando ou subtraindo no scale
 #variaveis <

func _ready():

	set_process(true)
	
	#captura os scripts externos >
	painelGlobal = get_node("/root/painelGlobal") #captura o script painelGlobal
	analisaPainel = get_node("root/analisaPainel") #captura o script analisaPainel
	analisaPainel = get_node("/root/analisaPainel") #captura o script analisaPainel	
	gatoGlobal = get_node("/root/gatoGlobal")
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
	timerAnimacao = Timer.new()
	add_child(timer)
	add_child(timerAnimacao)
	timer.set_one_shot(true)
	timerAnimacao.set_one_shot(true)
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
	if(Input.is_action_pressed("ui_up")==true and Input.is_action_pressed("travarGato") == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,-1))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		exaustaoPainel = analisaPainel.get_exaustao_casa_analisada()
		tipoCasaAnalisada = analisaPainel.get_tipo_casa_analisada()
		ativadaArmadilhaAnalisada = analisaPainel.get_ativada_armadilha_analisada()
#		print(tipoCasaAnalisada)
#		print(ativadaArmadilhaAnalisada)	
#		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			get_node("/root/gatoGlobal").set_direcao("cima")
#			print(get_node("/root/gatoGlobal").get_direcao())
			gatoGlobal.set_estado("andando")
#			print(gatoGlobal.get_estado())
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
					if(tipoCasaAnalisada == "armadilha" and ativadaArmadilhaAnalisada == true):
						noArmadilha = analisaPainel.get_no_armadilha()
						noArmadilha.ativa_armadilha()
						gato.get_node("AnimationPlayer").play("gatoCaindo")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  - tamanhoPainel))
						gato.get_node("Sprite").set_scale(Vector2(1,1))
						gato.get_node("AnimationPlayer").play("gatoPiscando")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina() - 60)
					gatoGlobal.set_estamina(gatoGlobal.get_estamina() - exaustaoPainel)
					analisaPainel.reset_painel_analisado()
					gatoGlobal.set_estado("parado")
					esperaProximoMovimento = false
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))

#		print(gato.get_pos())
	#move o gato pra cima <

	#move o gato pra baixo >
	if(Input.is_action_pressed("ui_down")==true and Input.is_action_pressed("travarGato") == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,1))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		exaustaoPainel = analisaPainel.get_exaustao_casa_analisada()
		tipoCasaAnalisada = analisaPainel.get_tipo_casa_analisada()
		ativadaArmadilhaAnalisada = analisaPainel.get_ativada_armadilha_analisada()
#		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			get_node("/root/gatoGlobal").set_direcao("baixo")
#			print(get_node("/root/gatoGlobal").get_direcao())
			gatoGlobal.set_estado("andando")
			while(passosRestantes > 0 and esperaProximoMovimento == true):
				gato.translate(Vector2(0,float(tamanhoPainel)/passosTotal))
				passosRestantes -= float(1)/numeroCasasAndar
				timer.start()
				yield(timer,'timeout')
	#			print(passosRestantes)
				if(passosRestantes < 0):
					passosRestantes = 0
				if(passosRestantes == 0):
#					print(tipoCasaAnalisada)
					if(tipoCasaAnalisada == "armadilha" and ativadaArmadilhaAnalisada == true):
						noArmadilha = analisaPainel.get_no_armadilha()
						noArmadilha.ativa_armadilha()
						gato.get_node("AnimationPlayer").play("gatoCaindo")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  + tamanhoPainel))
						gato.get_node("Sprite").set_scale(Vector2(1,1))
						gato.get_node("AnimationPlayer").play("gatoPiscando")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina() - 60)
					gatoGlobal.set_estamina(gatoGlobal.get_estamina() - exaustaoPainel)
					analisaPainel.reset_painel_analisado()
					gatoGlobal.set_estado("parado")
					esperaProximoMovimento = false
	#			print(gato.get_pos())
			passosRestantes = passosTotal
	#		print(gato.get_pos())
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))
	#move o gato pra baixo <

	#move o gato pra direita >
	if(Input.is_action_pressed("ui_right")==true and Input.is_action_pressed("travarGato") == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(1,0))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		exaustaoPainel = analisaPainel.get_exaustao_casa_analisada()
		tipoCasaAnalisada = analisaPainel.get_tipo_casa_analisada()
		ativadaArmadilhaAnalisada = analisaPainel.get_ativada_armadilha_analisada()
#		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			get_node("/root/gatoGlobal").set_direcao("direita")
#			print(get_node("/root/gatoGlobal").get_direcao())
			gatoGlobal.set_estado("andando")
			while(passosRestantes > 0 and esperaProximoMovimento == true):
#				print(passosRestantes)
				gato.translate(Vector2(float(tamanhoPainel)/passosTotal,0))
				passosRestantes -= float(1)/numeroCasasAndar
				timer.start()
				yield(timer,'timeout')
	#			print(gato.get_pos())
				if(passosRestantes < 0):
					passosRestantes = 0
				if(passosRestantes == 0):
					if(tipoCasaAnalisada == "armadilha" and ativadaArmadilhaAnalisada == true):
						noArmadilha = analisaPainel.get_no_armadilha()
						noArmadilha.ativa_armadilha()
						gato.get_node("AnimationPlayer").play("gatoCaindo")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  - tamanhoPainel))
						gato.get_node("Sprite").set_scale(Vector2(1,1))
						gato.get_node("AnimationPlayer").play("gatoPiscando")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina() - 30)
					gatoGlobal.set_estamina(gatoGlobal.get_estamina() - exaustaoPainel)
					analisaPainel.reset_painel_analisado()
					gatoGlobal.set_estado("parado")
					esperaProximoMovimento = false
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))
	#		print(gato.get_pos())
	#move o gato pra direita <
	
	#move o gato pra esquerda >
	if(Input.is_action_pressed("ui_left")==true and Input.is_action_pressed("travarGato") == false and esperaProximoMovimento == false):
		analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(-1,0))
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		exaustaoPainel = analisaPainel.get_exaustao_casa_analisada()
		tipoCasaAnalisada = analisaPainel.get_tipo_casa_analisada()
		ativadaArmadilhaAnalisada = analisaPainel.get_ativada_armadilha_analisada()
#		print("forma: ",formaAnalisada)
		andando = true
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			get_node("/root/gatoGlobal").set_direcao("esquerda")
#			print(get_node("/root/gatoGlobal").get_direcao())
			gatoGlobal.set_estado("andando")
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
					if(tipoCasaAnalisada == "armadilha" and ativadaArmadilhaAnalisada == true):
						noArmadilha = analisaPainel.get_no_armadilha()
						noArmadilha.ativa_armadilha()
						gato.get_node("AnimationPlayer").play("gatoCaindo")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  - tamanhoPainel))
						gato.get_node("Sprite").set_scale(Vector2(1,1))
						gato.get_node("AnimationPlayer").play("gatoPiscando")
						timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
						timerAnimacao.start()
						yield(timerAnimacao,"timeout")
						get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina() - 30)
					gatoGlobal.set_estamina(gatoGlobal.get_estamina() - exaustaoPainel)
					analisaPainel.reset_painel_analisado()
					gatoGlobal.set_estado("parado")
					esperaProximoMovimento = false
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))
	#		print(gato.get_pos())
	#move o gato pra esquerda <
	
	
	#script de pulo, devido a pressa, vai ficar aqui, depois de terminar o prototipo devera ser organizado num script proprio >
	
	if(Input.is_action_pressed("pular") == true and Input.is_action_pressed("travarGato") == false and andando == false and esperaProximoMovimento == false):
		andando = true
		direcao = gatoGlobal.get_direcao()
		if(direcao == "cima"):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,-1))
#			print(analisaPainel.get_forma_painel_analisado())
		elif(direcao == "baixo"):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,1))
#			print(analisaPainel.get_forma_painel_analisado())
		elif(direcao == "esquerda"):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(-1,0))
#			print(analisaPainel.get_forma_painel_analisado())
		elif(direcao == "direita"):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(1,0))
#			print(analisaPainel.get_forma_painel_analisado())
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
#		print(formaAnalisada)
		if(formaAnalisada != "parede" and formaAnalisada != null):
			direcao = gatoGlobal.get_direcao()
			if(direcao == "cima"):
				analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,-2))
			elif(direcao == "baixo"):
				analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,2))
			elif(direcao == "esquerda"):
				analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(-2,0))
			elif(direcao == "direita"):
				analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(2,0))
			formaAnalisada = analisaPainel.get_forma_painel_analisado()
			if(formaAnalisada != "parede"  and formaAnalisada != null):
				esperaProximoMovimento = true
				analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,0))
				exaustaoPainel = analisaPainel.get_exaustao_casa_analisada()
				gatoGlobal.set_estamina(gatoGlobal.get_estamina() - (exaustaoPainel * 1.5))
				direcao = gatoGlobal.get_direcao()
				if(direcao == "cima"):
					analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,-2))
				elif(direcao == "baixo"):
					analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,2))
				elif(direcao == "esquerda"):
					analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(-2,0))
				elif(direcao == "direita"):
					analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(2,0))
				formaAnalisada = analisaPainel.get_forma_painel_analisado()
				exaustaoPainel = analisaPainel.get_exaustao_casa_analisada()
				tipoCasaAnalisada = analisaPainel.get_tipo_casa_analisada()
				ativadaArmadilhaAnalisada = analisaPainel.get_ativada_armadilha_analisada()
				gatoGlobal.set_estado("pulando")
				gato.get_node("SamplePlayer2D").play("pulo")
				numeroCasasAndar = 2
				alterarTamanho = 0.5/(passosTotal*numeroCasasAndar)
				while(passosRestantes > 0 and esperaProximoMovimento == true):
					if(passosRestantes <= passosTotal and passosRestantes > passosTotal/2):
						gato.get_node("Sprite").set_scale(Vector2(gato.get_node("Sprite").get_scale().x + alterarTamanho,gato.get_node("Sprite").get_scale().y + alterarTamanho))
					elif(passosRestantes <= passosTotal/2 and passosRestantes > 0):
						gato.get_node("Sprite").set_scale(Vector2(gato.get_node("Sprite").get_scale().x - alterarTamanho,gato.get_node("Sprite").get_scale().y - alterarTamanho))
					if(direcao == "cima"):
						gato.translate(Vector2(0,float(-tamanhoPainel)/passosTotal))
					if(direcao == "baixo"):
						gato.translate(Vector2(0,float(tamanhoPainel)/passosTotal))
					if(direcao == "esquerda"):
						gato.translate(Vector2(float(-tamanhoPainel)/passosTotal,0))
					if(direcao == "direita"):
						gato.translate(Vector2(float(tamanhoPainel)/passosTotal,0))
					passosRestantes -= float(1)/numeroCasasAndar
					timer.start()
					yield(timer,'timeout')
		#			print(gato.get_pos())
					if(passosRestantes < 0):
						passosRestantes = 0
					if(passosRestantes == 0):
						gatoGlobal.set_estamina(gatoGlobal.get_estamina() - (exaustaoPainel * 1.5))
						analisaPainel.reset_painel_analisado()
						if(tipoCasaAnalisada == "armadilha" and ativadaArmadilhaAnalisada == true):
							noArmadilha = analisaPainel.get_no_armadilha()
							noArmadilha.ativa_armadilha()
							gato.get_node("AnimationPlayer").play("gatoCaindo")
							timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
							timerAnimacao.start()
							yield(timerAnimacao,"timeout")
							if(direcao == "cima"):
								gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  - tamanhoPainel))
							if(direcao == "baixo"):
								gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  + tamanhoPainel))
							if(direcao == "esquerda"):
								gato.set_pos(Vector2(gato.get_pos().x   - tamanhoPainel, gato.get_pos().y))
							if(direcao == "direita"):
								gato.set_pos(Vector2(gato.get_pos().x  + tamanhoPainel, gato.get_pos().y))
							gato.get_node("Sprite").set_scale(Vector2(1,1))
							gato.get_node("AnimationPlayer").play("gatoPiscando")
							timerAnimacao.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
							timerAnimacao.start()
							yield(timerAnimacao,"timeout")
							get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina() - 60)
						gatoGlobal.set_estado("parado")
						esperaProximoMovimento = false
						numeroCasasAndar = 1
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))

	#libera o movimento <
	if((Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and Input.is_action_pressed("ui_right")==false and Input.is_action_pressed("ui_left")==false and Input.is_action_pressed("pular") == false and andando==true)):
		andando = false
#		print("aqui")
	#libera o movimento <
	
	set_pos(gato.get_pos()) #atualiza a posição do script em relação ao gato