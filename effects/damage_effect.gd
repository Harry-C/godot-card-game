class_name DamageEffect

extends Effect

var amount := 0

func execute(targets: Array[Node]):
	for target in targets:
		if not target:
			continue	
		target.take_damage(amount)
		SoundEffectPlayer.play(sound)
		if target is Enemy:
			Statistics.player_damage_dealt += amount
