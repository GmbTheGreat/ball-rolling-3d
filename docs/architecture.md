# Architecture

This document explains core systems, how they communicate, and why responsibilities are placed where they are.

## Core architecture overview

- Entry point: menu scenes lead to a threaded loading screen (scenes/ui/loading_ui.tscn) that uses SceneLoader.target_level and loads the main game scene (scenes/main/game.tscn) and the selected level scene.
- Game orchestrator: scripts/base/main/game.gd hosts level holder, UI overlays, and ties managers together. It is the single-run-state owner for a level attempt (hearts, timer, star collected, level_finished).
- Global managers (autoloads): SaveManager, LevelsManager, SceneLoader, AudioManager, CosmeticsManager. These are intentionally singletons to centralize cross-scene state like save data, current level metadata, audio, and equipped cosmetics.
- Scene-first design: Levels and reusable objects (obstacles, pickups) are scenes with small scripts handling local behavior and emitting signals for global systems.

## How systems communicate
- Primary pattern: signals and singletons. Example flows:
  - Ball emits `movement_started` → Game starts timer
  - WinPoint emits `level_completed` → Game computes rewards and triggers UI
  - UI buttons emit signals (retry, home, next) → Game responds via connected methods
  - CosmeticsManager emits change signals consumed by UI and ball to apply skins/trails
- Why signals: they decouple producers (pickup, ball, UI) from consumers (Game, SaveManager, AudioManager), allowing scenes to be reused without hard references.

## Main systems

### Game (scripts/base/main/game.gd)
- Purpose: per-run orchestrator. Responsible for managing level instance lifecycle, run state (hearts, time, stars), and UI transitions.
- Dependencies: SceneLoader (for preloaded level), LevelsManager (level metadata), SaveManager (persist coins), AudioManager, CosmeticsManager.
- Related scenes: scenes/main/game.tscn

### Ball (scripts/base/main/ball.gd)
- Purpose: player avatar physics and input handling. Emits high-level signals (movement_started, died).
- Responsibilities: movement, jump, boost activation, respawn, apply cosmetics (skin and trail).
- Why here: Physics and visual updates are local to the ball; it owns the movement state and exposes events for game orchestration.

### Level system (LevelsManager + per-level scenes)
- Purpose: keep level-specific metadata (target times, coin rewards), current level path, and convenience getters for reward logic.
- Responsibility: metadata only — does not load scenes directly.
- Related scripts: scripts/base/levels/*.gd, scenes/levels/*.tscn

### SceneLoader (scripts/base/global/scene_loader.gd)
- Purpose: background/threaded loading of the main game & selected level to reduce hitching.
- Responsibilities: set SceneLoader.loaded_level_scene for the Game to instantiate.

### Save System (scripts/base/save/save_manager.gd)
- Purpose: persist player currency, owned cosmetics, and selected cosmetics to user://save.json.
- Responsibilities: read/write JSON file; provide save_data structure for runtime.
- Why central: multiple systems (CosmeticsManager, UI, Game) read and update persistent state.

### Audio System (scripts/base/global/audio_manager.gd)
- Purpose: small convenience API for playing UI and game audio clips.
- Responsibility: expose functions like play_ui_click(), play_win(), play_pause().

### Cosmetics System (scripts/base/global/cosmetics_manager.gd)
- Purpose: centralize cosmetics catalog, purchasing, and equipped selection.
- Responsibilities: own in-memory catalog, check ownership (via SaveManager), apply equipped cosmetics via public getters used by the ball & camera.

### UI System
- Purpose: present and animate HUD and menus. UI nodes are lightweight controllers and emit signals to which Game responds.
- Responsibilities: visual presentation, tweened show/hide, local button handlers.

## Signal flow (example)
- Player presses Start → Main menu loads Levels menu → Player picks level → SceneLoader.target_level set, change scene to loading UI
- Loading UI waits for threaded loads, sets SceneLoader.loaded_level_scene, then changes to main/game.tscn
- Game instantiates loaded level, finds win_point and connects level_completed.
- Ball emits movement_started → Game starts timer
- Ball falls → emits died → Game handles respawn or game_over UI
- On win: Game computes stars and coins using LevelsManager, updates SaveManager.save_data and calls SaveManager.save_game()

## Why responsibilities are assigned this way
- Single-authority managers reduce the need to serialize complex references across scenes and make persistence straightforward.
- Scene-local behavior (ball, obstacles, pickups) keeps physics and visual logic close to scene nodes for reuse across levels.
- Signals keep coupling low, making scenes easier to move or reuse without editing global consumers.

## Extensibility notes
- Add new level metadata to LevelsManager.level_data to tune rewards without changing game logic.
- New pickups/obstacles should emit simple signals or call small public APIs (e.g., apply_boost) to integrate cleanly.
