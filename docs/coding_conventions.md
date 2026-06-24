# Coding Conventions (derived from codebase)

These conventions reflect patterns already used in the project and should be followed to keep consistency.

1) Project layout
- Keep scene templates under scenes/ by purpose (main, menu, ui, levels, assets). Scripts follow scripts/ with matching subfolders.

2) Singletons & Managers
- Use autoload singletons for app-wide state: SaveManager, LevelsManager, SceneLoader, AudioManager, CosmeticsManager.
- Managers own data; scenes read from managers and emit signals for managers to persist changes.

3) Signals
- Emit signals for high-level events (movement_started, died, level_completed). Connect consumers in parent scene (Game) to avoid tight coupling.
- Name signals for intent (e.g., level_completed, retry_pressed).

4) Scene & Node responsibilities
- Scene-local visuals and timing in scene scripts. Game logic (progression, rewards, save) in Game or managers.
- Avoid direct FileAccess or global state manipulation from reusable asset scenes; instead emit signals.

5) Naming
- Files and folders use snake_case. Node names in scenes use meaningful PascalCase for visual nodes; keep audio nodes named by purpose (Win, UI).
- Exported variables use `@export var` and clear default values.

6) Groups
- Use groups for runtime queries (example: `boosts` group is used to reset boosts after respawn).

7) UI
- UI nodes should be controllers (signals and small show/animate helpers). Avoid placing game progression logic inside UI scripts.

8) Resource usage
- Preload reusable resources in managers (cosmetics) to avoid repeated loads.

9) Save format
- SaveManager uses simple JSON. When changing schema, add a `save_version` and migration logic.

10) Extensibility
- Add metadata to LevelsManager for tuning rewards. New pickups or obstacles should expose minimal public methods (e.g., respawn_boost(), apply_boost(), play()) and use signals rather than editing managers directly.

Follow these conventions when adding new scenes, scripts, or managers to preserve codebase clarity and enable new contributors to ramp quickly.