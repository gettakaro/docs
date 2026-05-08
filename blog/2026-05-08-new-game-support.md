---
slug: new-game-support
title: New game support should be a connector, not a rebuild
tags: [games, connectors, community]
---

Game server communities rarely stay inside one clean box.

A Rust group spins up a Minecraft world for a month. A 7 Days to Die crew tries a new survival game after a wipe. A community manager ends up tracking bans, player history, Discord roles, and shop claims across tools that were never designed to talk to each other.

That is the real problem behind "can Takaro support this game?" It is not just a checklist of titles. It is a systems problem: how do we let more games connect to the same operational layer without rebuilding Takaro for every server executable on the planet?

Our answer is the generic connector protocol.

<!-- truncate -->

## Official support is only part of the story

Takaro currently documents official support for **7 Days to Die**, **Rust**, and **Minecraft**. Those integrations matter because they give server owners a maintained path for the games we support directly.

But official integrations cannot be the only path. Game communities move faster than platform roadmaps. People want DayZ, Hytale, Palworld, and whatever their players drift toward next. Some games have good modding APIs. Some expose RCON or HTTP. Some make everything weird.

If every new game requires a full product rebuild, support stays slow and brittle. If every game can connect through a shared contract, the work becomes smaller and clearer.

## The connector is the contract

Takaro's generic connector protocol lets a game integration connect over WebSocket and exchange structured JSON messages with Takaro.

The integration can run in two main ways:

- **An in-game mod or plugin**, which is usually the best option when the game exposes the right APIs.
- **A sidecar process**, which runs next to the game server and talks to the game through RCON, HTTP, logs, or another available interface.

Both approaches use the same Takaro-facing protocol. The difference is how the integration gets data from the game.

That distinction matters. An in-game mod can usually hook into player joins, chat, deaths, inventories, and commands directly. A sidecar may need polling or log parsing, which can be less complete. But a limited connector is still better than no connector when a game does not allow deeper integration.

## What Takaro needs from a game

The protocol focuses on the operational things server admins actually use:

- player lookups and online player lists
- player locations and inventories
- item, entity, and location lists
- console commands and server messages
- moderation actions like kick, ban, unban, and ban lists
- reachability checks and shutdown handling
- real-time events such as player connects, disconnects, chat messages, deaths, entity kills, and log lines

This is deliberately practical. Takaro does not need every game to expose the same internal model. It needs enough shared behavior to manage players, react to events, run automation, and keep operators in control.

The player object follows the same idea. `gameId` and `name` are required. Platform-specific IDs such as Steam, Epic Online Services, Xbox Live, or a generic `platform:id` value can be added when the game has them.

That gives integrations room to be honest about how each game identifies people without forcing every game into one platform's identity model.

## Community integrations become easier to reason about

The community games section already points at community-maintained integrations, and the new-game guide references examples like Minecraft, 7 Days to Die, and a Palworld bridge pattern.

That is the shape we want more of: clear expectations, visible trade-offs, and enough documentation that a motivated community developer can build something useful without reverse-engineering Takaro first.

The connector protocol gives contributors a target. Instead of asking "how does all of Takaro work?", they can ask smaller questions:

- Can this game send player connect and disconnect events?
- Can it execute a command?
- Can it list online players?
- Can it identify players consistently across restarts?
- Does this need an in-game mod, a sidecar, or a hybrid approach?

Those are answerable questions. They turn a vague feature request into an integration plan.

## The trade-off is worth being clear about

Not every connector will support every Takaro feature on day one. That is fine, as long as the limits are visible.

A game with strong modding support can usually expose richer data. A game with only RCON may support commands and basic player lists, but struggle with real-time events or inventory data. A hybrid approach can sometimes bridge the gap by using a lightweight in-game component for events and a sidecar for the Takaro connection.

The important part is that admins know what they are getting. "Supported" should not mean "we hope this works." It should mean the connector implements a known set of functions and events, with documented gaps where the game makes something impossible.

## More games, less chaos

Takaro is useful when it reduces the amount of operational glue a community has to maintain by hand.

New game support should follow that same principle. We do not want every integration to become a one-off island with its own assumptions, docs, and failure modes. We want a shared connector model that lets official and community integrations plug into the same player management, moderation, automation, and server workflows.

That is how Takaro can support more games without turning into a pile of custom exceptions.

If you want to build support for a game, start with the [Adding support for a new game](/advanced/adding-support-for-a-new-game) guide and the [Generic Connector Protocol Reference](/advanced/generic-connector-protocol). Pick the architecture that matches the game, implement the smallest useful slice first, and document the limits clearly.

Good integrations do not need magic. They need a stable contract and honest trade-offs.
