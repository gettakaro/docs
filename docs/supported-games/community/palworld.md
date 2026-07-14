import GameHero from '@site/src/components/GameHero';

<GameHero
  title="Palworld"
  description="Connect Palworld dedicated servers to Takaro through the community bridge, REST API, and outbound generic connector."
  image="/img/games/palworld.avif"
/>

Takaro connects to your Palworld dedicated server through the community-maintained Palworld Bridge. The bridge runs next to your server, talks to Palworld's REST API, and connects outbound to Takaro.

For a product overview, see the [Palworld server manager page](https://takaro.io/games/palworld/).

## Prerequisites

- A Palworld dedicated server with admin access
- Node.js 18 or newer
- A Takaro registration token for a Generic game server
- The Palworld server admin password

## Enable the Palworld REST API

Edit your `PalWorldSettings.ini` file and enable the REST API:

```ini
RESTAPIEnabled=True
RESTAPIPort=8212
AdminPassword=YourSecurePassword
```

Restart the Palworld server after saving the file. The bridge uses this API to read server state and run admin actions.

## Install the bridge

Download or clone the [Palworld Bridge](https://github.com/mad-001/Palworld-Bridge), then install and build it:

```bash
git clone https://github.com/mad-001/Palworld-Bridge.git
cd Palworld-Bridge
npm install
npm run build
```

You can also download the latest packaged release from the [Palworld Bridge releases page](https://github.com/mad-001/Palworld-Bridge/releases/latest).

## Configure Takaro

Create `TakaroConfig.txt` in the bridge folder:

```ini
IDENTITY_TOKEN=your-palworld-server-name
REGISTRATION_TOKEN=your-takaro-registration-token

PALWORLD_HOST=127.0.0.1
PALWORLD_PORT=8212
PALWORLD_USERNAME=admin
PALWORLD_PASSWORD=YourSecurePassword
```

Use the same `PALWORLD_PASSWORD` value as `AdminPassword` in `PalWorldSettings.ini`.

To get a Takaro registration token, open the Takaro dashboard, add a game server, select **Generic** as the game type, and copy the registration token.

## Start the bridge

Start the bridge from the bridge folder:

```bash
npm start
```

For a production server, run the bridge with your normal process manager. For example, with PM2:

```bash
pm2 start dist/index.js --name palworld-bridge
```

After the bridge connects, the server appears online in Takaro.

## Optional chat integration

The bridge supports Palworld chat through the TakaroChat UE4SS mod. Install this only if you want game chat to flow into Takaro and Discord.

Download [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS/releases), then copy its files into `PalServer\Pal\Binaries\Win64\`. Copy the `TakaroChat` folder from the Palworld Bridge repository into:

```text
PalServer\Pal\Binaries\Win64\ue4ss\Mods\TakaroChat\
```

Edit `TakaroChat\Scripts\config.lua` and point it at the bridge:

```lua
config.BridgeURL = "http://localhost:3001/chat"
config.EnableBridge = true
config.SendCategories = {1, 2, 3}
```

Restart the Palworld server after installing UE4SS and TakaroChat.

## Verify the connection

Check the bridge logs after startup. The bridge should connect to Takaro and to the Palworld REST API. If Takaro does not show the server online, verify the registration token, REST API port, and admin password.

For the upstream guide, see the [Palworld Bridge documentation](https://mad-001.github.io/Palworld-Bridge/).

## Module sync note

The Palworld repository also ships optional Takaro module exports under `TakaroModules/`. If Discord death notifications or player commands behave differently than described, compare the installed module export with the bridge version because the public docs and bundled modules can drift.
