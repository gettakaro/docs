---
sidebar_position: 20
title: Voxel Turf
---

# Voxel Turf

Voxel Turf is supported through the community-maintained [Voxel Turf Server Manager](https://mad-001.github.io/Voxel-Turf-Server-Manager/).

:::info Community integration
This connector is maintained outside the Takaro core repo. Treat the bridge repository and latest release as the source of truth when the docs and module exports disagree.
:::

## Current bridge status

- Repository: [mad-001/Voxel-Turf-Server-Manager](https://github.com/mad-001/Voxel-Turf-Server-Manager)
- Latest checked release: `v2.4.1`
- Required game version: Voxel Turf `1.9.9` beta branch
- Install type: self-contained `winmm.dll` launcher plus `TakaroConnector` Lua mod
- Takaro server type: `Generic`

## Supported features

- Player join, leave, chat, and death events
- Server lifecycle log events for start, save, and stop
- Admin actions: kick, ban, unban, broadcast, give item, teleport, inventory read, and raw command execution
- Item catalog sync for Takaro shop/give-item pickers
- In-game `/takarostatus` admin status command

## Important install notes

- The latest release no longer requires a separate Node.js process or manually run `bridge.exe`; the release notes describe a self-contained `winmm.dll` flow.
- Keep update scripts pinned to `app_update 526340 -beta beta`. Updating back to Voxel Turf `1.9.8` breaks the connector API.
- Takaro item sync runs on its normal schedule, so shop items can take up to about an hour to appear after first connection.

## Setup reference

Use the community install guide for the full procedure: [Voxel Turf Server Manager docs](https://mad-001.github.io/Voxel-Turf-Server-Manager/).
