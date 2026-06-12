# Win System Documentation

## Overview

The Win System is responsible for:

* Detecting level completion.
* Calculating earned stars.
* Calculating earned coins.
* Saving player rewards.
* Playing celebration effects.
* Displaying the Win UI.
* Handling Home, Retry, and Next Level actions.

The flow starts when the player reaches the Win Point and ends when the player chooses an action from the Win UI.

---

# System Components

## Win Point

Responsible for detecting when the player reaches the end of the level.

### Event

```text
Area3D.body_entered
```

### Action

```text
level_completed.emit()
```

The Win Point does not calculate rewards or show UI.

Its only job is notifying the Game Manager that the level was completed.

---

## Game.gd

Main controller of the win sequence.

Receives:

```text
level_completed signal
```

from the Win Point.

### Function

```text
_on_level_completed()
```

This function controls the entire completion flow.

---

# Win Sequence Flow

## Step 1 - Prevent Duplicate Completion

Before doing anything:

```text
if level_completed:
	return
```

This prevents the level completion logic from running twice.

---

## Step 2 - Lock Completion State

The following values are updated:

```text
level_completed = true
ball.level_completed = true
```

Purpose:

* Prevent player death logic.
* Prevent duplicate completion events.
* Freeze gameplay progression state.

---

## Step 3 - Calculate Rewards

### Default Rewards

Every successful completion grants:

```text
Stars = 1
Coins = 100
```

Reason:

The player completed the level.

---

### Bonus Star Reward

Condition:

```text
Collectible Star Found
```

Reward:

```text
+1 Star
+50 Coins
```

---

### Time Bonus Reward

Condition:

```text
level_time <= target_time
```

Reward:

```text
+1 Star
+50 Coins
```

---

## Possible Results

### Basic Completion

```text
Stars = 1
Coins = 100
```

### Completion + Collectible

```text
Stars = 2
Coins = 150
```

### Perfect Run

```text
Stars = 3
Coins = 200
```

---

# Save System

After rewards are calculated:

```text
SaveManager.save_data["total_coins"] += coins
```

Then:

```text
SaveManager.save_game()
```

This writes the updated data to:

```text
user://save.json
```

Purpose:

* Persist player progress.
* Persist earned coins.

---

# Celebration Phase

## Camera Shake

Executed immediately after reward calculation.

```text
camera.shake(1.0, 1.0)
```

Purpose:

* Create impact.
* Provide completion feedback.

---

## Delay

System waits:

```text
1 second
```

using:

```text
await timer
```

Purpose:

* Allow camera shake to finish.
* Give the player a moment to celebrate.

---

# Win UI Presentation

After celebration delay:

```text
win_level_ui.show_smooth()
```

---

## UI Entrance Animation

The panel:

```text
Scale: 0.75 -> 1.05 -> 1.0
Alpha: 0 -> 1
```

Purpose:

* Smooth appearance.
* Avoid instant popup effect.

---

# Reward Display

The Win UI receives:

```text
stars
coins
```

from Game.gd.

Displays:

```text
Money Earned
Star Collected Status
```

---

# Star Reward Animation

Each earned star is animated individually.

### Sequence

```text
Star 1 Pop
Wait 0.2s

Star 2 Pop
Wait 0.2s

Star 3 Pop
```

Each star:

```text
Scale 0 -> 1.2 -> 1.0
```

Purpose:

* Increase reward satisfaction.
* Clearly communicate earned performance.

---

# Pause State

After reward presentation:

```text
get_tree().paused = true
```

Purpose:

* Stop gameplay.
* Prevent movement.
* Wait for player decision.

---

# User Decision Phase

The player can choose one of three actions.

---

## Home Button

### Flow

```text
Home Button
↓
home_pressed signal
↓
Game.gd
↓
Unpause Game
↓
Load Main Menu
```

### Result

Player returns to the main menu.

---

## Retry Button

### Flow

```text
Retry Button
↓
retry_pressed signal
↓
Game.gd
↓
Reload Current Level
↓
Reset Ball Position
↓
Reset Hearts
↓
Reset Timer
↓
Reset Collectible State
↓
Reset Completion Flags
↓
Wait One Frame
↓
Enable Death Detection
↓
Unpause Game
```

### Result

Current level restarts from the beginning.

---

## Next Button

### Planned Flow

```text
Next Button
↓
next_pressed signal
↓
Game.gd
↓
Load Next Level
↓
Reset Gameplay State
↓
Start Next Level
```

### Status

Currently not implemented.

---

# Important Flags

## level_completed

Purpose:

```text
Prevents duplicate completion execution.
```

---

## ball.level_completed

Purpose:

```text
Disables death detection after winning.
```

Prevents:

```text
Win
↓
Ball falls below death zone
↓
Respawn
```

---

## is_respawning

Purpose:

```text
Prevents multiple death events while respawning.
```

---

# Current Architecture Summary

```text
Ball
↓
Win Point
↓ signal
Game.gd
↓
Reward Calculation
↓
SaveManager
↓
Camera Shake
↓
Delay
↓
Win UI
↓
Star Animation
↓
Pause
↓
Player Decision
├─ Home
├─ Retry
└─ Next
```

This is the complete Level Completion System currently implemented in the project.
