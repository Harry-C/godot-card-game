extends Card

func apply_effects(targets: Array[Node], stats: CharacterStats):
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 5 + stats.strength
	damage_effect.sound = sound
	damage_effect.execute(targets)
