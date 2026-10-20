@tool
extends Node

@export var generate_animations := false:
	set(value):
		generate_animations = false
		
		if Engine.is_editor_hint():
			current_sprite_size =  Vector2(16, 16)
			create_sprite_frames()

@export_group("Spritesheet")
@export_file("*.png") var character_spritesheet: String
@export var target_animated_sprite: AnimatedSprite2D
@export var sprite_size := SPRITE_SIZES.SIZE_16X16
@export var character_type := CHARACTER_TYPE.ADULT
@export var animation_fps := 7
@export_group("Adult Animations")
@export var idle := true
@export var standing_horizontal := true
@export var walk := true
@export var walk_with_object := true
@export var seated := true
@export var sleeping_head := true
@export var grab_and_drop_object := true
@export var give_object := true
@export var pickup := true
@export var phone := true
@export var reading := true
@export var punch := true
@export var punch_variant := true
@export var hand_throw := true
@export var pull_out_gun := true
@export var gun_idle := true
@export var gun_shoot := true
@export var hurt := true
@export_group("Kid animations")
@export var idle_kid := true
@export var walk_kid := true



enum SPRITE_SIZES {
	SIZE_16X16,
	SIZE_32X32,
	SIZE_48X48
}

enum CHARACTER_TYPE {
	ADULT,
	KID
}

var image: Texture2D

var multiplier := 1 # To adjust frame step increase based on the sprite size selected
var current_sprite_size := Vector2(16, 16)


func _calculate_multiplier() -> int:
	var multiplier := 1
	
	match sprite_size:
		SPRITE_SIZES.SIZE_16X16:
			multiplier = 1
		SPRITE_SIZES.SIZE_32X32:
			multiplier = 2
		SPRITE_SIZES.SIZE_48X48:
			multiplier = 3
		_:
			multiplier = 1
			
	return multiplier


func create_sprite_frames():
	assert(character_spritesheet is String and ResourceLoader.exists(character_spritesheet), "CharacterCreatorToolImporter: This tool needs a valid path to character spritesheet file")
	
	image = ResourceLoader.load(character_spritesheet, "CompressedTexture2D", ResourceLoader.CACHE_MODE_REPLACE)
	
	if target_animated_sprite is AnimatedSprite2D:
		target_animated_sprite.sprite_frames = null
		
	var sprite_frames := SpriteFrames.new()
	sprite_frames.remove_animation("default")

	multiplier = _calculate_multiplier() 
	current_sprite_size *= multiplier
	
	if character_type == CHARACTER_TYPE.ADULT:	
		_create_idle_animation_frames(sprite_frames, image)
		_create_walk_animation_frames(sprite_frames, image)
		_create_sleep_animation_frames(sprite_frames, image)
		_create_seated_animation_frames(sprite_frames, image)
		_create_standing_animation_frames(sprite_frames, image)
		_create_reading_animation_frames(sprite_frames, image)
		_create_phone_animation_frames(sprite_frames, image)
		_create_walk_with_object_animation_frames(sprite_frames, image)
		_create_give_object_animation_frames(sprite_frames, image)
		_create_grab_drop_object_animation_frames(sprite_frames, image)
		_create_pickup_animation_frames(sprite_frames, image)
		_create_punch_animation_frames(sprite_frames, image)
		_create_hand_throw_animation_frames(sprite_frames, image)
		_create_pull_out_gun_animation_frames(sprite_frames, image)
		_create_gun_idle_animation_frames(sprite_frames, image)
		_create_gun_shoot_animation_frames(sprite_frames, image)
		_create_hurt_animation_frames(sprite_frames, image)
		
	if character_type == CHARACTER_TYPE.KID:
		_create_idle_kid_animation_frames(sprite_frames, image)
		_create_walk_kid_animation_frames(sprite_frames, image)
		
		
	if target_animated_sprite is AnimatedSprite2D:
		target_animated_sprite.sprite_frames = 	sprite_frames
	else:
		target_animated_sprite = AnimatedSprite2D.new()
		target_animated_sprite.sprite_frames = 	sprite_frames
		add_child(target_animated_sprite)
		target_animated_sprite.owner = get_tree().edited_scene_root


func _create_idle_kid_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if idle_kid:	
		var frame_data = _get_frame_data_based_on_size("idle_kid", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var idle := {
			"right": {"number_of_frames": 6},
			"up": {"number_of_frames": 6},
			"left": {"number_of_frames": 6},
			"down": {"number_of_frames": 6},
		}
			
		var index := 0
		
		for direction in idle.keys():
			var animation_name = "idle_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(idle[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_walk_kid_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if idle_kid:	
		var frame_data = _get_frame_data_based_on_size("walk_kid", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var walk := {
			"right": {"number_of_frames": 6},
			"up": {"number_of_frames": 6},
			"left": {"number_of_frames": 6},
			"down": {"number_of_frames": 6},
		}
			
		var index := 0
		
		for direction in walk.keys():
			var animation_name = "walk_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(walk[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_gun_idle_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if gun_idle:	
		var frame_data = _get_frame_data_based_on_size("gun_idle", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var gun_idle := {
			"right": {"number_of_frames": 6},
			"up": {"number_of_frames": 6},
			"left": {"number_of_frames": 6},
			"down": {"number_of_frames": 6},
		}
			
		var index := 0
		
		for direction in gun_idle.keys():
			var animation_name = "gun_idle_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(gun_idle[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_gun_shoot_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if gun_shoot:	
		var frame_data = _get_frame_data_based_on_size("gun_shoot", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var gun_shoot := {
			"right": {"number_of_frames": 3, "last_frame": {"animation": "gun_idle", "index": 0}},
			"up": {"number_of_frames": 3,  "last_frame": {"animation": "gun_idle", "index": 6}},
			"left": {"number_of_frames": 3,  "last_frame": {"animation": "gun_idle", "index": 12}},
			"down": {"number_of_frames": 3,  "last_frame": {"animation": "gun_idle", "index": 18}},
		}
			
		var index := 0
		
		for direction in gun_shoot.keys():
			var animation_name = "gun_shoot_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			## We create an extra frame from gun idle so as not to need to return to idle after this animation
			var last_frame_data = _get_frame_data_based_on_size(gun_shoot[direction].last_frame.animation, sprite_size)
			var last_frame_index = gun_shoot[direction].last_frame.index
			_create_frame(sprite_frames, animation_name, last_frame_index, last_frame_data.position, last_frame_data.size, frame_duration, frame_data.loopable)
			
			for _i in range(gun_shoot[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1
			
			_create_frame(sprite_frames, animation_name, last_frame_index, last_frame_data.position, last_frame_data.size, frame_duration, frame_data.loopable)


func _create_pull_out_gun_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if pull_out_gun:	
		var frame_data = _get_frame_data_based_on_size("pull_out_gun", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var pull_out_gun := {
			"right": {"number_of_frames": 4},
			"up": {"number_of_frames": 4},
			"left": {"number_of_frames": 4},
			"down": {"number_of_frames": 4},
		}
			
		var index := 0
		
		for direction in pull_out_gun.keys():
			var animation_name = "pull_out_gun_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(pull_out_gun[direction].number_of_frames):
				if index not in [3, 7, 11, 15]:
					_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1

		
func _create_punch_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if punch:	
		var frame_data = _get_frame_data_based_on_size("punch", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var punch := {
			"right": {"number_of_frames": 6},
			"up": {"number_of_frames": 6},
			"left": {"number_of_frames": 6},
			"down": {"number_of_frames": 6},
		}
			
		var index := 0
		
		for direction in punch.keys():
			var animation_name = "punch_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(punch[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_punch_variant_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if punch_variant:	
		var frame_data = _get_frame_data_based_on_size("punch_variant", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var punch_variant := {
			"right": {"number_of_frames": 6},
			"up": {"number_of_frames": 6},
			"left": {"number_of_frames": 6},
			"down": {"number_of_frames": 6},
		}
			
		var index := 0
		
		for direction in punch_variant.keys():
			var animation_name = "punch_variant_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(punch_variant[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1



func _create_hand_throw_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if hand_throw:	
		var frame_data = _get_frame_data_based_on_size("hand_throw", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var hand_throw := {
			"right": {"number_of_frames": 6},
			"up": {"number_of_frames": 6},
			"left": {"number_of_frames": 6},
			"down": {"number_of_frames": 6},
		}
			
		var index := 0
		
		for direction in hand_throw.keys():
			var animation_name = "hand_throw_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(hand_throw[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_hurt_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if hurt:	
		var frame_data = _get_frame_data_based_on_size("hurt", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var hurt := {
			"right": {"number_of_frames": 3},
			"up": {"number_of_frames": 3},
			"left": {"number_of_frames": 3},
			"down": {"number_of_frames": 3},
		}
			
		var index := 0
		
		for direction in hurt.keys():
			var animation_name = "hurt_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(hurt[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_grab_drop_object_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):	
	if grab_and_drop_object:
		var frame_data = _get_frame_data_based_on_size("grab_object", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var grab_object := {
			"right": {"grab": {"number_of_frames": 8}, "drop": {"number_of_frames": 6}},
			"up": {"grab": {"number_of_frames": 8}, "drop": {"number_of_frames": 6}},
			"left": {"grab": {"number_of_frames": 8}, "drop": {"number_of_frames": 6}},
			"down": {"grab": {"number_of_frames": 8}, "drop": {"number_of_frames": 6}},
		}
			
		var index := 0
		
		for direction in grab_object.keys():
			for action in grab_object[direction].keys():
				var animation_name = "%s_object_%s" % [action, direction]
				sprite_frames.add_animation(animation_name)
				
				for _i in range(grab_object[direction][action].number_of_frames):
					_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
					index += 1



func _create_give_object_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):	
	if give_object:
		var frame_data = _get_frame_data_based_on_size("give_object", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var give_object := {
			"right": {"number_of_frames": 10},
			"up": {"number_of_frames": 10},
			"left": {"number_of_frames": 10},
			"down": {"number_of_frames": 10},
		}
			
		var index := 0
		
		for animation in give_object.keys():
			var animation_name = "give_object_%s" % animation
			sprite_frames.add_animation(animation_name)
			
			for _i in range(give_object[animation].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_pickup_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):	
	if pickup:
		var frame_data = _get_frame_data_based_on_size("pickup", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var pickup := {
			"right": {"number_of_frames": 12},
			"up": {"number_of_frames": 12},
			"left": {"number_of_frames": 12},
			"down": {"number_of_frames": 12},
		}
			
		var index := 0
		
		for direction in pickup.keys():
			var animation_name = "pickup_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(pickup[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_walk_with_object_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):	
	if walk_with_object:
		var frame_data = _get_frame_data_based_on_size("walk_with_object", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var walk_object := {
			"right": {"number_of_frames": 6},
			"up": {"number_of_frames": 6},
			"left": {"number_of_frames": 6},
			"down": {"number_of_frames": 6},
		}
			
		var index := 0
		
		for direction in walk_object.keys():
			var animation_name = "walk_with_object_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(walk_object[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_phone_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):	
	if phone:
		var frame_data = _get_frame_data_based_on_size("phone", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var phone_animations := {
			"pull_out": {"number_of_frames": 5, "loopable": false},
			"idle": {"number_of_frames": 2, "loopable": true},
			"save": {"number_of_frames": 5, "loopable": false, "last_frame": {"animation": "idle", "index": 19}}
		}
		
		var index := 0
		
		for animation in phone_animations.keys():
			var animation_name = "phone_%s" % animation
			sprite_frames.add_animation(animation_name)
			
			if animation_name == "phone_idle":
				sprite_frames.add_animation("phone_idle_static")
				_create_frame(sprite_frames, "phone_idle_static", index, frame_position, frame_size, frame_duration, phone_animations[animation].loopable)
				
			for _i in range(phone_animations[animation].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, phone_animations[animation].loopable)
				index += 1
			
			if animation_name == "phone_save":
				var last_frame_data = _get_frame_data_based_on_size(phone_animations[animation].last_frame.animation, sprite_size)
				var last_frame_index = phone_animations[animation].last_frame.index
				_create_frame(sprite_frames, animation_name, last_frame_index, last_frame_data.position, last_frame_data.size, frame_duration,  phone_animations[animation].loopable)
			


func _create_reading_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if reading:
		var animation_name = "reading"
		
		var frame_data = _get_frame_data_based_on_size(animation_name, sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var number_of_frames := 12
		
		sprite_frames.add_animation(animation_name)
		
		for index in range(number_of_frames):
			_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
			
			
func _create_standing_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):	
	if standing_horizontal:
		var frame_data = _get_frame_data_based_on_size("standing", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var standing := {
			"right": {"number_of_frames": 6},
			"left": {"number_of_frames": 6}
		}
		
		var index := 0
		
		for direction in standing.keys():
			var animation_name = "standing_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(standing[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_seated_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):	
	if seated:
		var frame_data = _get_frame_data_based_on_size("seated", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var seated := {
			"right": {"number_of_frames": 6},
			"left": {"number_of_frames": 6}
		}
		
		var index := 0
		
		for direction in seated.keys():
			var animation_name = "seated_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(seated[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_sleep_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if sleeping_head:
		var animation_name = "sleeping_head"
		
		var frame_data = _get_frame_data_based_on_size(animation_name, sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var number_of_frames := 6
		
		sprite_frames.add_animation(animation_name)
		
		for index in range(number_of_frames):
			_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)


func _create_walk_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if walk:
		var frame_data = _get_frame_data_based_on_size("walk", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var walk := {
				"right": {"number_of_frames": 6},
				"up": {"number_of_frames": 6},
				"left": {"number_of_frames": 6},
				"down": {"number_of_frames": 6},
			}
		
		var index := 0
		
		for direction in walk.keys():
			var animation_name = "walk_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(walk[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_idle_animation_frames(sprite_frames: SpriteFrames, image: CompressedTexture2D):
	if idle:
		var frame_data = _get_frame_data_based_on_size("idle", sprite_size)
		var frame_position = frame_data.position
		var frame_size = frame_data.size
		var frame_duration := 1.0
		
		var idle := {
				"right": {"number_of_frames": 6},
				"up": {"number_of_frames": 6},
				"left": {"number_of_frames": 6},
				"down": {"number_of_frames": 6},
			}
		
		var index := 0 # The index is sum on all iterations to keep increasing right.x in this specific spritesheet line
		
		for direction in idle.keys():
			var animation_name = "idle_%s" % direction
			sprite_frames.add_animation(animation_name)
			
			for _i in range(idle[direction].number_of_frames):
				_create_frame(sprite_frames, animation_name, index, frame_position, frame_size, frame_duration, frame_data.loopable)
				index += 1


func _create_atlas_texture_from_frame(region: Rect2, image: CompressedTexture2D) -> AtlasTexture:
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = image
	atlas_texture.region = region
	
	return atlas_texture


func _create_frame(sprite_frames: SpriteFrames,
	 animation_name: String,
	 index: int,
	 frame_position: Vector2,
	 frame_size: Vector2,
	 frame_duration: float = 1.0, 
	 loopable: bool = true
	):
	var region = Rect2(Vector2(frame_position.x + current_sprite_size.x * index, frame_position.y), frame_size)
	
	sprite_frames.add_frame(animation_name, _create_atlas_texture_from_frame(region, image), frame_duration)
	sprite_frames.set_animation_loop(animation_name, loopable)
	sprite_frames.set_animation_speed(animation_name, animation_fps)
	
	
func _get_frame_data_based_on_size(animation: String, sprite_size: SPRITE_SIZES) -> Dictionary:
	const size_16_default := Vector2(16, 32)
	const size_32_default := Vector2(32, 64)
	const size_48_default := Vector2(48, 96)
	
	const size_16_kid_default := Vector2(16, 24)
	const size_32_kid_default := Vector2(32, 48)
	const size_48_kid_default := Vector2(48, 64)
	
	match animation:
		"idle_kid":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 40), "size": size_16_kid_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 80), "size": size_32_kid_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 128), "size": size_48_kid_default, "loopable": true}		
		"walk_kid":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 72), "size": size_16_kid_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 144), "size": size_32_kid_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 224), "size": size_48_kid_default, "loopable": true}
		"idle":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 32), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 64), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 96), "size": size_48_default, "loopable": true}
		"walk":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 64), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 128), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 192), "size": size_48_default, "loopable": true}
		"sleeping_head":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 96), "size": Vector2(16, 24), "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 200), "size": Vector2(32, 32), "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 296), "size": Vector2(48, 56), "loopable": true}
		"seated":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 128), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 256), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 384), "size": size_48_default, "loopable": true}
		"standing":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 160), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 320), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 480), "size": size_48_default, "loopable": true}
		"reading":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 224), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 448), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 672), "size": size_48_default, "loopable": true}
		"phone":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 192), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 384), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 476), "size": size_48_default, "loopable": true}
		"walk_with_object":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 256), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 512), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 768), "size": size_48_default, "loopable": true}
		"give_object":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 320), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 640), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 960), "size": size_48_default, "loopable": false}
		"grab_object":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 352), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 704), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1056), "size": size_48_default, "loopable": false}		
		"pickup":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 288), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 576), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 864), "size": size_48_default, "loopable": false}	
		"hand_throw":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 416), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 832), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1248), "size": size_48_default, "loopable": false}
		"punch":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 448), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 896), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1340), "size": size_48_default, "loopable": false}
		"punch_variant":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 480), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 960), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1440), "size": size_48_default, "loopable": false}
		"pull_out_gun":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 512), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 1024), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1536), "size": size_48_default, "loopable": false}
					
		"gun_idle":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 544), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 1088), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1632), "size": size_48_default, "loopable": true}
		"gun_shoot":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 576), "size": size_16_default, "loopable": false}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 1152), "size": size_32_default, "loopable": false} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1728), "size": size_48_default, "loopable": false}
		"hurt":
			match sprite_size:
				SPRITE_SIZES.SIZE_16X16:
					return {"position": Vector2(0, 608), "size": size_16_default, "loopable": true}
				SPRITE_SIZES.SIZE_32X32:
					return {"position": Vector2(0, 1216), "size": size_32_default, "loopable": true} 
				SPRITE_SIZES.SIZE_48X48:
					return {"position": Vector2(0, 1818), "size": size_48_default, "loopable": true}
	return {}
