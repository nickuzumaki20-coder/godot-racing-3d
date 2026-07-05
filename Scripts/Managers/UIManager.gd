extends Node

class_name UIManager

var ui_nodes: Dictionary = {}
var is_hud_visible: bool = true

func _ready():
	if not is_in_group("managers"):
		add_to_group("managers")

func register_ui_node(node_name: String, node: Node):
	ui_nodes[node_name] = node

func get_ui_node(node_name: String) -> Node:
	return ui_nodes.get(node_name)

func show_ui(node_name: String):
	if ui_nodes.has(node_name):
		ui_nodes[node_name].visible = true

func hide_ui(node_name: String):
	if ui_nodes.has(node_name):
		ui_nodes[node_name].visible = false

func update_hud(data: Dictionary):
	if ui_nodes.has("hud"):
		var hud = ui_nodes["hud"]
		if hud.has_method("update_display"):
			hud.update_display(data)

func show_message(message: String, duration: float = 3.0):
	if ui_nodes.has("message_label"):
		var label = ui_nodes["message_label"]
		label.text = message
		label.visible = true
		yield(get_tree(), "idle_frame")
		yield(get_tree().create_timer(duration), "timeout")
		label.visible = false

func toggle_hud_visibility():
	is_hud_visible = !is_hud_visible
	for ui in ui_nodes.values():
		if ui.name.contains("hud") or ui.name.contains("HUD"):
			ui.visible = is_hud_visible
