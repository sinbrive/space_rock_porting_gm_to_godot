extends KinematicBody2D

#signal die

var speed=0
var vel = Vector2.ZERO
var step=3
var canFire=true

onready var bullet = preload("res://Scenes/Bullet.tscn")

func _ready():
	position = Vector2(Global.WIDTH/2, Global.HEIGHT/2)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			_create_bullet()
			
func _physics_process(delta):

	if Input.is_action_pressed("move_up"):
		# move forward on the object direction 
		# well explained here : https://kidscancode.org/godot_recipes/3.x/math/transforms/index.html
		position += transform.x * step  # equivalent to position += Vector2(STEP * cos(rotation), STEP * sin(rotation))
		_wrap_it()
		
	if Input.is_action_pressed("move_left"):
		rotation_degrees += 4
	if Input.is_action_pressed("move_right"):
		rotation_degrees -= 4
	
	var collision = move_and_collide(Vector2(1,0))
	if collision:
		if collision.collider.is_in_group("rocks"):
			get_parent().get_node("Timer").start()
			self.queue_free()
				
func _wrap_it():
	if position.x > Global.WIDTH:
		position.x = 0
	if position.x<0:
		position.x = Global.WIDTH
	if position.y > Global.HEIGHT:
		position.y = 0
	if position.y<0 :
		position.y = Global.HEIGHT		
		
func _create_bullet():
	if canFire:
		canFire=false
		var inst = bullet.instance()
		inst.position=position
		inst.direction=Vector2(1,0).rotated(rotation)
		get_parent().add_child(inst)
