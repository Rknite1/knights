extends CharacterBody2D

var speed = 105
var animate = false
var die = false

var is_dying = false # set to true when the enemy is dying

func _ready():
	pass
var screen_size

func _process(delta):
	screen_size = get_viewport_rect().size
	
	walking(delta)
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_attacktimer_timeout():
	$attack.animation = "attack"
	$attack.stop() 
	$attack.hide()
	$animate.show()
	animate = false# Replace with function body.

func dying():
	is_dying = true
	$animate.animation = "die"
	$animate.play()
	
func walking(delta):
	if is_dying:
		return
		
	$animate.animation = "walk"
	$animate.play()
	position.x += speed * delta




