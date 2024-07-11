class_name EnergyUI
extends Panel

@export var character_stats: CharacterStats : set = _set_character_stats

@onready var energy_label: Label = $EnergyLabel

#Temporary code
func _ready():
	character_stats.energy = 3

func _set_character_stats(value: CharacterStats):
	character_stats = value
	
	if not character_stats.stats_changed.is_connected(_on_stats_changed):
		character_stats.stats_changed.connect(_on_stats_changed)
	
	if not is_node_ready():
		await ready
		
	_on_stats_changed()

func _on_stats_changed():
	energy_label.text = "%s/%s" % [character_stats.energy, character_stats.max_energy]
