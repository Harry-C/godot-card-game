class_name DexterityEffect

extends Effect

var amount := 0

func execute(targets: Array[Node]):
	for target in targets:
		if not target:
			continue
		if target is Player:
			target.character_stats.add_dexterity(amount)
			SoundEffectPlayer.play(sound)
		if target is Enemy:
			target.stats.add_dexterity(amount)
			SoundEffectPlayer.play(sound)
