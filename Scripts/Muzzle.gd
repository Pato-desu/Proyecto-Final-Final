extends Position2D

export var direction = Vector2.ZERO

export var period = 0.0
var period_timer
export var time_to_wake_up = 0.0
var to_wake_up_timer
export var time_active = 0.0
var active_timer
export var time_passive = 0.0
var passive_timer

func _ready():
	if period:
		period_timer = Timer.new()
		period_timer.wait_time = period
		period_timer.connect("timeout", self, "shoot")
		if time_active and time_passive:
			active_timer = Timer.new()
			active_timer.wait_time = time_active
			active_timer.one_shot = true
			active_timer.connect("timeout", self, "going_to_sleep")
			passive_timer = Timer.new()
			passive_timer.wait_time = time_passive
			passive_timer.one_shot = true
			passive_timer.connect("timeout", self, "waking_up")
		if time_to_wake_up:
			to_wake_up_timer = Timer.new()
			to_wake_up_timer.wait_time = time_to_wake_up
			to_wake_up_timer.one_shot = true
			to_wake_up_timer.connect("timeout", self, "waking_up")
			to_wake_up_timer.start()
		else:
			waking_up()

func waking_up():
	period_timer.start()
	active_timer.start()
	
func going_to_sleep():
	period_timer.stop()
	passive_timer.start()

func shoot():
	pass
