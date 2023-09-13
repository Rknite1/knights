extends CharacterBody2D
@export var speed = 1000 # How fast the player will move (pixels/sec).
var screen_size
var stop = false
var playing = false
var die = false
var dead_forever = false

 # Size of the game window.
# Called when the node enters the scene tree for the first time.
func _ready():
	$attack.hide()
	$animations.animation = "ready"
	$animations.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	screen_size = get_viewport_rect().size
	if die == false:
		if Input.is_action_just_pressed("up"):
			$animations.show()
	#		$attack.hide()
			$animations.animation = "jump"
			playing = true
			$animations.play()
			$animations.flip_v = false
		if Input.is_action_pressed("right"):
			$attack/area.position.x = 20
			$attack/area.position.y = 0
			$animations.show()
	#		$attack.hide()
			position.x += 5
			if playing == false:
				$animations.animation = "run"
				$animations.play()
				$animations.flip_h = false
			if $attack.is_playing():
				$animations.hide()
				$attack.show()
		if Input.is_action_pressed("left"):
			$attack/area.position.x = -26
			$attack/area.position.y = 0
			$animations.show()
	#		$attack.hide()
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
			if dead_forever ==true:
				return
			if die == true:
				return
			$attack.show()
			$animations.hide()
			$attack.animation = "attack"
			$attack.play()
			$attack/attackend.start()
			on_attack()
		
		
		
		if $animations.flip_h == true:
			$attack.flip_h = true
			$attack.set_offset(Vector2(-10,-8))
		if  $animations.flip_h == false:
			$attack.flip_h = false
			$attack.set_offset(Vector2(10,-8))
	
			
		# See the note below about boolean assignment.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	

func _on_area_area_entered(enemy):
#	if $attack.is_playing():
#		print("you've hit the enemy:", enemy)
#		enemy.get_parent().dying() 
#	else:
##		 we're not attacking so ignore the action
#		return
	pass
 
	
func _on_attackend_timeout():
	$attack.hide()
	$animations.show() # Replace with function body.

func death():
	if dead_forever == true:
		return
	die = true
	$animations.animation = "death"
	$animations.play()
	dead_forever = true
	
	

func on_attack():
#	Constructors
#	Instance , Instantiate
#	Object
#	Array
#	Type
#	Method
#	Variable
	
	var overlapping_areas = $attack/area.get_overlapping_areas()
	print("on_attack, overlapping areas: ", overlapping_areas)
	for x in overlapping_areas:
		x.get_parent().dying() 
	
