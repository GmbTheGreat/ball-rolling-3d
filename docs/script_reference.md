# Script Reference — Key Scripts

This reference covers the main scripts contributors will interact with. Focus is on responsibilities, public API, and integration points.

---

## scripts/base/main/game.gd
Summary: Per-level run orchestrator and high-level game state (timer, hearts, star collected).
Attached to: scenes/main/game.tscn (root Game node).
Responsibilities:
- Instantiate loaded level, connect to win_point
- Manage run state (hearts, timer)
- Respond to ball signals (movement_started, died)
- Show UI: pause, win, game_over
Public methods/events:
- load_level(level_path: String) — load level scene immediately
- collect_star() — mark star collected
Notes & future: move level-unlock logic into LevelsManager.

---

## scripts/base/main/ball.gd
Summary: Player physics, input handling, and cosmetic application.
Attached to: scenes/main/ball.tscn (RigidBody3D).
Responsibilities:
- Movement, steering, jump, boost
- Emit signals: movement_started, died
- Manage spawn/checkpoint positions and respawn
Public API:
- respawn(), reset_to_spawn(), apply_boost(), apply_equipped_skin(), apply_equipped_trail()
Signals:
- movement_started
- died
Notes: Ball calls CosmeticsManager getters to apply skins/trails on ready.

---

## scripts/base/main/camera_3d.gd
Summary: Smooth follow camera with shake support.
Attached to: Camera3D node in scenes/main/game.tscn.
Public API:
- shake(amount: float, duration: float)
Notes: Camera reads ball.move_direction each physics frame.

---

## scripts/base/global/scene_loader.gd
Summary: Helper to perform threaded loading of the game scene and level.
API:
- target_level (set by menus)
- loaded_level_scene (set after load)
Notes: Loading UI uses ResourceLoader.load_threaded_request/get to populate loaded_level_scene.

---

## scripts/base/global/levels_manager.gd
Summary: Level metadata owner (target times and reward coins).
API (read-only helpers):
- get_target_time(), get_win_coin(), get_star_coin(), get_time_coin()
- current_level property (string path)
Notes: Add new levels to level_data to configure rewards.

---

## scripts/base/save/save_manager.gd
Summary: Persistent save container; reads/writes user://save.json.
Public data: save_data dictionary with keys total_coins, unlocked_levels, owned_* and selected_*.
API:
- save_game(), load_game()
Notes: Simple JSON approach; consider versioning for future changes.

---

## scripts/base/global/audio_manager.gd
Summary: Small global helper that exposes play_* convenience functions.
API: play_ui_click(), play_win(), play_pause()
Notes: UI and Game call AudioManager for short SFX.

---

## scripts/base/global/cosmetics_manager.gd
Summary: Owns available cosmetics, handles browsing, purchases, and equipped IDs.
Public API highlights:
- get_equipped_skin(), get_equipped_trail(), get_equipped_background()
- next(), previous(), equip_*( ) , buy_*( )
Signals: ball_change, trail_change, background_change
Notes: Interacts with SaveManager.save_data to persist purchases and selections.

---

## UI scripts (scripts/base/ui/*.gd)
- Timer UI: update_time(time_value)
- Pause/Win/GameOver/Loading UI: emit signals (retry_pressed, home_pressed, resume_pressed, etc.) and implement show_smooth() animations.

---

## Interactables & Obstacles (scripts/base/interactables/*, scripts/base/obstacles/*)
Typical responsibilities:
- Local collision handling (Area3D or body_entered signals)
- Emit signals or call small API on the ball (apply_boost, body.apply_central_impulse, etc.)
Examples:
- win_point.gd — emits level_completed
- visible_checkpoint.gd — visual checkpoint activation
- star.gd — collects star; calls current_scene.collect_star()
- boost.gd — calls body.apply_boost() and supports respawn_boost()

---

Notes on extending scripts
- Prefer emitting a high-level signal to inform Game or managers rather than mutating global state directly.
- Keep scene-local logic (visuals, short-lived timers) inside the scene script; delegate persistence and progression to managers.

If you need a machine-readable index of every script, run a small parser that enumerates scripts/ and extracts class_name and exported properties; this reference focuses on human readability and maintenance.
