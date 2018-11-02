extends Node

export (PackedScene) var Coin
export (int) var playtime

var level
var score
var time_left
var screensize
var playing = false

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
	
func spawn_coins():
	for i in range(4+level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0,screensize.x), 
							rand_range(0,screensize.y))
	$LevelSound.play()
		

func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 10
		spawn_coins()

func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)


func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)
	$CoinSound.play()

func _on_Player_hurt():
	game_over()
	
func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$EndSound.play()
	
	
	
	
	
	


func _on_HUD_start_game():
	new_game()
