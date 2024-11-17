extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer

func _ready() -> void:
	Events.player_hit.connect(_on_player_hit)
	timer.timeout.connect(_on_timer_timeout)
	
func _on_player_hit():
	color_rect.color.a = 0.25
	timer.start()
	pass

func _on_timer_timeout():
	color_rect.color.a = 0.0
	pass
