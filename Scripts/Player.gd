extends KinematicBody2D

#signal die

var speed=3
var vel = Vector2.ZERO

onready var bullet = preload("res://Scenes/Bullet.tscn")

func _ready():
	position = Vector2(Global.WIDTH/2, Global.HEIGHT/2)
			
func _physics_process(delta):

#	print(get_parent().get_node("Player").get_position().y)

	if Input.is_action_pressed("move_up"):
		# move forward on the object direction 
		# well explained here : https://kidscancode.org/godot_recipes/3.x/math/transforms/index.html
		position += transform.x * speed  # equivalent to position += Vector2(STEP * cos(rotation), STEP * sin(rotation))

	if Input.is_action_pressed("move_left"):
		rotation_degrees += 4
	if Input.is_action_pressed("move_right"):
		rotation_degrees -= 4
	if Input.is_action_pressed("shoot"):
		_create_bullet()
		
	_wrap_it()
	
	var collision = move_and_collide(Vector2(0,0))

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
	if not is_instance_valid(get_parent().get_node("Bullet")):  
		var inst = bullet.instance()
		inst.position=Vector2(position)
		inst.direction=Vector2(1,0).rotated(rotation)
		get_parent().add_child(inst)
