extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.07

var minimum_drag_state_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
		
	card_ui.panel.set("theme_override_styles/panel", card_ui.DRAG_STYLE)
	
	Events.card_drag_started.emit(card_ui)
	
	minimum_drag_state_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_state_elapsed = true)

func exit():
	Events.card_drag_ended.emit(card_ui)

func on_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel := event.is_action_pressed("right_mouse")
	var confirm := event.is_action_pressed("left_mouse") or event.is_action_released("left_mouse")
	
	
	# Move the card while dragging
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	# Handle different state transitions from the events
	
	# If we right click return to BASE
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
		return
		
	# check if we clicked above the card row
	if not cancel and confirm and minimum_drag_state_elapsed:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
		return
	
	# If we have a single target card and have at least one target
	# lets aim the attack at them
	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return
