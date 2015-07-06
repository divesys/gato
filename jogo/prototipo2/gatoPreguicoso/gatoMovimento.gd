
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
var gatoAnimacao #captura o nó de animação do gato
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
var direcaoAnterior # a direcao anterior do gato, para verificar se ele mudou de direção
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
	ativadaArmadilhaAnalisada = false
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
	gatoAnimacao = gato.get_node("AnimationPlayer")
	#atualiza o nó gato ,
	
#	print("andando:",andando)
#	print("espera:",esperaProximoMovimento)
#	print(yieldTimer.get_time_left())
	#move o gato >
	ativadaArmadilhaAnalisada = analisaPainel.get_ativada_armadilha_analisada()
	if((Input.is_action_pressed("ui_up") == true or Input.is_action_pressed("ui_down") == true or Input.is_action_pressed("ui_left") == true or Input.is_action_pressed("ui_right") == true) and Input.is_action_pressed("travarGato") == false and esperaProximoMovimento == false and ativadaArmadilhaAnalisada == false):
		if(Input.is_action_pressed("ui_up") == true):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,-1))
			gatoGlobal.set_direcao("cima")
		elif(Input.is_action_pressed("ui_down") == true):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(0,1))
			gatoGlobal.set_direcao("baixo")
		elif(Input.is_action_pressed("ui_left")==true):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(-1,0))
			gatoGlobal.set_direcao("esquerda")
		elif(Input.is_action_pressed("ui_right")==true):
			analisaPainel.get_painel_pela_posicao(get_pos(),Vector2(1,0))
			gatoGlobal.set_direcao("direita")
		formaAnalisada = analisaPainel.get_forma_painel_analisado()
		exaustaoPainel = analisaPainel.get_exaustao_casa_analisada()
		tipoCasaAnalisada = analisaPainel.get_tipo_casa_analisada()
		if(formaAnalisada == "casa"):
			esperaProximoMovimento = true
			while(passosRestantes > 0 and esperaProximoMovimento == true):
				direcao = gatoGlobal.get_direcao()
				if(direcaoAnterior != direcao):
						gatoGlobal.set_estado("continuaAndando")
				if(gatoGlobal.get_direcao() == "cima"):
					if(gatoGlobal.get_estado() != "andando"):
						gatoAnimacao.play("gatoAndandoCima")
						gatoGlobal.set_estado("andando")
						direcaoAnterior = direcao
					gato.translate(Vector2(0,(float(-tamanhoPainel)/passosTotal)))
				elif(gatoGlobal.get_direcao() == "baixo"):
					if(gatoGlobal.get_estado() != "andando"):
						gatoAnimacao.play("gatoAndandoBaixo")
						gatoGlobal.set_estado("andando")
						direcaoAnterior = direcao
					gato.translate(Vector2(0,(float(tamanhoPainel)/passosTotal)))
				elif(gatoGlobal.get_direcao() == "esquerda"):
					if(gatoGlobal.get_estado() != "andando"):
						gatoAnimacao.play("gatoAndandoEsquerda")
						gatoGlobal.set_estado("andando")
						direcaoAnterior = direcao
					gato.translate(Vector2((float(-tamanhoPainel)/passosTotal),0))
				elif(gatoGlobal.get_direcao() == "direita"):
					if(gatoGlobal.get_estado() != "andando"):
						gatoAnimacao.play("gatoAndandoDireita")
						gatoGlobal.set_estado("andando")
						direcaoAnterior = direcao
					gato.translate(Vector2((float(tamanhoPainel)/passosTotal),0))
				passosRestantes -= float(1)/numeroCasasAndar
				timer.start()
				yield(timer,"timeout")
				if(passosRestantes < 0):
					passosRestantes = 0
				if(passosRestantes == 0):
					if(tipoCasaAnalisada == "armadilha" and ativadaArmadilhaAnalisada == false):
						noArmadilha = analisaPainel.get_no_armadilha()
						noArmadilha.ativa_armadilha()
					gatoGlobal.set_estamina(gatoGlobal.get_estamina() - exaustaoPainel)
					if(Input.is_action_pressed("ui_up") == false and Input.is_action_pressed("ui_down") == false and Input.is_action_pressed("ui_left") == false and Input.is_action_pressed("ui_right") == false and ativadaArmadilhaAnalisada == false):
						direcao = gatoGlobal.get_direcao()
						if(direcao == "cima"):
							gatoAnimacao.play("gatoParadoCima")
						if(direcao == "baixo"):
							gatoAnimacao.play("gatoParadoBaixo")
						if(direcao == "esquerda"):
							gatoAnimacao.play("gatoParadoEsquerda")
						if(direcao == "direita"):
							gatoAnimacao.play("gatoParadoDireita")
						gatoGlobal.set_estado("parado")
					analisaPainel.reset_painel_analisado()
					esperaProximoMovimento = false
			passosRestantes = passosTotal
			gato.set_pos(Vector2(round(gato.get_pos().x),round(gato.get_pos().y)))	
	#move o gato <	
	
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
						gatoAnimacao.play("gatoPulandoCima")
						gato.translate(Vector2(0,float(-tamanhoPainel)/passosTotal))
					if(direcao == "baixo"):
						gatoAnimacao.play("gatoPulandoBaixo")
						gato.translate(Vector2(0,float(tamanhoPainel)/passosTotal))
					if(direcao == "esquerda"):
						gatoAnimacao.play("gatoPulandoEsquerda")
						gato.translate(Vector2(float(-tamanhoPainel)/passosTotal,0))
					if(direcao == "direita"):
						gatoAnimacao.play("gatoPulandoDireita")
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
						if(tipoCasaAnalisada == "armadilha" and ativadaArmadilhaAnalisada == false):
							noArmadilha = analisaPainel.get_no_armadilha()
							noArmadilha.ativa_armadilha()
						direcao = gatoGlobal.get_direcao()
						if(direcao == "cima"):
							gatoAnimacao.play("gatoParadoCima")
						elif(direcao == "baixo"):
							gatoAnimacao.play("gatoParadoBaixo")
						elif(direcao == "esquerda"):
							gatoAnimacao.play("gatoParadoEsquerda")
						elif(direcao == "direita"):
							gatoAnimacao.play("gatoParadoDireita")
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