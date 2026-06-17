import GameHero from '@site/src/components/GameHero';

<GameHero
  title="Voxel Turf"
  description="Connect Voxel Turf servers to Takaro with Mad's community-maintained Voxel Turf Server Manager plugin."
  image="/img/games/voxel-turf.svg"
/>

Takaro connects to your Voxel Turf server through the community-maintained [Voxel Turf Server Manager](https://github.com/mad-001/Voxel-Turf-Server-Manager/releases). The plugin runs inside the server and connects outbound to Takaro through the generic connector.

## Prerequisites

- A Voxel Turf server running **Voxel Turf 1.9.9 beta**
- File access to the server folder
- A Takaro registration token for a **Generic** game server
- Access to restart the Voxel Turf server

## Install the plugin

Download the latest release from the [Voxel Turf Server Manager releases page](https://github.com/mad-001/Voxel-Turf-Server-Manager/releases/latest). Use `VoxelTurf-Takaro-Server-Manager-v2.4.1.zip` or a newer release when available.

Extract the release into the Voxel Turf server root. The release contains these files:

```text
VoxelTurfServer/
|-- winmm.dll
`-- mods/
    `-- TakaroConnector/
        |-- TakaroConfig.txt
        `-- scripts/
            |-- server_scripts.txt
            `-- server/
                `-- takaro_connector.lua
```

## Configure Takaro

Edit `mods/TakaroConnector/TakaroConfig.txt` and set these values:

```properties
SERVER_NAME=My Voxel Turf Server
REGISTRATION_TOKEN=your-takaro-registration-token
```

Use a stable `SERVER_NAME`. Changing it later can make Takaro treat the server as a different game server.

To get a Takaro registration token, open the Takaro dashboard, add a game server, select **Generic** as the game type, and copy the registration token.

## Restart Voxel Turf

Restart the Voxel Turf server after saving `TakaroConfig.txt`. The plugin connects to Takaro during server startup.

## Verify the connection

Open the Takaro dashboard and check that the Voxel Turf server appears online. If it does not, check the Voxel Turf server logs and confirm that `REGISTRATION_TOKEN` is correct.

The plugin exposes console commands with consistent syntax: `<command> <player> <args>`. For example, `money Mad 1000`, `give Mad Pistol 1`, `kick Mad`, and `ban Mad reason`.

The plugin also syncs the Voxel Turf item catalog into Takaro. The shop and `giveItem` picker populate after Takaro's next item sync, usually within about one hour of the server first connecting.
