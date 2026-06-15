# Refactor Backlog

This backlog lists recommended improvements prioritized by expected value.

## High Priority

### 1) Level unlock and progression persistence
Problem: Completion does not currently unlock the next level (TODO in code).
Why it matters: Player progression is core to retention and unlocks cosmetics.
Suggested solution: Update Game._on_level_completed to call LevelsManager.unlock_next_level() and persist in SaveManager.save_data["unlocked_levels"]. Add unit tests or simple integration test.

### 2) Save schema versioning and migration
Problem: save.json is unversioned; changes will break older saves.
Why it matters: Backwards compatibility and safe updates.
Suggested solution: Add `save_version` key and migration helpers in SaveManager.load_game().

## Medium Priority

### 3) Central event bus or typed signals
Problem: Many systems connect ad-hoc; lack of discoverability for events.
Why it matters: Improves maintainability and testing.
Suggested solution: Implement a minimal EventBus manager for global events (optional). Prefer typed signals on managers.

### 4) Extract level configuration to JSON/YAML
Problem: Level metadata is hard-coded into LevelsManager.level_data.
Why it matters: Easier to add levels and tweak rewards without editing code.
Suggested solution: Move level metadata into a config file loaded at startup.

## Low Priority

### 5) Better error handling and logging
Problem: Load failures and file I/O lack clear error reporting.
Why it matters: Easier debugging for end users and CI.
Suggested solution: Consolidate logging calls and wrap FileAccess operations with clear errors and fallback behavior.

### 6) Automated tests and CI
Problem: No automated tests exist.
Why it matters: Prevent regressions and speed refactors.
Suggested solution: Add small unit tests for SaveManager and LevelsManager using Godot's unit test frameworks or external scripts.

Each item includes a clear problem statement and suggested solution so contributors can take ownership. Prioritize high-value changes first.