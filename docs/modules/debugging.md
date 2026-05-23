---
sidebar_position: 4
title: Debug module issues
description: Use Takaro events and event JSON to debug module problems.
---

# Debug module issues

Takaro records module activity on the **Events** page. Use events when a module command, hook, cronjob, or shop action runs but doesn't behave as expected.

## Find module events

Open the Takaro dashboard and go to **Events**. Look for events created by the module or by the player action that triggered the module.

Module-related events help you answer basic debugging questions:

- Did the module run?
- Which game server did it run on?
- Which player or command triggered it?
- Did Takaro record an error?
- Did the module create or update stored data?

## Inspect the event JSON

Open an event to inspect its JSON payload. The JSON contains the raw context Takaro recorded for that event.

Useful fields often include errors, arguments, player data, game server IDs, module IDs, and execution metadata. These details show what Takaro saw when the module ran.

If the issue involves saved module data, also check the variables created by the module. For example, the teleport module stores player teleport locations as variables linked to the player, game server, and module.

## Share event JSON when asking for help

If you ask us for help with a module issue, include the event JSON. It gives us the exact data Takaro saw when the module ran and helps us debug the problem faster.

Before sharing event JSON publicly, remove secrets, tokens, private Discord channel IDs, or other sensitive information.

## What to check first

If a command doesn't run, verify that the module is installed on the correct game server, the command prefix matches the server settings, and the player has the required permission.

If a hook or cronjob doesn't run, check the module configuration, any hook filters, and whether the connected game server is sending the expected events to Takaro.

If a module needs Discord, verify the Discord integration first. See [Discord integration](/discord-integration) for setup details.
