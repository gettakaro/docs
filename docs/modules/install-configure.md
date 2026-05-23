---
sidebar_position: 2
title: Install and configure modules
description: Install Takaro modules on a game server and manage their configuration.
---

# Install and configure modules

<div className="module-marketplace-banner module-marketplace-banner--compact">
  <div>
    <p className="module-marketplace-banner__eyebrow">Start here</p>
    <h2>Find modules in the catalog or build your own</h2>
    <p>
      Use the catalog for ready-made modules. Build a custom module when your server needs behavior the catalog doesn't cover.
    </p>
  </div>
  <a className="module-marketplace-banner__button" href="https://modules.takaro.io/">
    Browse modules
  </a>
</div>

Takaro separates module definitions from module installations. A module definition lives in the module registry or in the module builder. It describes the module's commands, hooks, cronjobs, configuration schema, permissions, and code.

You can import a module from the catalog into the registry, or create a new custom module in the module builder. That makes the module available, but it doesn't run anywhere until you install it on a game server.

Each game server has its own module installations and its own user configuration for those installations. Installing or configuring a module on one game server doesn't install or configure it on your other game servers.

If a ready-made module doesn't fit your server, create one with [Writing Takaro modules](/advanced/custom-modules). Custom modules use the same commands, hooks, cronjobs, configuration, and permissions model as built-in modules.

## Before you start

Connect the game server to Takaro before installing modules. The server must appear in the dashboard, and Takaro must be able to send commands to it.

If a module uses player commands, check the server's command prefix first. Players use that prefix before the command trigger, such as `/ping` or `/tp home`.

## Install a module

Open the Takaro dashboard and select the game server. Go to **Modules**, browse the modules available from the registry, and open the module you want to install.

Review the module description, commands, hooks, cronjobs, permissions, and configuration fields. Fill in the user configuration for this game server, then install the module on the server.

After installation, test one safe command or behavior. For example, install the `utils` module and run the `ping` command in game to confirm that command handling works.

Repeat this installation step for every game server that should run the module. This lets you run the same module with different settings on different servers.

## Configure a module

User configuration controls how the installed module behaves on that game server. Common settings include limits, cooldowns, welcome messages, Discord channel IDs, item lists, and feature toggles.

Configuration changes apply to the module installation on the selected game server. If you run the same module on multiple servers, configure each installation separately.

Some settings are managed by Takaro instead of the module's user configuration. These system settings include command costs, cooldowns, hook filters, and Discord channel mappings.

Modules can also create variables while they run. Variables store module data such as player teleport locations, counters, cooldown records, or server-specific state. This data is separate from module configuration.

## Update a module

Built-in modules can receive updates from Takaro. Review the installed version before updating a production server, especially when the module manages player data or permissions.

Tagged module versions are immutable. The `latest` version is useful while developing or testing a custom module, but production servers should use a tagged version when stability matters.

## Remove a module

Uninstalling a module stops its commands, hooks, and cronjobs from running on that game server. It doesn't automatically clean up all data that the module may have stored.

Before removing a module that stores variables, check whether you need to export, migrate, or manually delete that data.

## Troubleshooting

If a command doesn't run, verify that the module is installed on the correct game server, the command prefix matches the server settings, and the player has the required permission.

If a hook or cronjob doesn't run, check the module configuration, any hook filters, and whether the connected game server is sending the expected events to Takaro.

If a module needs Discord, verify the Discord integration first. See [Discord integration](/discord-integration) for setup details.

For more details, see [Debug module issues](/modules/debugging).
