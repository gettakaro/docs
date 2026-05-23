---
sidebar_position: 3
title: Built-in modules
description: A practical catalog of Takaro's built-in modules.
---

# Built-in modules

<div className="module-marketplace-banner module-marketplace-banner--compact">
  <div>
    <p className="module-marketplace-banner__eyebrow">Download modules</p>
    <h2>Use modules.takaro.io for the live catalog</h2>
    <p>
      This page explains what the built-in modules do. For the current catalog and downloads, open modules.takaro.io.
    </p>
  </div>
  <a className="module-marketplace-banner__button" href="https://modules.takaro.io/">
    Open catalog
  </a>
</div>

Built-in modules are maintained by Takaro. You can install and configure them from the dashboard, but their code stays managed by Takaro so updates remain available.

The dashboard shows the exact commands, configuration schema, hooks, cronjobs, and permissions for the version installed on your game server. Use this page as a practical starting point when choosing a module.

If none of these modules match your workflow, build a custom module instead. Custom modules can add your own commands, hooks, cronjobs, configuration, permissions, and shop actions.

## utils

The `utils` module adds basic utility commands. It is useful when you want to confirm that player commands work on a connected server.

Commands:

- `ping` replies with `Pong`.
- `help` lists available commands or shows help for one command.

This module has no required user configuration.

## teleports

The `teleports` module lets players create, list, use, share, and delete teleport locations. It stores teleport locations per player and can optionally allow public teleports.

Commands include `tp`, `tplist`, `settp`, `deletetp`, `setpublictp`, and `setprivatetp`.

Important configuration:

- `maxTeleports` sets the maximum number of teleport locations a player can create.
- `timeout` sets the delay between teleport uses, in milliseconds.
- `allowPublicTeleports` controls whether players can use shared teleport locations.

Use this module when your server needs player-managed homes, bases, or meeting points.

## playerOnboarding

The `playerOnboarding` module helps welcome players when they join the server. It combines a join hook with a command, so players can receive onboarding information automatically and request it again later.

Use this module for server rules, starter instructions, Discord links, or first-session guidance.

## serverMessages

The `serverMessages` module sends configured messages to players on a schedule. It runs as a cronjob.

Use this module for recurring server notices, restart reminders, Discord prompts, event announcements, or shop reminders.

Keep scheduled messages short. Long or frequent announcements can make chat harder to read.

## chatBridge

The `chatBridge` module connects in-game chat to external services such as Discord. It reacts to chat-related events with hooks.

Use this module when your community talks across game and Discord. Before installing, configure the Discord integration and decide which channels should receive game chat.

## gimme

The `gimme` module lets players receive a random item or entity from a configured list.

Use this module for lightweight rewards, random starter kits, or community events. Review the item list carefully before enabling it on a live server.

## highPingKicker

The `highPingKicker` module checks player ping on a schedule, warns players, and can kick players who remain above configured thresholds.

Use this module when high latency affects server performance or player experience. Set thresholds conservatively so players aren't removed for brief network spikes.

## Choosing a module

Start with the behavior you want on the server:

- For command testing and help text, use `utils`.
- For homes and travel, use `teleports`.
- For first-time player guidance, use `playerOnboarding`.
- For recurring announcements, use `serverMessages`.
- For Discord and game chat syncing, use `chatBridge`.
- For random rewards, use `gimme`.
- For latency management, use `highPingKicker`.

For custom behavior, create your own module with [Writing Takaro modules](/advanced/custom-modules).
