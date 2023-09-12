extends CharacterBody2D

var speed = 105
var animate = false
var die = false
var is_reviving = false
var attack = false
var is_dying = false
var is_walking = true # set to true when the enemy is dying

func _ready():
	$attacktimer.start()
var screen_size

func _process(delta):
	screen_size = get_viewport_rect().size
	
	walking(delta)
	

	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	
	

func dying():
	is_walking = false
	is_dying = true
	$animate.animation = "die"
	$animate.play()

func resurection():
	is_reviving = true
	$animate.animation = "die"
	$animate.play_backwards()


func walking(delta):
	if is_dying == true:
		return
	if attack == false:
		$animate.animation = "walk"
		$animate.play()
		position.x += speed * delta

#func _on_earea_area_entered(area):
#	dying()


func _on_attacktimer_timeout():
	if is_walking == false:
		return
	attack = true
	$attack.show()
	$animate.hide()
	$attack.animation = "attack"
	$attack.play()
	$attacktimer/attackendE.start()
	$attacktimer.start()
	#Replace with function body.


func _on_attackend_e_timeout():
	attack = false
	$animate.show()
	$attack.hide() #  # Replace with function body.








