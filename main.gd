extends Node2D
var screen_size
@export var enemy_scene: PackedScene
var enemy# Called when the node enters the scene tree for the first time.
func _ready():
	$player/attack.hide()
	$enemy/attack.hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("attack"):
		$player/attack.show()
		$player/animations.hide()
		$player/attack.animation = "attack"
		$player/attack.play()		
		$attackT.start()
		if $player/animations.flip_h == true:
			$player/attack.flip_h = true
			$player/attack.set_offset(Vector2(-10,-8))
		if  $player/animations.flip_h == false:
			$player/attack.flip_h = false
			$player/attack.set_offset(Vector2(10,-8))
	
		
