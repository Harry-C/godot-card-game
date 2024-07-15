extends CardState


func enter() -> void:
		if not card_ui.is_node_ready():
			await card_ui.ready
		if card_ui.tween and card_ui.tween.is_running():
			card_ui.tween.kill()
		
		# Move the card back to the Hand
		card_ui.reparent_requested.emit(card_ui)
		card_ui.pivot_offset = Vector2.ZERO
		# Make the card no longer use "selected" or "actioning" styles
		card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLE)
		
		# If we had a tooltip open, close it now
		Events.card_tooltip_hide_requested.emit()

# Card is usable if it is playable and all other cards are not disabled
func _card_unusable() -> bool:
	return not card_ui.card_playable or card_ui.other_cards_disabled
	
func on_gui_input(event: InputEvent) -> void:
	if _card_unusable():
		return

	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_entered():
	if _card_unusable():
		return
		
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLE)
	
	# Show tooltip when hovering over a card
	Events.card_tooltip_show_requested.emit(card_ui.card.icon, card_ui.card.name, card_ui.card.tooltip)
	
func on_mouse_exited():
	if _card_unusable():
		return
		
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLE)
	
	# If we had a tooltip open, close it now
	Events.card_tooltip_hide_requested.emit()
