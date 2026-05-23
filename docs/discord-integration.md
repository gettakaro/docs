---
sidebar_position: 5
---

# Discord integration

Connect Takaro to Discord to bring your game server community, staff workflows, and player identity into one place. The Discord integration supports account linking, role synchronization, chat bridge modules, Discord commands, and event notifications.

Use this page as the starting point for Discord setup. Player identity is covered in the [Players](./players.md) guide, and permission behavior is covered in [Roles and permissions](./roles-and-permissions.md).

## What you can connect

Takaro connects Discord in three main areas:

- **Players** link their Takaro account to Discord through `/link`.
- **Roles and permissions** sync mapped Discord roles with Takaro roles.
- **Modules** use Discord channels for chat bridges, notifications, and commands.

These features work together, but you don't need to enable all of them at once. For example, you can start with a chat bridge and add role synchronization later.

## Prerequisites

Before connecting Discord, verify that you have:

- Admin access to your Discord server.
- Admin permissions in Takaro.
- A Discord account that can authorize the Takaro bot.
- A clear plan for which Discord channels and roles Takaro should use.

## Connect the Discord bot

1. In Takaro, go to **Settings > Discord**.
2. Click **Connect Discord**.
3. Select your Discord server.
4. Grant the requested permissions.
5. Confirm that the Takaro bot joined your Discord server.

The bot needs permission to read messages, send messages, read message history, embed links, and manage roles. If you use chat bridge features, it also needs the permissions required for channel access and webhook behavior.

Place the Takaro bot role above any Discord roles that Takaro needs to manage. Discord prevents bots from assigning or removing roles that sit above the bot's highest role.

## Link players to Discord

Players link their in-game identity to a Takaro user account with `/link`. After they sign in, they can connect Discord from the same linking flow.

1. In-game, the player runs `/link`.
2. The player opens the link and signs in to Takaro.
3. The player selects **Connect Discord Account**.
4. The player authorizes Takaro in Discord.

After linking, Takaro can associate the player's game identity with their Discord user ID. This is required for role synchronization and Discord-based community features.

For the full player identity model, see [Players](./players.md).

## Sync roles and permissions

Discord role synchronization maps Discord roles to Takaro roles. Only mapped roles sync. System roles, such as Root, User, and Player, don't sync.

To configure role sync:

1. Connect the Discord bot.
2. Ask players or staff members to link their Discord accounts.
3. Go to **Roles**.
4. Edit a Takaro role.
5. Select the matching Discord role from **Linked Discord Role**.
6. Go to **Settings > Game Servers**.
7. Enable **Discord Role Sync Enabled**.
8. Choose the source of truth.

The source of truth decides what happens when Discord and Takaro disagree. Use Takaro as the source of truth when game activity should drive permissions. Use Discord as the source of truth when your Discord community roles should drive in-game access.

For the full permission model, including global roles, game-server roles, timed roles, and command permissions, see [Roles and permissions](./roles-and-permissions.md).

## Bridge game chat to Discord

The Chat Bridge module connects game chat to Discord channels. In-game messages appear in Discord, and Discord messages can be sent back to the game server.

Use dedicated Discord channels for each game server or chat purpose. This keeps staff channels, public chat, and server-specific conversations separate.

For module setup and configuration, see [Chat Bridge](https://modules.takaro.io/chatBridge).

## Use Discord commands and notifications

Modules can send Discord messages when game events happen. Common examples include player joins, player leaves, server restarts, economy events, and custom staff alerts.

Custom modules can also send formatted Discord messages, create embeds, and respond to Discord events. For implementation details, see [Custom modules](./advanced/custom-modules.md).

## Troubleshooting

### The bot doesn't respond

Check that the bot is online in Discord, has access to the channel, and has permission to read and send messages. If commands still fail, check the Takaro logs for Discord-related errors.

### Role sync doesn't work

Verify that the user linked their Discord account, belongs to the connected Discord server, and has a valid Discord user ID in Takaro. Then confirm that the Discord role is mapped to a Takaro role and that role sync is enabled for the game server.

If Takaro can't assign or remove roles, move the Takaro bot role higher in the Discord role hierarchy and confirm that it has **Manage Roles**.

### Chat bridge messages don't appear

Check that the Chat Bridge module is installed, the configured Discord channel ID is correct, and the bot has access to that channel. If Discord messages reach Takaro but don't reach the game, verify that the game server connection is online.

## Security guidance

Grant the bot access only to the channels it needs. Be careful when mapping powerful Discord roles to Takaro roles with staff or admin permissions.

Review role mappings after staff changes, permission changes, or Discord server reorganizations. Use Discord audit logs and Takaro logs together when investigating permission changes.
