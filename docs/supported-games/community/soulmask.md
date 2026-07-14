---
sidebar_position: 60
title: Soulmask
---

# Soulmask

Soulmask is supported through the community-maintained [Soulmask Bridge](https://mad-001.github.io/SoulmaskBridge/).

:::info Community integration
This connector is maintained outside the Takaro core repo. Treat the bridge repository and latest release as the source of truth when the docs and module exports disagree.
:::

## Current bridge status

- Repository: [mad-001/SoulmaskBridge](https://github.com/mad-001/SoulmaskBridge)
- Latest checked package/release version: `v1.0.0`
- Install type: Node.js bridge using Soulmask RCON and `WS.log` parsing
- Takaro server type: `Generic`

## Supported features

- Player tracking from `WS.log`
- Chat forwarding after enabling `Set_OutputChats 1`
- Player list and reachability checks
- Server messaging, kick, ban, unban, shutdown, and raw command execution
- Empty inventory/item-list responses where Soulmask RCON cannot expose structured data

:::warning Command sync note
The public docs mention “save world via Takaro”. The bridge source exposes shutdown through `SaveAndExit` and allows raw RCON through `executeCommand`; if you need a standalone save action, verify it in the installed bridge version first.
:::

## Setup reference

Use the community install guide for the full procedure: [Soulmask Bridge docs](https://mad-001.github.io/SoulmaskBridge/).
