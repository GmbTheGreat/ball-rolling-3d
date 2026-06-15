# Folder Structure

This section explains major project folders, their responsibilities, and typical contents.

- addons/
  - Purpose: third-party Godot plugins (GPUTrail).
  - Typical contents: plugin scripts, shaders, README, plugin.cfg.

- assets/
  - Purpose: media assets (textures, models, audio, fonts, trails).
  - Typical contents: hdri/, textures/, sfx/, models/, trails/.

- scenes/
  - Purpose: Godot scene files (.tscn) organized by role.
  - Subfolders: main/ (game, ball), menu/, ui/, levels/, assets/, shader/, debug/.
  - Responsibilities: store hierarchy templates for game objects and screens.

- scripts/
  - Purpose: game logic in GDScript, organized by domain.
  - Subfolders:
    - base/main/ — core gameplay scripts (game orchestrator, ball, camera)
    - base/global/ — autoload managers (SceneLoader, LevelsManager, AudioManager, CosmeticsManager)
    - base/ui/ — UI view/controllers
    - base/menu/ — menu screens and customization logic
    - base/interactables/ — pickups, win points, checkpoints
    - base/obstacles/ — hazards (saw, hammer)
    - base/levels/ — level-specific scripts
    - base/save/ — SaveManager
    - base/debug/ — debug helpers

- docs/
  - Purpose: project documentation (this folder).

- .vscode/, .gitignore, project.godot
  - Purpose: editor configuration and project entry file.

Repository tree (abbreviated):

- project.godot
- addons/
  - GPUTrail-main/
- assets/
  - hdri/, sfx/, trails/, textures/, models/
- scenes/
  - main/, menu/, ui/, levels/, assets/, shader/
- scripts/
  - base/main/, base/global/, base/ui/, base/menu/, base/interactables/, base/obstacles/, base/save/
- docs/ (this folder)

Note: Scenes are the primary unit of composition; scripts attach to scenes or nodes and subscribe to signals for interaction.