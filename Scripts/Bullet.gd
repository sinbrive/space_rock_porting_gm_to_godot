extends KinematicBody2D


var speed = 10
var direction

func _ready():
	add_to_group("gr_bullet")
	
func _physics_process(delta):
	position += direction*speed
	if position.x > Global.WIDTH or position.x<0 or position.y > Global.HEIGHT or position.y<0 :
#		if is_instance_valid(get_parent().get_node("Player")): 
#			get_parent().get_node("Player").canFire=true 
		self.queue_free()
		
