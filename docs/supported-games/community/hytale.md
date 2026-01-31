---
image: /img/games/hytale.png
---

# Hytale

![Hytale](/img/games/hytale.png)

Takaro connects to your Hytale server using the generic connector and the Hytale-Takaro Integration mod. This integration enables real-time player event streaming, player management capabilities, and remote server control.

## Installation

To connect your Hytale server to Takaro, you'll need to install the Hytale-Takaro Integration mod on your existing Hytale server.

1. Download the latest Hytale-Takaro Integration mod from the [GitHub releases page](https://github.com/gettakaro/Hytale-Takaro-Integration/releases)
2. Place the mod JAR file in your Hytale server's `mods` directory
3. Start your server to generate the configuration file
4. Stop the server to edit the configuration

## Configuration

After installation, you'll need to configure the mod with your Takaro authentication tokens.

Edit the configuration file at `\Hytale\Server\mods\dev.takaro_HytaleTakaroIntegration\config.properties`:

```properties
# Get these from your Takaro dashboard
IDENTITY_TOKEN=NAME-YOUR-SERVER-WHATEVER-YOU-WANT
REGISTRATION_TOKEN=your-takaro-registration-token
```

### Getting Your Tokens

Before Takaro can connect to your Hytale server, you need to set up authentication tokens.

1. **Identity Token**: Use a unique identifier for your Hytale server (e.g., "my-hytale-server")
2. **Registration Token**: Obtain this from your Takaro dashboard:
   - Navigate to Settings → Game Servers
   - Click "Add Game Server"
   - Select "Generic" as the game type
   - Copy the Registration Token

After updating the configuration, restart your Hytale server for the changes to take effect.

## How Takaro Connects to Your Hytale Server

The Hytale-Takaro Integration mod establishes a connection to Takaro using the generic connector protocol. Once connected, the mod streams real-time events from your Hytale server to Takaro, receives and executes commands, and provides player and server information on demand.
