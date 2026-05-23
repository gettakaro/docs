---
sidebar_position: 1
title: Modules
description: Install, configure, and build Takaro modules.
---

# Modules

<div className="module-marketplace-banner">
  <div>
    <p className="module-marketplace-banner__eyebrow">Module marketplace</p>
    <h2>Download ready-to-use modules from modules.takaro.io</h2>
    <p>
      Browse built-in and community modules, review what they add, and download modules without writing them from scratch.
    </p>
  </div>
  <a className="module-marketplace-banner__button" href="https://modules.takaro.io/">
    Open modules.takaro.io
  </a>
</div>

Modules add features to a Takaro game server. They can add chat commands, react to game events, run scheduled jobs, store data, and expose configuration that server owners manage from the dashboard.

Use modules when you want the same behavior on one or more game servers without rewriting scripts for each server. A module can be as small as a `/ping` command or as involved as an economy, teleport, onboarding, or Discord chat bridge workflow.

The easiest way to start is [modules.takaro.io](https://modules.takaro.io/). Use it to find ready-made modules, then use these docs to understand how modules work, how to install them, and how to configure them for your game server.

## Choose how you want to use modules

<div className="module-path-grid">
  <div className="module-path-card">
    <p className="module-path-card__eyebrow">Use existing modules</p>
    <h3>Download modules from the catalog</h3>
    <p>
      Start with modules.takaro.io when you want ready-made features such as teleports, onboarding, chat bridges, server messages, rewards, or utility commands.
    </p>
    <a href="https://modules.takaro.io/">Browse modules</a>
  </div>
  <div className="module-path-card">
    <p className="module-path-card__eyebrow">Create custom behavior</p>
    <h3>Build your own Takaro module</h3>
    <p>
      Write a custom module when your server needs its own commands, event handling, scheduled tasks, permissions, configuration, or shop actions.
    </p>
    <a href="/advanced/custom-modules">Start building</a>
  </div>
</div>

## What you can do with modules

Takaro modules are built from a few component types:

- **Commands** run when a player enters a chat command, such as `/tp home`.
- **Hooks** run when Takaro receives an event, such as a player joining the server.
- **Cronjobs** run on a schedule, such as every 10 minutes.
- **Functions** share reusable code between commands, hooks, cronjobs, and shop actions.
- **Configuration** lets server owners adjust settings without editing module code.
- **Permissions** control who can use commands or features.
- **Variables** store module data for a player, game server, or module.

Built-in modules are maintained by Takaro. You can install and configure them, but you don't edit their code. This lets Takaro ship updates without replacing your local customizations.

## How modules store data

Modules can create variables to store data between executions. Variables are how modules remember player-specific or server-specific state.

For example, when a player creates a teleport, the teleport module stores that location as a variable linked to the player, game server, and module. This lets each player have their own teleport locations on each server without overwriting other players' data.

See [Variables](/advanced/variables) for more details about how module data is stored and retrieved.

## Common workflows

To install an existing module, open a game server in the Takaro dashboard and go to **Modules**. From there, browse available modules, review their commands and settings, configure the fields for that server, and install the module.

See [Install and configure modules](/modules/install-configure) for the full workflow.

To decide which built-in module to use, start with the [Built-in modules](/modules/built-in) catalog. It summarizes what each module does, which player commands it adds, and what configuration usually matters.

To build your own module, use [Writing Takaro modules](/advanced/custom-modules). That guide walks through commands, hooks, variables, permissions, cronjobs, configuration, and shop actions with code examples.

## Where to get modules

[modules.takaro.io](https://modules.takaro.io/) is the main module catalog. It is where you browse available modules and download modules for Takaro.

The Takaro dashboard is the source of truth for the exact module version installed on a server. It shows the available commands, configuration fields, hooks, cronjobs, and permissions for that version.

## Next steps

Use [Install and configure modules](/modules/install-configure) when you want to run a module on a game server.

Use [Built-in modules](/modules/built-in) when you want to compare the modules Takaro maintains.

Use [Debug module issues](/modules/debugging) when a module runs but doesn't behave as expected.

Use [Writing Takaro modules](/advanced/custom-modules) when you want to create custom module behavior in the module builder.
