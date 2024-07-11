#Export class name for easier access
class_name CardUI
extends Control

# This signal will rehome a card back to the hand
signal reparent_requested(which_card_ui: CardUI)

# Load the different styles for a card
const BASE_STYLE := preload("res://Scenes/Card_Ui/card_base_stylebox.tres")
const HOVER_STYLE := preload("res://Scenes/Card_Ui/card_selected_stylebox.tres")
const DRAG_STYLE := preload("res://Scenes/Card_Ui/card_dragging_stylebox.tres")

# This represents the property (type) of card that we have
@export var card: Card : set = _set_card

@export var character_stats: CharacterStats : set = _set_character_stats

# Specific card properties
@onready var panel = $Panel
@onready var cost = $Cost
@onready var icon = $Icon

# Different card attributes that all cards must have
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector = $DropPointDetector
@onready var targets: Array[Node] = []

@onready var index := self.get_index()

# The Parent Hand object with the cards
var parent: Control

# Moving the card to the center for using
var tween: Tween

# Determine if current card is playable
var card_playable := true : set = _set_card_playable
# If playable, disable all other cards
var other_cards_disabled := false

# Called when the node enters the scene tree for the first time.
# start the state machine
func _ready():
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.card_aim_ended.connect(_on_card_drag_or_aiming_ended)
	Events.card_drag_ended.connect(_on_card_drag_or_aiming_ended)
	card_state_machine.init(self)

# Play a card from my hand
func play():
	if not card:
		return
	card.play(targets, character_stats)
	parent.move_cards(self)
	queue_free()

# All event types here are sent to the state machine
#{
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
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

func _set_card(value: Card):
	if not is_node_ready():
		await ready
	card = value
	cost.text = str(card.cost)
	icon.texture = card.icon

func _set_card_playable(value: bool):
	card_playable = value
	if not card_playable:
		cost.add_theme_color_override("font_color", Color.RED)
		icon.modulate = Color(1,1,1,0.5)
	else:
		cost.remove_theme_color_override("font_color")
		icon.modulate = Color(1,1,1,1)

func _set_character_stats(value: CharacterStats):
	character_stats = value
	character_stats.stats_changed.connect(_on_character_stats_changed)
	
func _on_character_stats_changed():
	self.card_playable = character_stats.can_play_card(card)
	pass
	
func _on_card_drag_or_aiming_started(used_card: CardUI):
	if used_card == self:
		return
	
	other_cards_disabled = true

func _on_card_drag_or_aiming_ended(_card: CardUI):
	other_cards_disabled = false
	self.card_playable = character_stats.can_play_card(card)
