extends CharacterBody2D
@export var speed = 1000 # How fast the player will move (pixels/sec).
var screen_size
var stop = false
var playing = false


 # Size of the game window.
# Called when the node enters the scene tree for the first time.
func _ready():
	$attack.hide()
	$attack/area.position.x = 22
	$attack/area.position.y = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	screen_size = get_viewport_rect().size
	if Input.is_action_just_pressed("roll"):
		$animations.show()
		$attack.hide()
		$animations.animation = "roll"
		$animations.play()
		$animations.flip_v = false
		$animations/rollend.start()
	if Input.is_action_just_pressed("up"):
		$animations.show()
		$attack.hide()
		$animations.animation = "jump"
		playing = true
		$animations.play()
		$animations.flip_v = false
		$animations/jumpend.start()
	if Input.is_action_pressed("right"):
		$attack/area.position.x = 22
		$attack/area.position.y = 0
		$animations.show()
		$attack.hide()
		position.x += 5
		if playing == false:
			$animations.animation = "run"
			$animations.play()
			$animations.flip_h = false
		if $attack.is_playing():
			$animations.hide()
			$attack.show()
	if Input.is_action_pressed("left"):
		$attack/area.position.x = -22
		$attack/area.position.y = 0
		$animations.show()
		$attack.hide()
		position.x -= 5
		if playing == false:
			$animations.animation = "run"
			$animations.play()
			$animations.flip_h = true
		if $attack.is_playing():
			$animations.hide()
			$attack.show()
	if Input.is_action_just_released("left"):
		$animations.stop()
		$animations.animation = "ready"
		$animations.play()
	if Input.is_action_just_released("right"):
		$animations.stop()
		$animations.animation = "ready"
		$animations.play()
	if Input.is_action_pressed("attack"):
		$attack.show()
		$animations.hide()
		$attack.animation = "attack"
		$attack.play()
		$attack/attackend.start()
		if $animations.flip_h == true:
			$attack.flip_h = true
			$attack.set_offset(Vector2(-10,-8))
		if  $animations.flip_h == false:
			$attack.flip_h = false
			$attack.set_offset(Vector2(10,-8))
	
			
		# See the note below about boolean assignment.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_attackend_timeout():
	$attack.stop()

func _on_rollend_timeout():
	$animations.stop() # Replace with function body.

func _on_jumpend_timeout():
	$animations.stop()
	playing = false 

func _on_attack_2_timeout():
	pass # Replace with function body.

func _on_area_area_entered(area_that_is_entered):
	if $attack.is_playing():
		print("you've hit the enemy:", area_that_is_entered)
		area_that_is_entered.get_parent().dying()
		# we've hit the enemy
	else:
		# we're not attacking so ignore the action
		return

