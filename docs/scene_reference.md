# Scene Reference — Important Scenes

This file summarizes important scenes and their purpose, node roles, and connected scripts.

## scenes/main/game.tscn
Purpose: Runtime container for a level run.
Node highlights:
- Game (Node3D) — script: scripts/base/main/game.gd (orchestrator)
- LevelHolder (Node3D) — parent for dynamically instanced level
- WorldEnvironment — environment and sky
- SkyReflection (MeshInstance3D) — positioned relative to ball for reflections
- Camera3D — script: camera_3d.gd
- ball — instanced from scenes/main/ball.tscn
- UI — container for heart_ui, timer_ui, pause_ui, win_level_ui, game_over_ui
Notes: Game instantiates SceneLoader.loaded_level_scene and wires signals to win_point.

## scenes/main/ball.tscn
Purpose: Player avatar. Physics body with visuals and trail.
Node highlights:
- RigidBody3D (root) — scripts/base/main/ball.gd
- RayCast3D — ground probe, hosts GPUTrail3D
- MeshInstance3D — ball visuals
- AudioStreamPlayer3D nodes — spawn, hit, game_over
Notes: Ball applies cosmetics from CosmeticsManager on ready.

## scenes/menu/main_menu.tscn
Purpose: Entry menu. Buttons navigate to levels, customization, or exit.
Connected scripts: scripts/base/menu/main_menu.gd

## scenes/menu/levels_menu.tscn
Purpose: Level selection. Sets SceneLoader.target_level and uses loading screen.
Connected scripts: scripts/base/menu/levels_menu.gd

## scenes/menu/customization.tscn
Purpose: Cosmetic browsing UI. Uses CosmeticsManager and buy popup.
Connected scripts: scripts/base/menu/customization.gd, trail_data resource

## scenes/levels/test_level.tscn
Purpose: Example level containing platforms, obstacles, pickups, checkpoints, and a win_point.
Node highlights: win_point (connected to game's level_completed), obstacles (saw, hammer), interactables (star, boost), visible_checkpoint.

## UI Scenes (scenes/ui/*.tscn)
- timer_ui.tscn — shows runtime timer; uses scripts/base/ui/timer_ui.gd
- game_over_ui.tscn, win_level_ui.tscn, pause_ui.tscn — provide animated overlays emitting signals consumed by Game

Notes
- Reusable scenes (obstacles, pickups, checkpoints) reside under scenes/assets/* and are intended to be instanced into levels.
- Scene authors should keep logic small and emit signals for game-level consequences rather than directly manipulating global state where possible.
