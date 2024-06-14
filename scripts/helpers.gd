extends Node

func apply_camera_shake(per):
	var cams = get_tree().get_nodes_in_group("camera")
	
	if cams.size() > 0:
		cams[0].apply_shake(per)
