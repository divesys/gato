	#esse script cuida do posicionamento do painel
extends Panel

 #extração de variaveis externas >
var gatoGlobal # invoca o script gatoGlobal
var estamina # extrai a variavel estamina do script gatoGlobal
 #extração de variaveis externas <

func _ready():
	set_process(true)
	
	#captura os scripts externos >
	gatoGlobal = get_node("/root/gatoGlobal")
	#captura os scripts externos <
	pass

func _process(delta):
	estamina = gatoGlobal.get_estamina()
	get_node("estamina/estaminaValor").set_text(var2str(estamina))