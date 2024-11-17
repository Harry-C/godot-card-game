class_name PlayerHandler
extends Node

# How long to wait until drawing the next card
const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.3

@export var hand: Hand

var character_stats: CharacterStats


@onready var debug_discard_total: Label = %debug_discard_total
@onready var debug_draw_pile_total: Label = %debug_draw_pile_total

func _ready() -> void:
	Events.card_played.connect(_on_card_played)
	
func start_battle(character_stats_param: CharacterStats) -> void:
	character_stats = character_stats_param
	character_stats.draw_pile = character_stats.deck.duplicate(true)
	character_stats.deck.shuffle()
	character_stats.discard = CardPile.new()
	start_turn()

func start_turn() -> void:
	character_stats.set_block(0)
	character_stats.decrease_strength(1)
	character_stats.decrease_dexterity(1)
	character_stats.reset_energy()
	draw_cards(character_stats.cards_per_turn)
	
	debug_discard_total.text = "Discard: %d" % character_stats.discard.cards.size()
	debug_draw_pile_total.text = "Draw: %d" % character_stats.draw_pile.cards.size()

func end_turn() -> void:
	hand.disable_hand()
	discard_cards()
	
func draw_card() -> void:
	# If we have no deck cards, reshuffle the discard pile and draw
	reshuffle_deck_from_discard()
	hand.draw_card(character_stats.draw_pile.draw_card())
	# Incase we do not have enough cards to draw from the draw_pile
	reshuffle_deck_from_discard()

func draw_cards(cards_to_draw: int) -> void:
	var tween := create_tween()
	for i in range(cards_to_draw):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
		
	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)
	
func discard_cards() -> void:
	var tween := create_tween()
	for card_ui in hand.get_children():
		# Add discarded card to discard deck
		tween.tween_callback(character_stats.discard.add_card.bind(card_ui.card))
		# Delete card from hand
		tween.tween_callback(hand.discard_card.bind(card_ui))
		# Wait a little before each discard
		tween.tween_interval(HAND_DISCARD_INTERVAL)
	
	tween.finished.connect(
		func():
			Events.player_hand_discarded.emit()
	)

func reshuffle_deck_from_discard() -> void:
	if not character_stats.draw_pile.cards_empty():
		return
	
	while not character_stats.discard.cards_empty():
		character_stats.draw_pile.add_card(character_stats.discard.draw_card())
	character_stats.draw_pile.shuffle()

func _on_card_played(card: Card):
	character_stats.discard.add_card(card)
