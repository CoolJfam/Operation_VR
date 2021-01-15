extends Node

var tiles = []
var cafe_spots = []
var map_size =Vector2()

var number_of_beacons = 20
var number_of_parked_cars = 100
var number_of_billboards = 75
var number_of_traffic_cones = 40
var number_of_hydrants = 50
var number_of_streetlights = 50
var number_of_dumpsters = 25
var number_of_scaffolding = 25
var number_of_cafes = 20

signal cop_spawn


func _ready():
	set_multiplier()


func set_multiplier():
	number_of_beacons = number_of_beacons * Network.prop_multiplier
	number_of_parked_cars = number_of_parked_cars * Network.prop_multiplier
	number_of_billboards = number_of_billboards * Network.prop_multiplier
	number_of_traffic_cones = number_of_traffic_cones * Network.prop_multiplier
	number_of_hydrants = number_of_hydrants * Network.prop_multiplier
	number_of_streetlights = number_of_streetlights * Network.prop_multiplier
	number_of_dumpsters = number_of_dumpsters * Network.prop_multiplier
	number_of_scaffolding = number_of_scaffolding * Network.prop_multiplier
	number_of_cafes = number_of_cafes * Network.prop_multiplier


func generate_props(tile_list, size, plazas):
	tiles = tile_list
	cafe_spots = plazas
	map_size = size
	place_beacon()
	place_cars()
	place_billboards()
	place_traffic_cones()
	place_hydrants()
	place_streetlights()
	place_scaffolding()
	place_cafes()

func random_tile(tile_count): 
	var tile_list = tiles
	var selected_tiles = []
	tile_list.shuffle()
	for i in range(tile_count):
		var tile = tile_list[i]
		selected_tiles.append(tile)
	return selected_tiles


func place_beacon():
	var tile_list = random_tile(number_of_beacons + 1)
	for i in range(number_of_beacons):
		var tile = tile_list[0]
		rpc("spawn_beacons", tile)
		tile_list.pop_front()
	rpc("spawn_goal", tile_list[0])


sync func spawn_beacons(tile):
	var beacon = preload("res://Beacon/Beacon.tscn").instance()
	beacon.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	add_child(beacon, true)

sync func spawn_goal(tile):
	var goal = preload("res://Beacon/Goal.tscn").instance()
	goal.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	add_child(goal, true)
	emit_signal("cop_spawn", goal.translation)


func place_cars():
	var tile_list = random_tile(number_of_parked_cars + number_of_dumpsters)
	for i in range(number_of_parked_cars):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, 0, tile.z)
		var allowed_rotations = $ObjectRotLookup.lookup_rotation(tile_type)
		if not allowed_rotations == null:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size() -1] *-1
			tile.y = tile.y+0.5
			rpc("spawn_cars", tile, tile_rotation)
		tile_list.pop_front()
	place_dumpsters(tile_list)

sync func spawn_cars(tile, car_rotation):
	var car = preload("res://Props/ParkedCars.tscn").instance()
	car.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	car.rotation_degrees.y = car_rotation
	add_child(car, true)


func place_dumpsters(tile_list):
	for i in range(number_of_dumpsters):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, 0, tile.z)
		var allowed_rotations = $ObjectRotLookup.lookup_rotation(tile_type)
		if not allowed_rotations == null:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size() -1] *-1
			tile.y = tile.y+0.5
			rpc("spawn_dumpsters", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_dumpsters(tile, dumpster_rotation):
	var dumpster = preload("res://Props/Dumpster/Dumpster.tscn").instance()
	dumpster.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	dumpster.rotation_degrees.y = dumpster_rotation
	add_child(dumpster, true)


func place_billboards():
	var tile_list = random_tile(number_of_billboards)
	for i in range(number_of_billboards):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, 0, tile.z)
		var allowed_rotations = $ObjectRotLookup.lookup_rotation(tile_type)
		if not allowed_rotations == null:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size() -1] *-1
			tile.y = tile.y+0.5
			rpc("spawn_billboards", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_billboards(tile, billboard_rotations):
	var billboards = preload("res://Props/Billboards/Billboard.tscn").instance()
	billboards.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	billboards.rotation_degrees.y = billboard_rotations
	add_child(billboards, true)


func place_traffic_cones():
	var tile_list = random_tile(number_of_traffic_cones)
	for i in range(number_of_traffic_cones):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, 0, tile.z)
		var allowed_rotations = $ObjectRotLookup.lookup_rotation(tile_type)
		if not allowed_rotations == null:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size() -1] *-1
			tile.y = tile.y+0.5
			rpc("spawn_traffic_cones", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_traffic_cones(tile, traffic_cones_rotation):
	var traffic_cones = preload("res://Props/TrafficCones/TrafficCones.tscn").instance()
	traffic_cones.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	traffic_cones.rotation_degrees.y = traffic_cones_rotation
	add_child(traffic_cones, true)


func place_hydrants():
	var tile_list = random_tile(number_of_hydrants)
	for i in range(number_of_hydrants):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, 0, tile.z)
		var allowed_rotations = $ObjectRotLookup.lookup_rotation(tile_type)
		if not allowed_rotations == null:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size() -1] *-1
			tile.y = tile.y+0.5
			rpc("spawn_hydrants", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_hydrants(tile, hydrant_rotation):
	var hydrant = preload("res://Props/Hydrant/Hydrant.tscn").instance()
	hydrant.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	hydrant.rotation_degrees.y = hydrant_rotation
	add_child(hydrant, true)


func place_streetlights():
	var tile_list = random_tile(number_of_streetlights)
	for i in range(number_of_streetlights):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, 0, tile.z)
		var allowed_rotations = $ObjectRotLookup.lookup_rotation(tile_type)
		if not allowed_rotations == null:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size() -1] *-1
			tile.y = tile.y+0.5
			rpc("spawn_streetlights", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_streetlights(tile, streetlight_rotation):
	var streetlight = preload("res://Props/StreetLight/StreetLight.tscn").instance()
	streetlight.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	streetlight.rotation_degrees.y = streetlight_rotation
	add_child(streetlight, true)


func place_scaffolding():
	var tile_list = random_tile(number_of_scaffolding)
	for i in range(number_of_scaffolding):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, 0, tile.z)
		var allowed_rotations = $ObjectRotLookup.lookup_rotation(tile_type)
		if not allowed_rotations == null:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size() -1] *-1
			tile.y = tile.y+0.5
			rpc("spawn_scaffolding", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_scaffolding(tile, scaffolding_rotation):
	var scaffolding = preload("res://Props/Scaffolding/Scaffolding.tscn").instance()
	scaffolding.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	scaffolding.rotation_degrees.y = scaffolding_rotation
	add_child(scaffolding, true)


func place_cafes():
	cafe_spots.shuffle()
	for i in range(number_of_cafes):
		var tile = cafe_spots[i]
		var builing_rotation = tile[0]
		var tile_position = Vector3(tile[1], 0.5, tile[2])
		var tile_rotation = 0
		
		if builing_rotation == 10:
			tile_rotation = 180
		elif builing_rotation == 16:
			tile_rotation = 90
		elif builing_rotation == 22:
			tile_rotation = 270
		rpc("spawn_cafes", tile_position, tile_rotation)


sync func spawn_cafes(tile, cafe_rotation):
	var cafe = preload("res://Props/Cafe/Cafe.tscn").instance()
	cafe.translation = Vector3( (tile.x * 20) +10, tile.y, (tile.z*20)+10)
	cafe.rotation_degrees.y = cafe_rotation
	add_child(cafe, true)












