class_name EnergyUI
extends Panel

@export var stats: CharacterStats : set = _set_stats

@onready var energy_label: Label = $EnergyLabel

#Temporary code
func _ready():
	stats.energy = 3

func _set_stats(value: CharacterStats):
	stats = value
	
	if not stats.stats_changed.is_connected(_on_stats_changed):
		stats.stats_changed.connect(_on_stats_changed)
	
	if not is_node_ready():
		await ready
		
	_on_stats_changed()

func _on_stats_changed():
	energy_label.text = "%s/%s" % [stats.energy, stats.max_energy]
