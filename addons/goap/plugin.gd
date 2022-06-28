tool
extends EditorPlugin

var editor = null
var edited_object: GOAPActionPlanner = null

var _bottom_panel = null


func _enter_tree():
	var selection = get_editor_interface().get_selection().get_selected_nodes()

	editor = preload("res://addons/goap/tools/goap_editor.tscn").instance()

	_bottom_panel = add_control_to_bottom_panel(editor, "GOAP")


func _exit_tree():
	if editor != null:
		remove_control_from_bottom_panel(editor)
		editor.queue_free()
		editor = null


func handles(object: Object):
	var _last = edited_object

	# handle if selected chiled of a GOAPActionPlanner
	var selection = get_editor_interface().get_selection().get_selected_nodes()
	if object.script == preload("res://addons/goap/goap_action_planner.gd"):
		edited_object = object
	elif selection.size() == 1 and selection[0].get_parent() is GOAPActionPlanner:
		edited_object = selection[0].get_parent()
	else:
		edited_object = null

	if edited_object != null and edited_object != _last:
		editor.edit(edited_object)
		return true

	if not (edited_object is GOAPActionPlanner):
		editor.clear()

	return false
