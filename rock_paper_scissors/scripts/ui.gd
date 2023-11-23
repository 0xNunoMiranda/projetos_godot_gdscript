extends Control

var choices:Array[String] = ["Paper","Rock","Scissors"]
@export var player_points_label:Label 
@export var opponent_points_label:Label 
@export var result:Label 
@export var opponent_result:Label 
@onready var button = $OptionsContainer/Rock
var player_points:int = 0 
var opponent_points:int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(
		_on_button_pressed.bind(button.name)
	)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed(player_choice:String) -> void:
	var opponent_choices = choices.pick_random()
	if(opponent_choices == player_choice):
		result.text = "DRAW"
	elif(
		opponent_choices == "Paper" and 
		player_choice == "Rock"
	):
		result.text = "YOU LOSE"
		opponent_points += 1
	elif(
		opponent_choices == "Paper" and 
		player_choice == "Scissors"
	):
		result.text = "YOU WIN"
		player_points += 1
	elif(
		opponent_choices == "Rock" and 
		player_choice == "Scissors"
	):
		result.text = "YOU LOSE"
		opponent_points += 1
	elif(
		opponent_choices == "Rock" and 
		player_choice == "Paper"
	):
		result.text = "YOU WIN"
		player_points += 1
	elif(
		opponent_choices == "Scissors" and 
		player_choice == "Paper"
	):
		result.text = "YOU LOSE"
		opponent_points += 1
	elif(
		opponent_choices == "Scissors" and 
		player_choice == "Rock"
	):
		result.text = "YOU WIN"
		player_points += 1
	opponent_result.text = opponent_choices
	player_points_label.text = str(player_points)
	opponent_points_label.text = str(opponent_points) 
	print(player_choice)
	pass # Replace with function body.



