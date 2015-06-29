 #guarda valores importantes do gato que precisam de acesso global, como sua estamina

extends Node2D


 #variaveis >
var estamina #a estamina do gato
 #variaveis <

func _ready():

	#inicializa variaveis >
	estamina = 450
	#inicializa variaveis <

 #funções get >
func get_estamina():
	return estamina
 #funções get <

 #funções set >
func set_estamina(valor):
	estamina = valor
 #funções set <
