extends KinematicBody2D

var direction
var speed=1

func _ready():
	add_to_group("rocks")
	randomize()
	rotation_degrees = rand_range(0,360)
	direction=rand_range(0,PI)

func _physics_process(delta):

	position += speed*Vector2(cos(direction), sin(direction))
	rotation_degrees +=1
	# wrap it
	wrap_it()
	# collision
	var collision = move_and_collide(Vector2(1,0))
	if collision:
		if collision.collider.is_in_group("gr_bullet"):
			
			get_parent().points+=50
			
			direction=rand_range(0,PI)
						
			var body = collision.collider
			body.queue_free()
			
			if is_instance_valid(get_parent().get_node("Player")): 
				get_parent().get_node("Player").canFire=true
			
			if not self.is_in_group("small_rock"):
				$Sprite.texture = load("res://Assets/spr_rock_small.png")
				add_to_group("small_rock")
				# second one
				get_parent().add_child(self.duplicate())
				
			elif get_tree().get_nodes_in_group("rocks").size() < 12:
				$Sprite.texture = load("res://Assets/spr_rock_big.png")
				remove_from_group("small_rock")
				position.x=-100
				
			else:
				self.queue_free()
				
func wrap_it():
	if position.x > Global.WIDTH+100:
		position.x = 0
	if position.x<-100:
		position.x = Global.WIDTH
	if position.y > Global.HEIGHT+100:
		position.y = 0
	if position.y<-100 :
		position.y = Global.HEIGHT		
