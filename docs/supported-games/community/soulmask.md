import GameHero from '@site/src/components/GameHero';

<GameHero
  title="Soulmask"
  description="Connect Soulmask dedicated servers to Takaro through the community bridge, RCON, log monitoring, and outbound generic connector."
  image="/img/games/soulmask.svg"
/>

Takaro connects to your Soulmask dedicated server through the community-maintained [Soulmask Bridge](https://mad-001.github.io/SoulmaskBridge/). The bridge runs next to the server, connects to Soulmask over RCON, watches server output, and connects outbound to Takaro.

For a product overview, see the [Soulmask server manager page](https://takaro.io/games/soulmask/).

:::info Community-supported integration
Soulmask support is maintained by the community. The Takaro team documents the setup path, but the game-specific bridge comes from the community project.
:::

## Prerequisites

- A Soulmask dedicated server with file access
- Node.js 18 or newer
- RCON enabled on the Soulmask server
- A Takaro registration token for a Generic game server
- The bridge IP allow-listed in Soulmask's `Engine.ini`

## Enable Soulmask RCON

Add RCON options to the Soulmask dedicated server startup command. The exact command depends on your host, but the upstream guide uses options like:

```text
-rconport=25575 -rconpassword=your-password-here
```

Then allow the bridge host in `Engine.ini`:

```ini
[Server.SafeIP]
IPList=127.0.0.1
```

Use the IP address where the bridge runs. For a same-machine setup, `127.0.0.1` is usually enough.

## Install the bridge

Download the latest package from the [Soulmask Bridge releases page](https://github.com/mad-001/SoulmaskBridge/releases/latest) or follow the [upstream installation guide](https://mad-001.github.io/SoulmaskBridge/).

If you clone the repository instead of using a packaged release, install and build it with Node.js:

```bash
git clone https://github.com/mad-001/SoulmaskBridge.git
cd SoulmaskBridge
npm install
npm run build
```

## Configure Takaro

Create or edit `TakaroConfig.txt` in the bridge folder:

```ini
IDENTITY_TOKEN=my-soulmask-server
REGISTRATION_TOKEN=your-takaro-registration-token
TAKARO_API_URL=https://api.takaro.io
RCON_HOST=127.0.0.1
RCON_PORT=25575
RCON_PASSWORD=your-password-here
```

Use the same `RCON_PASSWORD` value as your Soulmask server startup command.

To get a Takaro registration token, open the Takaro dashboard, add a game server, select **Generic** as the game type, and copy the registration token.

## Start the bridge

Start the Soulmask server, then start the bridge from the bridge folder. Keep the bridge running while the game server is online.

The bridge should connect to Soulmask RCON and to Takaro. The server appears online in Takaro after the outbound connector connection succeeds.

## What the bridge exposes

The upstream project documents support for:

- Player join and leave detection
- Chat forwarding
- Kick, ban, and unban actions
- Server messages
- Save and shutdown actions
- List bans
- Console command forwarding
- Automatic reconnect to RCON and Takaro

Exact behavior depends on your bridge version and server configuration.

## Verify the connection

Check the bridge logs after startup. If Takaro does not show the server online, verify the Generic registration token, RCON host and port, RCON password, and the `[Server.SafeIP]` allow-list.

For the upstream guide, see the [Soulmask Bridge documentation](https://mad-001.github.io/SoulmaskBridge/).
