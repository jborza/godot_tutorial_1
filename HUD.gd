extends CanvasLayer

signal start_game

func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)

func update_timer(value):
	$MarginContainer/TimeLabel.text = str(value)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	show_message("Coin Dash!")
	$MessageLabel.show()


