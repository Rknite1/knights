extends CharacterBody2D
var animate = false
var die = false
func _ready():
	pass
var screen_size
func _process(delta):
	screen_size = get_viewport_rect().size
	$animate.animation = "die"
	if $animate.is_playing():
		die = true
	if die == false:
		if $attack.is_playing():
			animate = true
		if animate == false:
			$animate.show()
			$animate.animation = "walk"
			$animate.play()
			position.x += 3
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_attacktimer_timeout():
	$attack.animation = "attack"
	$attack.stop() 
	$attack.hide()
	$animate.show()
	animate = false# Replace with function body.






