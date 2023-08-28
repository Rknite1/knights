extends CharacterBody2D
var animate = false
func _ready():
	$timer.start()
var screen_size
func _process(delta):
	screen_size = get_viewport_rect().size
	if $attack.is_playing():
		animate = true
	if animate == false:
		$animate.show()
		$animate.animation = "walk"
		$animate.play()
		position.x += 3
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_timer_timeout():
	$attack.show()
	$animate.hide()
	$attack.animation = "attack" # Replace with function body.
	$attack.play()
	$attacktimer.start()


func _on_attacktimer_timeout():
	$attack.animation = "attack"
	$attack.stop() 
	$attack.hide()
	animate = false# Replace with function body.


func _on_earea_area_entered(area):
	pass # Replace with function body.




func _on_attack_t_timeout():
	hide() # Replace with function body.
