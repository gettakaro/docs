---
sidebar_position: 5
---

# How Takaro Connects to Your Game Server

Takaro uses two different methods to communicate with game servers. Some games require Takaro to connect directly to your server, while others flip the connection so your server connects outbound to Takaro. Which model your game uses determines whether you need port forwarding and firewall rules.

## Traditional Connectors (7 Days to Die, Rust)

With traditional connectors, Takaro initiates the connection to your game server over the internet. Takaro sends HTTP requests (7 Days to Die) or opens a WebSocket connection (Rust) to a specific port on your server.

```
┌──────────┐              ┌──────────────────┐
│  Takaro  │ ──────────── │ Your Game Server │
│  (Cloud) │   HTTP /     │  (7D2D / Rust)   │
│          │   RCON       │                  │
└──────────┘              └──────────────────┘
                           Inbound port must
                           be accessible
```

Because Takaro is the one reaching out to your server, your server must be reachable from the internet on the configured port. If your server is behind a router or NAT, you need to set up port forwarding for that port.

**7 Days to Die** requires inbound access to the Web API port (default 8080, configurable in `serverconfig.xml`). See the [7 Days to Die setup guide](/supported-games/official/7d2d) for details.

**Rust** requires inbound access to the RCON WebSocket port (commonly 28016, configurable as a startup parameter). See the [Rust setup guide](/supported-games/official/Rust) for details.

:::caution
Your game server must be reachable from the internet on the configured port. If you are behind a NAT or firewall, you need to set up port forwarding and allow inbound connections on that port. Consult your hosting provider's documentation if you are using a managed game server host.
:::

## Generic Connector (Minecraft, Hytale, and more)

With the generic connector, the connection direction is reversed. A mod or plugin installed on your game server connects outbound to Takaro's WebSocket endpoint (`wss://connect.takaro.io/`). Once connected, data flows both ways over that single connection.

```
┌──────────────────┐              ┌──────────┐
│ Your Game Server │ ──────────── │  Takaro  │
│  (Minecraft /    │     WSS      │  (Cloud) │
│   Hytale / ...)  │    :443      │          │
└──────────────────┘              └──────────┘
 Outbound only — no
 port forwarding needed
```

Your game server is the one dialing out, just like a web browser loading a website. Most networks allow outbound HTTPS/WSS traffic by default, so no port forwarding or inbound firewall rules are needed.

The game server pushes events (player joins, chat messages, deaths) to Takaro over the WebSocket. When Takaro needs the server to do something — teleport a player, send a message, run a command — it sends a request over the same connection and the game server responds. All of this happens over the single outbound connection.

Authentication uses two tokens configured in the mod/plugin: an **identity token** that identifies your specific server, and a **registration token** from your Takaro dashboard that authenticates to your domain.

:::tip
The generic connector is used by all newer game integrations. If your game server can access the internet (which it needs for Steam authentication, mod downloads, etc.), it can connect to Takaro with no additional network configuration.
:::

## Frequently Asked Questions

### Do I need to open any inbound firewall ports?

- **For 7 Days to Die and Rust:** Yes. Takaro connects to your server, so the relevant port must be accessible from the internet.
- **For Minecraft, Hytale, and other generic connector games:** No. Your server connects outbound to Takaro. You only need standard outbound internet access.

### What if my game server is behind a strict firewall that blocks outbound connections?

The game server needs outbound HTTPS/WSS access (port 443) to `connect.takaro.io`. If outbound traffic on port 443 is blocked, you need to create a firewall rule allowing it. This is the same port used for normal web browsing, so it is rarely blocked.

### What happens if the connection drops?

For the generic connector, the mod/plugin automatically attempts to reconnect. For traditional connectors, Takaro retries its connection attempts as well.

### Which connector does my game use?

7 Days to Die and Rust use [traditional connectors](#traditional-connectors-7-days-to-die-rust). Minecraft, Hytale, and newer integrations use the [generic connector](#generic-connector-minecraft-hytale-and-more).

## Further Reading

- [7 Days to Die Setup Guide](/supported-games/official/7d2d)
- [Rust Setup Guide](/supported-games/official/Rust)
- [Minecraft Setup Guide](/supported-games/official/minecraft)
- [Hytale Setup Guide](/supported-games/community/hytale)
- [Adding Support for a New Game](./adding-support-for-a-new-game) — Developer documentation for building a new game connector
