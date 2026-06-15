# Project Overview

## Game summary
Ball Rolling 3D is a compact Godot game prototype: the player controls a rolling ball through 3D platform levels, collecting stars and coins, navigating obstacles, and reaching a win point. Core mechanics include directional steering, jumping, boost pickups, checkpoints, and time-based stars.

Core gameplay loop
- Select level → load level → control the ball to reach the win point
- Collect optional star for bonus reward
- Avoid hazards; fall/kill triggers respawn or run-over
- Score: win coin + optional star and time bonus → saved currency

Main player objectives
- Reach the level finish (win point)
- Collect stars for extra rewards
- Unlock cosmetics using in-game coins

## Project goals
- Focus: small, extendable mobile-friendly single-player levels with cosmetic progression.
- Current scope: playable prototype with one test level, cosmetics, and simple save system.
- Development stage: early prototype; assets and levels present, polish and expansion needed.

## Architecture philosophy
- Scene-first: levels and gameplay are composed from scenes; behavior lives in lightweight scripts.
- Single-purpose managers (autoloads) own global state: SaveManager, LevelsManager, SceneLoader, AudioManager, CosmeticsManager.
- Signal-driven interactions for low coupling between systems.

## Technology stack
- Godot Engine (scene format v3 indicates Godot 4.x project files)
- GDScript for game logic
- Included plugin: GPUTrail (addons/GPUTrail-main) for trail visual effects
- No external services or servers; save uses local user:// JSON file
