extends CardState

var played: bool

func enter () -> void:
	
	played = false
	
	if not card_ui.targets.is_empty():
		Events.card_tooltip_hide_requested.emit()
		played = true
		print("Card played on target ", card_ui.targets)
		card_ui.play()
		
func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	transition_requested.emit(self, CardState.State.BASE)
