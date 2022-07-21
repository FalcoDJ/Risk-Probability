extends Button

const die = preload("res://Scenes/Die.tscn")

export(NodePath) var parent_path = ""

onready var parent = get_node(parent_path)

func _on_AddDice_pressed() -> void:
	if parent:
		parent.add_child(die.instance())
		return
	
	print_debug("null parent")
