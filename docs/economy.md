---
sidebar_position: 5
---

# Economy

Takaro allows users to enable an economy system on their server. This is a virtual currency system that allows users to earn and spend money on the server. This is a great way to encourage users to be active on the server and reward them for their activity.

Players can earn money in many ways using some of the [built-in modules](https://modules.takaro.io/) or you can create your own custom modules to allow players to earn money in other ways.

Currency is kept per gameserver, so if you have multiple gameservers, each gameserver will have its own currency. This makes it easier to balance the economy on each gameserver; you might want different prices on your PvP server than on your PvE server for example.

Do note that we have in global settings, an option to enable Economy. You can override the global settings in each gameserver setting.

## Shop

Takaro offers a built-in shop system to complement the server's economy. This feature allows community managers to create shop listings where they can sell individual items or bundles at specified prices. Each game server can have its own unique shop.

To allow players to use the shop, they need to be linked to both Takaro and your game community. The player linking process is described in the [players](./players.md) section.

### Prerequisites

1. **Enable the economy** for your game server.
2. Ensure **players are linked** to both Takaro and your game community (see [players](./players.md) for details).
3. Install the built-in module, [EconomyUtils](https://modules.takaro.io/economyUtils), on your game server.

### Shop Functionalities

- **Create Shop Listing**: Allows you to list items for sale, either individually or as packages. You can set the item quality and upload custom images for your listings.
- **Orders**: Provides an overview of the orders placed by players and their status.
- **Shop Actions**: A listing can also trigger a shop action, allowing you to sell perks, grants, messages, commands, or other module-driven effects alongside regular items.

### Shop Actions

Shop actions let a shop listing do more than just deliver items. A listing can contain:

- regular shop items
- a shop action
- both items and a shop action

Action-only listings are supported, so you can create listings that only run an action.

#### Built-in shop actions

Takaro ships with a built-in `shopActions` module. After installing it on a game server, you can use these actions in that server's shop listings:

- `grantRole`
- `sendMessage`
- `giveItem`
- `executeCommand`

#### Custom shop actions

You can also expose your own shop actions from a custom module. Once that module is installed on a game server, its shop actions become available in that server's shop listing form.

#### Triggers

Each shop action can be configured to run on one of these triggers:

- `orderCreated` - run the action as soon as the order is created and payment is deducted
- `orderClaimed` - run the action when the player claims the order
- `both` - run on both moments

The default trigger is `orderClaimed`.

Use `orderCreated` for effects that should happen immediately after purchase. Use `orderClaimed` for effects that depend on the player being online or ready to receive something in-game.

### Claiming an Item

An item can be claimed in two ways:

- In Takaro, by going to "Orders" and clicking "Claim Item". You need to be in-game for this to work; otherwise, you'll receive an error message.
- In-game, by typing the command `/link`.

If a listing contains items, or a shop action that runs on `orderClaimed`, the player must be online when claiming the order.

### In-Game Store

The shop can be accessed in-game using the command `/shop`. The structure works as follows:

- `/shop 1`: Shows the first page of items.
- `/shop 1 1`: Displays the details of the first item.
- `/shop 1 1 buy`: Purchases the item.
