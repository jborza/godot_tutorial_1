extends Area2D

var screensize = Vector2()

func pickup():
	monitoring = false
	$Tween.start()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Tween.interpolate_property($AnimatedSprite, "modulate",
		Color(1,1,1,1), Color(1,1,1,0), 0.3,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT)
		
	
	$Tween.interpolate_property($AnimatedSprite, "scale", 
		$AnimatedSprite.scale, $AnimatedSprite.scale * 3.0, 0.3,
		Tween.TRANS_QUAD, 
		Tween.EASE_IN_OUT)
	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Tween_tween_completed(object, key):
	queue_free()


func _on_Lifetime_timeout():
	queue_free()
