class_name BlockEffect

extends Effect

var amount := 0

func execute(targets: Array[Node]):
	for target in targets:
		if not target:
			continue
		if target is Player:
			amount += target.character_stats.dexterity
			target.character_stats.defend(amount)
			SoundEffectPlayer.play(sound)
		if target is Enemy:
			amount += target.stats.dexterity
			target.stats.defend(amount)
			SoundEffectPlayer.play(sound)
