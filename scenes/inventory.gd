extends ItemList

@export var reasources : Array[Resource]
var inventory_active = false
var selectedID = 0

func _process(delta):
	display_inventory()
	if inventory_active:
		inventory_interaction()

func find_resoure(change:int, item:String):
	var path = "res://resources/"
	var files = DirAccess.get_files_at(path)
	for i in files:
		if i.ends_wiith(".tres"):
			var res = load(path+i)
			if res and "name" in res:
				if res.name == item:
					reasources.append(res)
					res.number += 1
					add_item(str(res.number)+ " " + res.name, res.texture)

func inventory_management(change:int,item:String):
	var success = false
	for i in reasources:
		if i.name == item:
			i.number += change 
			set_item_text(reasources.find(i),str(i.number)+ ""+i.name)
			if i.number < 1:
				remove_item(reasources.find(i))
			success = true
			break
	if success == false:
		find_resoure(change,item)

func display_inventory():
	if Input.is_action_just_pressed("Inventory"):
		if inventory_active:
			self.visible = false
			inventory_active = false
		else:
			self.visible = true
			inventory_active = true

func inventory_interaction():
	if Input.is_action_just_pressed("left_inventory") and selectedID > 0:
		selectedID -= 1
	elif Input.is_action_just_pressed("Right_inventory") and selectedID < get_item_count() - 1:
		selectedID += 1
	select(selectedID)
	if Input.is_action_just_pressed("destroy_tiem"):
		if selectedID > len(reasources)-1:
			selectedID -= 1 
		elif selectedID < 0:
			selectedID += 1
		select(selectedID)

func _ready():
	var x = 0
	for i in reasources:
		add_item(str(i.number)+""+i.name,i.texture)
	x+=1
