import GameHero from '@site/src/components/GameHero';

<GameHero
  title="Eco"
  description="Connect Eco servers to Takaro through the community integration plugin and outbound generic connector."
  image="/img/games/eco.jpg"
/>

Takaro connects to your Eco server through the community-maintained Takaro Integration plugin. The plugin runs inside the Eco server and connects outbound to Takaro.

For a product overview, see the [Eco server manager page](https://takaro.io/games/eco/).

## Prerequisites

- An Eco server with file access
- A Takaro registration token for a Generic game server
- Access to restart the Eco server

## Install the plugin

Download the latest release from the [Takaro Eco Integration releases page](https://github.com/mad-001/takaro-eco-integration/releases/latest). Use the `TakaroIntegration-v1.2.1.tar.gz` package or a newer release when available.

Extract the archive and copy the `TakaroIntegration` folder into your Eco server's `Mods` folder:

```text
YourEcoServer/
`-- Mods/
    `-- TakaroIntegration/
```

Restart the Eco server once after copying the plugin files. This lets Eco load the plugin and create any missing files.

## Configure Takaro

Edit `Mods/TakaroIntegration/TakaroConfig.json`:

```json
{
  "serverName": "My Eco Server",
  "registrationToken": "your-takaro-registration-token",
  "websocketUrl": "wss://connect.takaro.io/",
  "enableLogging": false,
  "commandPrefix": "!"
}
```

Use a stable `serverName`. Changing it later can make Takaro treat the server as a different game server.

To get a Takaro registration token, open the Takaro dashboard, add a game server, select **Generic** as the game type, and copy the registration token.

## Restart Eco

Restart the Eco server after saving `TakaroConfig.json`. The plugin connects to Takaro during server startup.

## Verify the connection

Open the Takaro dashboard and check that the Eco server appears online. If it does not, check the Eco server logs and confirm that `registrationToken` is correct.

For the upstream guide, see the [Takaro Eco Integration documentation](https://mad-001.github.io/takaro-eco-integration/).

## Version sync note

The current upstream release checked for this page is `v1.2.1`. Some upstream README/changelog text may still mention older versions, so prefer the release package and `VERSION` file when validating installs.
