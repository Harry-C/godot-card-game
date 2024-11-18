class_name BlockEffect

extends Effect

var amount := 0

func execute(targets: Array[Node]):
	for target in targets:
		if not target:
			continue
		if target is Player or target is Enemy:
			target.stats.defend(amount)
			SoundEffectPlayer.play(sound)
