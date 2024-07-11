extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD := 140

func enter() -> void:
	card_ui.targets.clear()
	
	# Moves card above the rest of cards to highlight the selection
	var offset := Vector2( (card_ui.parent.size.x / 2) - card_ui.size.x / 2, -card_ui.size.y / 2 )
	card_ui.animate_to_position(card_ui.parent.global_position + offset, 0.5)
	card_ui.drop_point_detector.monitoring = false
	
	# Fire the event to see who else wants to listen to this event
	# card target selector to make the card arc
	Events.card_aim_started.emit(card_ui)
	

func exit() -> void:
	Events.card_aim_ended.emit(card_ui)
	
func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD

	if (mouse_at_bottom and mouse_motion) or event.is_action_pressed("right_mouse"): 
		transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_pressed("left_mouse") or event.is_action_released("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
