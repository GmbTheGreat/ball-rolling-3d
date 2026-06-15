# Managers and Autoloads

This project uses a small set of singletons (autoloads) to centralize cross-cutting state and APIs.

## SaveManager (scripts/base/save/save_manager.gd)
Purpose: Persist and expose player progression and owned cosmetics.
Responsibilities:
- Provide `save_data` dictionary used by other systems
- Read/write user://save.json using JSON.stringify
Public API:
- save_game()
- load_game()
Data ownership:
- total_coins, unlocked_levels, owned_trails, owned_balls, owned_backgrounds, selected_* fields
Notes:
- Keep save schema backward-compatible; add a `save_version` if schema changes.

## LevelsManager (scripts/base/global/levels_manager.gd)
Purpose: Hold level metadata (target times, coin rewards) and current_level path.
Responsibilities:
- Provide getters: get_target_time(), get_win_coin(), get_star_coin(), get_time_coin()
Data ownership:
- level_data dictionary maps level paths to metadata
Notes:
- Level unlock logic is outlined in save_data but unlocking is TODO; update LevelsManager or Game to handle unlocking post-completion.

## SceneLoader (scripts/base/global/scene_loader.gd)
Purpose: Threaded loading helper for the main game + level to reduce frame hitching.
Responsibilities:
- Expose `target_level` and `loaded_level_scene` for the loading UI and Game to use
Notes:
- Keep threaded loading logic isolated; consider expanding to provide load progress in future.

## AudioManager (scripts/base/global/audio_manager.gd)
Purpose: Play common audio clips.
Responsibilities:
- Expose small functions: play_ui_click(), play_win(), play_pause()
Notes:
- Extendable to manage music and volume settings.

## CosmeticsManager (scripts/base/global/cosmetics_manager.gd)
Purpose: Catalog cosmetics, handle browsing, purchase and equipped items.
Responsibilities:
- Maintain lists of balls, trails, backgrounds
- Interact with SaveManager to check ownership and persist selection
Public API:
- get_equipped_skin()/get_equipped_trail()/get_equipped_background()
- buy_ball/trail/background(), equip_ball/trail/background(), next(), previous()
Signals:
- ball_change(ball_data), trail_change(trail_data), background_change(background_data)
Data ownership:
- In-memory catalog (catalog is code-defined). Owned/equipped IDs persisted in SaveManager.

Guidelines
- Managers should expose small, focused APIs and avoid performing complex scene modifications directly; emit signals or provide data for consumers.
- For new global concerns, add a manager rather than scattering logic across scenes.
