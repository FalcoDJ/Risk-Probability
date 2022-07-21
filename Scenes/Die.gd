extends Button

onready var label := $CenterContainer/Label

var Numerical_Value = 1

func _on_Die_pressed() -> void:
	Numerical_Value += 1
	Numerical_Value = wrapi(Numerical_Value,1,7)
	label.text = String(Numerical_Value)
