#Export class name for easier access
class_name CardUI
extends Control

# This signal will rehome a card back to the hand
signal reparent_requested(which_card_ui: CardUI)

# This represents the property (type) of card that we have
@export var card: Card

# Different card attributes that all cards must have
@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector = $DropPointDetector
@onready var targets: Array[Node] = []

# The Parent Hand object with the cards
var parent: Control

# Moving the card to the center for using
var tween: Tween

# Called when the node enters the scene tree for the first time.
# start the state machine
func _ready():
	card_state_machine.init(self)

# All event types here are sent to the state machine
#{
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_entered()
#}

func _on_drop_point_detector_area_entered(area):
	if not targets.has(area):
		targets.append(area)

# And when we leave the drop point 
func _on_drop_point_detector_area_exited(area):
	targets.erase(area)

# Animate the card arc tween from card to the mouse
func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration);
