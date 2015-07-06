extends Node2D

var gatoGlobal # invoca o script gatoGlobal
var gato # extrai o nó do gato do script gatoGlobal
var direcao # extrai a direçao do gati
var painelGlobal # invoca o script painelGlobal
var tamanhoPainel # extrai o tamanho do painel
var armadilha # é o nó da armadilha
var ativada # verifica se a armadilha foi ativada
var timer

var perdaExaustao = 60

func _ready():
	gatoGlobal = get_node("/root/gatoGlobal")
	painelGlobal = get_node("/root/painelGlobal")
	armadilha = get_parent()
	timer = Timer.new()
	timer.set_one_shot(true)
	add_child(timer)
	perdaExaustao = 60

func ativa_armadilha():
	tamanhoPainel = painelGlobal.get_tamanho_painel()
	armadilha.set_ativada(true)
	gato = gatoGlobal.get_gato()
	get_parent().set_ativada(true)
	get_node("spriteEletrica/AnimationPlayer").play("raiosEletricos")
	timer.set_wait_time(0.2)
	timer.start()
	yield(timer,"timeout")
	gato.get_node("AnimationPlayer").play("gatoChoque")
	timer.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
	timer.start()
	yield(timer,"timeout")
	gato.get_node("AnimationPlayer").play("gatoChoque")
	timer.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
	timer.start()
	yield(timer,"timeout")
	gato.get_node("AnimationPlayer").play("gatoChoque")
	timer.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
	timer.start()
	yield(timer,"timeout")
	gato.get_node("AnimationPlayer").play("gatoChoque")
	timer.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
	timer.start()
	yield(timer,"timeout")
#	direcao = gatoGlobal.get_direcao()
#	if(direcao == "cima"):
#		gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  - tamanhoPainel))
#		gato.get_node("AnimationPlayer").play("gatoParadoBaixo")
#	elif(direcao == "baixo"):
#		gato.set_pos(Vector2(gato.get_pos().x, gato.get_pos().y  + tamanhoPainel))
#		gato.get_node("AnimationPlayer").play("gatoParadoBaixo")
#	elif(direcao == "esquerda"):
#		gato.set_pos(Vector2(gato.get_pos().x   - tamanhoPainel, gato.get_pos().y))
#		gato.get_node("AnimationPlayer").play("gatoParadoEsquerda")
#	elif(direcao == "direita"):
#		gato.set_pos(Vector2(gato.get_pos().x  + tamanhoPainel, gato.get_pos().y))
#		gato.get_node("AnimationPlayer").play("gatoParadoDireita")
#	gato.get_node("Sprite").set_scale(Vector2(1,1))
#	gato.get_node("AnimationPlayer").play("gatoPiscando")
#	timer.set_wait_time(gato.get_node("AnimationPlayer").get_current_animation_length())
#	timer.start()
#	yield(timer,"timeout")
	get_node("/root/gatoGlobal").set_estamina(get_node("/root/gatoGlobal").get_estamina() - perdaExaustao)
	armadilha.set_ativada(false)