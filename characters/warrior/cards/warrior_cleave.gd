extends Card
@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node], stats: CharacterStats) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 4 + stats.strength
	damage_effect.sound = sound
	damage_effect.execute(targets)
