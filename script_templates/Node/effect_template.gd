# meta-name: Effect
# meta-description: Create a card effect which can be applied to a target

class_name MyNewEffect_Placeholder

extends Effect

# Used as an example for memeber variable in a template
var member_var := "nothing"

func execute(targets: Array[Node]) -> void:
	print("My effect targets: %s" % targets)
	print("It does... " % member_var)
