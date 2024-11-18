# meta-name: Card Logic
# meta-description: What happens when this card is played

extends Card
@export var optional_sound: AudioStream

func apply_effects(targets: Array[Node], stats: CharacterStats) -> void:
	print("My new awesome card has been played!")
	print("Targets: %s" % targets)
	print("Stats: %s" % stats)
