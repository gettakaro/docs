import GameHero from '@site/src/components/GameHero';

<GameHero
  title="Voxel Turf"
  description="Connect Voxel Turf dedicated servers to Takaro through the community server manager, Lua mod, bridge, and outbound generic connector."
  image="/img/games/voxel-turf.svg"
/>

Takaro connects to your Voxel Turf server through the community-maintained [Voxel Turf Server Manager](https://mad-001.github.io/Voxel-Turf-Server-Manager/). The integration uses a Lua server mod, an auto-started bridge process, and Takaro's Generic connector.

For a product overview, see the [Voxel Turf server manager page](https://takaro.io/games/voxel-turf/).

:::info Community-supported integration
Voxel Turf support is maintained by the community. The Takaro team documents the setup path, but the game-specific bridge and Lua mod come from the community project.
:::

## Prerequisites

- A Voxel Turf dedicated server with file access
- Voxel Turf **1.9.9 beta** or newer, as listed by the upstream guide
- Node.js 18 or newer
- A Takaro registration token for a Generic game server

The upstream guide notes that Voxel Turf 1.9.8 stable can run a server, but it does not expose the API required by the bridge.

## Install the server manager

Download the latest package from the [Voxel Turf Server Manager releases page](https://github.com/mad-001/Voxel-Turf-Server-Manager/releases/latest) or follow the [upstream installation guide](https://mad-001.github.io/Voxel-Turf-Server-Manager/).

The community package includes the Lua mod and bridge files. Copy the mod files into your Voxel Turf server according to the upstream guide.

## Configure Takaro

Create or edit `TakaroConfig.txt` in the bridge folder:

```ini
IDENTITY_TOKEN=my-voxel-turf-server
REGISTRATION_TOKEN=your-takaro-registration-token
TAKARO_API_URL=https://api.takaro.io
```

To get a Takaro registration token, open the Takaro dashboard, add a game server, select **Generic** as the game type, and copy the registration token.

## Start the server

Start your Voxel Turf server normally. The community setup auto-launches the bridge process with the server.

After startup, the bridge should connect outbound to Takaro and the server should appear online in the Takaro dashboard.

## What the bridge exposes

The upstream project documents support for:

- Player join and leave events
- Chat events and chat relay
- Death events
- Kick and ban actions
- Broadcast messages
- Give item, teleport, and inventory lookup actions
- Server start, stop, and world-save events
- Console command forwarding

Exact behavior depends on your bridge version and what your Voxel Turf server exposes.

## Verify the connection

Check the Voxel Turf server console and bridge logs after startup. If Takaro does not show the server online, verify the Generic registration token, Node.js installation, and that you are running the Voxel Turf version required by the upstream guide.

For the upstream guide, see the [Voxel Turf Server Manager documentation](https://mad-001.github.io/Voxel-Turf-Server-Manager/).
