# Game Flow

This document describes the end-to-end player experience and internal flows the code implements.

1) Launch & Menus
- Start at scenes/menu/main_menu.tscn (Main Menu).
- Selecting a level sets LevelsManager.current_level and SceneLoader.target_level then changes to scenes/ui/loading_ui.tscn.
- Loading UI performs threaded loads for the game scene and the selected level; once loaded, the engine switches to the packed game scene and Game instantiates the loaded level.

2) Level Load
- Game creates an instance of SceneLoader.loaded_level_scene and parents it to LevelHolder.
- Game finds the `win_point` node and connects to its `level_completed` signal.
- Game resets run state: hearts, timer, star flag.

3) Gameplay
- Ball handles player input and physics. On first movement, ball emits `movement_started` which Game listens to and starts the run timer.
- Player collects pickups (star, boost, coins) via interactable scenes which either emit signals or directly call the ball's methods (apply_boost).
- UI components display runtime info: hearts, timer, speedlines, and respond to pause/retry/home actions.

4) Death & Respawn
- Ball emits `died` when conditions are met (fall or hazard). Game reduces hearts and updates UI.
- If hearts remain: Game tells ball to respawn to the last checkpoint and resets relevant boost pickups by finding nodes in group `boosts` and calling respawn_boost().
- If no hearts remain: Game triggers game over UI and pauses the tree.

5) Win
- WinPoint emits `level_completed` → Game computes stars and coin reward:
  - Base win coin
  - + star coin if star collected
  - + time coin if level_time <= LevelsManager.get_target_time()
- SaveManager.save_data updated and persisted via save_game().
- UI: play win audio, camera shake, show win UI with results, pause tree.

6) Rewards & Progression
- Coins and owned cosmetics are persisted in SaveManager.save_data (user://save.json).
- Levels unlocking is intended (save_data has unlocked_levels) but unlock logic is TODO in code — add by updating LevelsManager or Game when level completed.

Diagrams (text)
- Menu → LoadingUI (threaded load) → GameScene (instantiates level) → Gameplay → Win/GameOver → UI

Notes
- Threaded loading reduces hitching but requires SceneLoader.loaded_level_scene to be present before Game instantiates it.
- Checkpoints are local to level scenes; ball stores current_checkpoint_position and SaveManager holds persistent unlocked content only.
