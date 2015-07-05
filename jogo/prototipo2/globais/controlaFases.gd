	#esse script regula a sequencia de fases e mundos, além das telas de derrota e vitoria
extends Node2D

 #variaveis >
var numeroFaseAtual # é o numero da fase atual no mundo atual
var mundoAtual # é o mundo atual
var faseAtual # é a cena da fase atual
var proximaFase # é a cena da proxima fase
var telaVitoria # é a tela de vitoria atual
var telaDerrota # é a tela de derrota atual

 # funções get >
func get_numero_fase_atual():
	return numeroFaseAtual
	
func get_mundo_atual():
	return mundoAtual
	
func get_fase_atual():
	return faseAtual
	
func get_proxima_fase():
	return proximaFase
	
func get_tela_vitoria():
	return telaVitoria
	
func get_tela_derrota():
	return telaDerrota
 # funções get <

 #funções set >
func set_numero_fase_atual(numero):
	numeroFaseAtual = numero
	
func set_mundo_atual(mundo):
	mundoAtual = mundo
	
func set_fase_atual(fase):
	faseAtual = fase
	
func set_proxima_fase(fase):
	proximaFase = fase
	
func set_tela_vitoria(tela):
	telaVitoria = tela
	
func set_tela_derrota(tela):
	telaDerrota = tela
 #funções set <