# Onboarding Guide

Welcome. This guide helps a new developer get productive quickly.

1) Environment & open project
- Install Godot 4.x (project scene-format indicates Godot 4). Open `project.godot` from the repository root.
- Recommended: use the same Godot minor version as the author if available; otherwise try the latest 4.x.

2) Quick run
- Open `scenes/menu/main_menu.tscn` and run it. Or run the packaged `scenes/main/game.tscn` after selecting a level from menu.
- To play the test level directly: set SceneLoader.target_level in the Levels menu by clicking Level 1.

3) Reading order
- docs/project_overview.md — high-level context
- docs/folder_structure.md — where to find things
- docs/architecture.md — systems and responsibilities
- docs/game_flow.md — runtime flows
- docs/managers.md — autoloads and APIs
- docs/script_reference.md and docs/scene_reference.md — concrete code mappings

4) Common workflows
- Add a new level: create a new scene under scenes/levels/, add platforms/obstacles/interactables, add entry to LevelsManager.level_data (target time and reward coins), and add a button in levels_menu.tscn or a dynamic listing.
- Add a new obstacle: create a scene under scenes/assets/obstacles/, give it a small script that emits signals or calls methods (e.g., on body_entered call get_tree().current_scene._on_ball_died() or emit a signal), then instance into a level.
- Add a new collectible: create a scene under scenes/assets/interactables/ with Area3D, attach logic to call appropriate API (e.g., if star -> call get_tree().current_scene.collect_star()).

5) Making changes
- Keep managers small and focused. Prefer emitting signals over modifying global state in reusable scenes.
- After changes, run the game and test the relevant flows: menu → loading → game → win/lose.

6) Push & PRs
- Keep documentation changes with code changes. Update docs/ when you change systems or add new features.
- Small, focused PRs are preferred. Include a brief summary of architectural impact in the PR description.

7) Where to ask (project-specific)
- Leave TODO comments in code and create small issues referencing docs/refactor_backlog.md items.

Welcome aboard — use the docs as living artifacts and update them as you change the codebase.