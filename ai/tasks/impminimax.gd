@tool
extends BTAction

var health_difference
var bossAttacks=['antijump', 'jumpable_attack', 'special']

func _generate_name() -> String:
	return 'IMPMinMax'
	

func impminmax(history:Array, depth:int, isMaximizing:bool):
	var result = eval_fight(history, 10, 5)
	var score
	var history_copy = history
	if result <= 0:
		score = result
		return score
		

func eval_fight(history:Array, bossHealth:int, playerHealth:int):
	health_difference = bossHealth - playerHealth
	for i in history:
		if history[0] == 'jumpable_attack' and history[1] != 'jump':
			health_difference -=2
		elif history[0] == 'antijump_attack' and history[1] != 'attack':
			health_difference -=2
		if history[1] == 'jump' and history[2] == 'jumpable attack':
			health_difference -=2
		elif history[1] == 'jump' and history[2] == 'antijump_attack':
			health_difference +=2
		elif history[1] == 'attack' and history[2] == 'antijump_attack':
			health_difference +=2
		elif history[1] == 'attack' and history[2] == 'jumpable_attack':
			health_difference -=2
	if bossHealth <= 0:
		return -100
	elif playerHealth <=0:
		return 100
	else:
		return health_difference
	
