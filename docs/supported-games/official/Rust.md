# Rust

Takaro supports Rust through the Takaro Rust Connector, a Carbon plugin that implements the Takaro Generic Connector Protocol.

The connector runs inside your Rust server and connects outbound to Takaro over WebSocket, so no inbound RCON port forwarding is required.

## Installation

1. Install Carbon on your Rust server.
2. Install the latest Takaro Rust Connector from the [gettakaro/rust-mods releases](https://github.com/gettakaro/rust-mods/releases/tag/v1.0.0).
3. Configure your Takaro registration token and identity token in the plugin settings.
4. Start or reload the plugin.

## Notes

- The connector uses the same outbound model as other generic connector games.
- If you were previously using Oxide/RCON-based setup notes, they no longer apply.

For a high-level overview of how Takaro connects to game servers, see [Connection Architecture](/advanced/connection-architecture).
