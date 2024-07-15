class_name DamageEffect

extends Effect

var amount := 0

func execute(targets: Array[Node]):
	for target in targets:
		if not target:
			continue
		if target is Enemy or target is Player:
			if target is Enemy:
				var player = targets[0].get_tree().get_nodes_in_group("player")
				amount += player[0].character_stats.strength
			target.take_damage(amount)
