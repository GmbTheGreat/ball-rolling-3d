# `load_level(LevelsManager.current_level)`

Loads a fresh instance of the selected level and resets all level-related gameplay data.

## What happens?

### 1. Hide Result UI

```gdscript
game_over_ui.visible = false
win_level_ui.visible = false
```

* Hides the Game Over screen.
* Hides the Win Level screen.

---

### 2. Remove Current Level

```gdscript
for child in level_holder.get_children():
	child.queue_free()
```

* Finds the currently loaded level inside `LevelHolder`.
* Removes the old level instance from the scene.

---

### 3. Load New Level

```gdscript
var level_scene = load(level_path)
var level_instance = level_scene.instantiate()
```

* Loads the level scene file from disk.
* Creates a new instance of the level.

---

### 4. Add Level To LevelHolder

```gdscript
level_holder.add_child(level_instance)
```

* Adds the newly created level instance to the `LevelHolder` node.
* The level is now active in the scene.

---

### 5. Store Current Level Reference

```gdscript
current_level = level_instance
```

* Stores a reference to the loaded level.
* Allows the game to access level nodes later.

---

### 6. Connect Win Point Signal

```gdscript
var win_point = level_instance.get_node("win_point")
win_point.level_completed.connect(_on_level_completed)
```

* Finds the `win_point` node inside the level.
* Connects its `level_completed` signal.
* When the player reaches the win point, `_on_level_completed()` is called.

---

### 7. Reset Gameplay Data

```gdscript
hearts = 3
star_collected = false
level_time = 0.0
```

Resets all level progress:

| Variable         | Purpose                    |
| ---------------- | -------------------------- |
| `hearts`         | Player starts with 3 lives |
| `star_collected` | No star collected yet      |
| `level_time`     | Restart timer from 0       |

---

### 8. Update UI

```gdscript
timer_ui.update_time(0.0)
update_hearts_ui()
```

* Updates the timer UI.
* Updates the hearts UI.
* Displays the reset values to the player.

---

## Flow

```text
load_level()
│
├─ Hide Game Over / Win UI
├─ Remove Previous Level
├─ Load New Level Scene
├─ Add Level To LevelHolder
├─ Store Level Reference
├─ Connect Win Point Signal
├─ Reset Hearts
├─ Reset Stars
├─ Reset Timer
└─ Update UI
```

## Result

The level is completely reloaded and all gameplay progress for the current run is reset.
