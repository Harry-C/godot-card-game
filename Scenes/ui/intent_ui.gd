class_name IntentUI
extends HBoxContainer

@onready var icon: TextureRect = $Icon
@onready var number: Label = $Number

func update_intent(intent: Intent) -> void:
	
	if not intent:
		hide()
		return
	
	# Show the icon if we give a valid texture
	icon.visible = intent.icon != null
	icon.texture = intent.icon
	
	# Show the number if we provided any value
	number.text = str(intent.number)
	number.visible = intent.number.length() > 0
	show()
