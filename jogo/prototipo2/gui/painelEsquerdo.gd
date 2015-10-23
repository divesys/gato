	#esse script cuida do posicionamento do painel esquerdo
extends Panel

 #extração de variaveis externas >
var gatoGlobal # invoca o script gatoGlobal
var estamina # extrai a variavel estamina do script gatoGlobal
var estaminaTotal # extrai a variavel estaminaTotal do script gatoGlobal
 #extração de variaveis externas <

func _ready():
	set_process(true)
	
	#captura os scripts externos >
	gatoGlobal = get_node("/root/gatoGlobal")
	
	#captura os scripts externos <
	pass

func _process(delta):
	estamina = gatoGlobal.get_estamina()
	estaminaTotal = gatoGlobal.get_estamina_total()
	if(estamina <= 0):
		estamina = 0
		get_node("medidorEstamina/estaminaValor").set_text(var2str(0) + "%")
	else:
		get_node("medidorEstamina/estaminaValor").set_text(var2str(round(estamina*100/estaminaTotal)) + "%")
#	get_node("medidorEstamina/estaminaValor").set_text(var2str(estamina*100/estaminaTotal) + "%")
#	get_node("estamina/ProgressBar").set_max(estaminaTotal)
#	get_node("estamina/ProgressBar").set_value(estamina)
	
func get_estamina_hud():
	return estamina