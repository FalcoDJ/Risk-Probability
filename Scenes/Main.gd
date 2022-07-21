extends Control

onready var offense = $"Table/Offense Container/CenterContainer/Offense Container/MarginContainer/VBoxContainer/Offense"

func _calculate_probability_of_success():
	pass

func _get_offense_dice():
	var dice_nums := []
	var dice = offense.get_children()
	for die in dice:
		dice_nums.push_back(die.Numerical_Value)
