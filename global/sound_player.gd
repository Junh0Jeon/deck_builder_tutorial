# autoload
# sound play와 관련된 씬이 공유하므로 수정하는데 주의를 요함!

# AudioStreamPlayer를 자식노드로 가지는 형태
extends Node


## 음악 재생 함수
## solo: 이 음악만 재생할지 유무 flag
func play(audio: AudioStream, solo = false) -> void:
	if not audio:
		push_error("AudioStream말고 다른 변수 사용 확인됨")
		return
	
	if solo:
		stop()
	
	for player in get_children():
		player = player as AudioStreamPlayer
		
		if not player.playing:
			player.stream = audio
			player.play()
			break


func stop() -> void:
	for player in get_children():
		player = player as AudioStreamPlayer
		player.stop()
