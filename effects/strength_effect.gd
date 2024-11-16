class_name StrengthEffect

extends Effect

var amount := 0

func execute(targets: Array[Node]):
	for target in targets:
		if not target:
			continue
		if target is Player:
			target.character_stats.add_strength(amount)
		if target is Enemy:
			target.stats.add_strength(amount)
