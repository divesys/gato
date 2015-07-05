
extends Node2D

export(int, 1000) var armadilha1 #armadilha ativavel 1
export(int, 1000) var armadilha2 #armadilha ativavel 2
export(int, 1000) var armadilha3 #armadilha ativavel 3



 # funções get >
func get_armadilha(indice):
	if(indice == 1):
		return armadilha1
	elif(indice == 2):
		return armadilha2
	elif(indice == 3):
		return armadilha3
	else:
		print("indice invalido")
 # funções get <