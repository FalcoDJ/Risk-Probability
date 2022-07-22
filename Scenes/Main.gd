extends Control

class MyCustomSorter:
	static func sort_large_first(a, b):
		if a > b:
			return true
		return false

onready var offense = $"Table/Offense Container/CenterContainer/Offense Container/MarginContainer/VBoxContainer/Offense"
onready var my_die = $"Table/Defense Container/CenterContainer/VBoxContainer/Die"
onready var prob_text = $"Table/Probs/CenterContainer/VBoxContainer/HBoxContainer/Prob"
onready var uni_prob_text = $"Table/Probs/CenterContainer/VBoxContainer/HBoxContainer2/Union_Prob"
onready var uni_prob_folder = $"Table/Probs/CenterContainer/VBoxContainer/HBoxContainer2"

func _calculate_probability_of_success():
	var opp_dice = _get_offense_dice()
	var probs := []
	
	for die in opp_dice:
		var numerator = 7 - die
		probs.push_back(numerator/6.0)
	
	var full_prob := 1.0
	var full_union_prob = 0
	var union_probs := []
	
	var i = 0
	for prob in probs:
		full_prob *= prob
		full_union_prob += prob
		union_probs.push_back(prob * probs[0 if i >= probs.size()-1 else i+1])
		i += 1
	
	full_union_prob += full_prob
	
	for union in union_probs:
		full_union_prob -= union
	
	return [full_prob, full_union_prob]

func _get_offense_dice():
	var dice_nums := []
	var dice = offense.get_children()
	
	for die in dice:
		dice_nums.push_back(die.Numerical_Value)
	
	dice_nums.sort_custom(MyCustomSorter,"sort_large_first")
	return dice_nums.slice(0,my_die.Numerical_Value-1)


func _on_Timer_timeout() -> void:
	 prob_text.text = String(floor(_calculate_probability_of_success()[0] * 1000)*0.1) + "%"
	 uni_prob_text.text = String(floor(_calculate_probability_of_success()[1] * 1000)*0.1) + "%"


func _on_Die_pressed() -> void:
	if my_die.Numerical_Value >= 1:
		uni_prob_folder.visible = true
	else:
		uni_prob_folder.visible = false
