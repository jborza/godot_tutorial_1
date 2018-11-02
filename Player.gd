extends Area2D

export (int) var speed

var velocity = Vector2()
var screensize = Vector2(480,720)

signal pickup
signal hurt

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"
	
func die():
	$AnimatedSprite.animation = "hurt"
	set_process(false);
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
			
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite.animation = "idle"
		
func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	get_input()
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)


func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
	