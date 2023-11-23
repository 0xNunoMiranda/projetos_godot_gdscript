extends Node2D

var grid : Array[Array] = [
	["","",""],
	["","",""],
	["","",""]
]

enum Turn_State{IDLE,PLAYER,OPPONENT}

@export var game_state:Turn_State = 0
@export var sprite_symbols : Sprite2D
var focused_cell:String = ""
var position_cell:ColorRect = null
var symbol_grid :String=""
var who_wins : String =""
# Called when the node enters the scene tree for the first time.
func _ready():
	$ModalContainer.set_visible(false)
	sprite_symbols.texture=load('res://assets/symbols_spritesheet.png')
	sprite_symbols.hframes = 2
	if(game_state == 1 || game_state == 0): 
		sprite_symbols.frame =0
	else:
		sprite_symbols.frame =1
	print(Turn_State)
	for n in $PlayingContainer.get_children():
		n.modulate = Color(1,1,1,0.1)
		n.mouse_entered.connect(put_symbol.bind(n))
		n.mouse_exited.connect(putout_symbol.bind(n))
		pass
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var get_mouse = get_global_mouse_position()
	$CursorSprite.global_position = get_mouse
	$CursorSprite.modulate = Color(1, 1, 1, 0.5)
	$CursorSprite.scale = Vector2(0.5,0.5)
	if(
		focused_cell != "" && 
		Input.is_action_just_released("fire")&&
		position_cell != null
		):
			

			var index :int = focused_cell.to_int()
			if(index>=0 && index <=2):
				player_turn(0,index)	
			elif(index>=3 && index <=5):
				player_turn(1,index-3)
			else:
				player_turn(2,index-6)
				



				
	pass

func put_symbol(n )->void:
	print(n.name)
	focused_cell = n.name
	position_cell = n
	n.modulate = Color(1,1,1,1)
	pass

func putout_symbol(n )->void:
	print(n.name)
	focused_cell = ""
	position_cell = null
	n.modulate = Color(1,1,1,0.1)
	pass

func player_turn(_row:int, _column:int):
	if(grid[_row][_column]==""):
		if(game_state == 1):
			grid[_row][_column]="x"
			var symbol :Sprite2D= Sprite2D.new()
			symbol.texture = sprite_symbols.texture
			symbol.hframes = sprite_symbols.hframes
			symbol.frame = 0
			symbol.centered = false
			symbol.global_position = position_cell.global_position
			position_cell=null
			$SymbolsPlayed.add_child(symbol)
			game_state = 2
			$CursorSprite.frame = 1
		elif(game_state == 2):
			grid[_row][_column]="o"
			var symbol :Sprite2D= Sprite2D.new()
			symbol.texture = sprite_symbols.texture
			symbol.hframes = sprite_symbols.hframes
			symbol.frame = 1
			symbol.centered = false
			symbol.global_position = position_cell.global_position
			position_cell=null
			$SymbolsPlayed.add_child(symbol)
			game_state = 1
			$CursorSprite.frame = 0
	
	# Print Rows
	print(grid)
	
	# Print Columns
	var columns = []
	for idx in range(3):
		var column = [grid[0][idx],grid[1][idx],grid[2][idx]]	
		columns.append(column)
	print(columns)
	
	# Print Diagonals
	var diagonals = [
	[grid[0][0],grid[1][1],grid[2][2]],
	[grid[0][2],grid[1][1],grid[2][0]]
	]
	print(diagonals)
	
	# Triples
	
	for i in (grid + columns + diagonals):
		if(i[0]=="x" and i[1]=="x" and i[2]=="x"):
			print("Player X Wins")
			$ModalContainer.set_visible(true)
			var modal:Sprite2D = $ModalContainer.get_node("ModalSprite")
			modal.frame=2
		if(i[0]=="o" and i[1]=="o" and i[2]=="o"):
			print("Player O Wins")
			$ModalContainer.set_visible(true)
		pass



func _on_play_button_pressed():
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().quit()
