@tool
extends BTAction

var health_difference
var bossAttacks=['antijump', 'jumpable_attack']
var playerActions=['attack', 'jump', 'item']
var agent_tree
var history = ['','','']
@export var best_possible_move_var: StringName = &"best_possible_move"

func _generate_name() -> String:
	return 'MinMax'
	
func _tick(delta):
	best_move()
	if blackboard.get_var(best_possible_move_var):
		print(blackboard.get_var(best_possible_move_var))
		return SUCCESS
	return RUNNING

func best_move():
	agent_tree = agent.get_tree()
	var manalintad_health = agent.get_child(2).health.current_health_points
	var player_health = agent_tree.get_first_node_in_group('Player').get_child(3).health.current_health_points
	var score
	var best_score = -INF
	var history_copy = history
	var best_possible_move:String
	
	for i in bossAttacks:
		history_copy[0] = i
		score = minimax(history_copy, 0, true, -INF, INF, manalintad_health, player_health)
		if score > best_score:
			best_score = score
			best_possible_move = history_copy[0]
		print(best_score)
		history_copy[0] = ''
	blackboard.set_var(best_possible_move_var, best_possible_move)
	return SUCCESS
	
func eval_fight(history_copy:Array, bossHealth:int, playerHealth:int):
	health_difference = bossHealth - playerHealth
	for i in history_copy:
		if history_copy[0] == 'jumpable_attack' and history_copy[1] != 'jump':
			health_difference -=1
		elif history_copy[0] == 'antijump' and history_copy[1] != 'attack':
			health_difference -=1
		if history_copy[1] == 'jump' and history_copy[2] == 'jumpable attack':
			health_difference -=1
		elif history_copy[1] == 'jump' and history_copy[2] == 'antijump_attack':
			health_difference +=1
		elif history_copy[1] == 'attack' and history_copy[2] == 'antijump_attack':
			health_difference +=1
		elif history_copy[1] == 'attack' and history_copy[2] == 'jumpable_attack':
			health_difference -=1
	if bossHealth <= 0:
		return -100
	elif playerHealth <=0:
		return 100
	else:
		return health_difference
		
func minimax(history_copy:Array, depth:int, isMaximizing:bool, alpha, beta, manalintadHealth, playerHealth):
	agent_tree = agent.get_tree()
	var result = eval_fight(history_copy, manalintadHealth, playerHealth)
	var score
	if result != null || depth == 3:
		score = result
		return score
	if isMaximizing :
		var best_score = -INF
		for i in len(history_copy):
			if history_copy[i] == '':
				for j in bossAttacks:
					history_copy[i] = j
					score = minimax(history_copy, depth+1, false, alpha, beta, manalintadHealth, playerHealth)
					history_copy[i] = ''
					best_score = max(score, best_score)
					alpha = max(alpha, best_score)
					if alpha >= beta:
						break
		print(history_copy)
		return best_score

	else:
		var best_score = INF
		for i in len(history_copy):
			if history_copy[i] == '':
				for j in bossAttacks:
					history_copy[i] = j
					score = minimax(history_copy, depth+1, true, alpha, beta, manalintadHealth, playerHealth)
					history_copy[i] = ''
					best_score = min(score, best_score)
					beta = min(beta, best_score)
					if alpha >= beta:
						break
		return best_score
