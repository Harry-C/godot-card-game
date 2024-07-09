extends Node2D

# How many points are in the arc
const ARC_POINTS := 14

@onready var area_2d = $Area2D
@onready var card_arc = $CanvasLayer/CardArc

var current_card: CardUI
var targeting := false

func _ready():
	Events.card_aim_started.connect(_on_card_aim_started)
	Events.card_aim_ended.connect(_on_card_aim_ended)
	
func _process(delta):
	if not targeting:
		return
	
	area_2d.position = get_local_mouse_position()
	card_arc.points = _get_points()
	
func _on_card_aim_started(card: CardUI) -> void:
	if not card.card.is_single_targeted():
		return
	targeting = true
	area_2d.monitoring = true
	area_2d.monitorable = true
	current_card = card

func _on_card_aim_ended(card: CardUI) -> void:
	targeting = false
	card_arc.clear_points()
	area_2d.position = Vector2.ZERO
	area_2d.monitoring = false
	area_2d.monitorable = false
	current_card = null
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	if not current_card.targets.has(area):
		current_card.targets.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	current_card.targets.erase(area)

func _get_points() -> Array:
	var points := []
	var start := current_card.global_position
	start.x += current_card.size.x / 2
	start.y += current_card.size.y / 10
	var target := get_local_mouse_position()
	var distance := target - start
	
	# Get each point in an arc from the middle of the card to the mouse cursor
	# Todo: Maybe it can be based on monster instead of the mouse
	for point in range(ARC_POINTS):
		var step := (1.0/ ARC_POINTS) * point
		var curve_x := start.x + (distance.x / ARC_POINTS) * point
		var curve_y := start.y + ease_out_cubic(step) * distance.y
		points.append(Vector2(curve_x,curve_y))
	
	# Dont forget to add the local mouse position as the final point!
	points.append(target)
	
	return points

# Change the points from a straight line to a thicc curvy line
func ease_out_cubic(number: float) -> float:
	return 1 - pow(1 - number, 3.0)
