extends Node

# Bổ sung thêm các chỉ số tay (arm), chân (leg), ngực (chest), và bộ phận tùy chọn (appendages)
var character_stats = {
	"name": "",
	"arm": 0,
	"leg": 0,
	"chest": 0,
	"appendages": 0,
	"sprite_path": "",
	"frame_count": 0
}

# Đặt chỉ số cho chiến binh
func set_speed_stats():
	character_stats = {
		"name": "Fenrir",
		"arm": 6,       # Sức mạnh tay
		"leg": 7,       # Tốc độ chân
		"chest": 6,    # Phòng thủ ngực
		"appendages": 7, # Khả năng linh hoạt (đuôi/cánh)
		"sprite_path": "res://Monster/Hắc Lang - Black Wolf/TimberWolf.png",
		"frame_count": 4
	}

# Đặt chỉ số cho sát thủ (rogue)
func set_attack_stats():
	character_stats = {
		"name": "Bolg",
		"arm": 8,       # Sức mạnh tay
		"leg": 6,      # Tốc độ chân
		"chest": 5,     # Phòng thủ ngực
		"appendages": 6, # Khả năng linh hoạt (đuôi/cánh)
		"sprite_path": "res://Monster/Troll Đá - Stone Troll/Stone Troll/StoneTroll.png",
		"frame_count": 4
	}

# Đặt chỉ số cho pháp sư (mage)
func set_health_stats():
	character_stats = {
		"name": "Placidusax",
		"arm": 7,      # Sức mạnh tay
		"leg": 6,       # Tốc độ chân
		"chest": 8,     # Phòng thủ ngực
		"appendages": 5, # Khả năng linh hoạt (đuôi/cánh)
		"sprite_path": "res://Monster/Rồng Đồng - Bronze Dragon/Mature Bronze Dragon/MatureBronzeDragon.png",
		"frame_count": 4
	}

# Lấy tất cả chỉ số hiện tại của nhân vật
func get_stats():
	return character_stats
	
func update_stats(body_part: String, value: int):
	if body_part.to_lower() in character_stats:
		character_stats[body_part.to_lower()] += value
