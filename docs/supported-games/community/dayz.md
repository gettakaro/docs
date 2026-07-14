import GameHero from '@site/src/components/GameHero';

<GameHero
  title="DayZ"
  description="Connect DayZ servers to Takaro with the @TakaroIntegration server mod and DayZ-Bridge sidecar."
  image="/img/games/dayz.jpg"
/>

Takaro connects to your DayZ server using the generic connector, the **@TakaroIntegration** server-side mod, and a small **DayZ-Bridge** Node.js sidecar that translates between the mod's HTTP and Takaro's WebSocket gameserver protocol. The integration enables real-time player events, player management, and remote server control.

## Installation

DayZ integration has two pieces: a server-side mod and a Node.js bridge sidecar. The mod is loaded via `-serverMod=`, so clients never download it.

1. Download the latest release from the [DayZ-Takaro-Integration GitHub releases page](https://github.com/mad-001/DayZ-Takaro-Integration/releases).
2. Copy the `@TakaroIntegration` folder into your DayZ server root (alongside your other mods).
3. Add `@TakaroIntegration` to your server's `-serverMod=` parameter (NOT `-mod=`):
   ```bat
   DayZServer_x64.exe ^
       -config=serverDZ.cfg ^
       -port=2302 ^
       -profiles=profiles ^
       -mod="@CF;@DabsFramework;..." ^
       -serverMod="@TakaroIntegration" ^
       -dologs -adminlog -netlog -freezecheck
   ```
4. Install [Node.js 20+](https://nodejs.org/) on the server box. Extract the `DayZ-Bridge/` folder from the release, then build and run it:
   ```bash
   cd DayZ-Bridge
   npm install
   npm run build
   node dist/index.js
   ```
   On Windows you can use `start.bat` instead of `node dist/index.js`.

## Configuration

After installation, you'll need to configure both the bridge and the mod with your Takaro authentication tokens.

### Bridge

Edit `DayZ-Bridge/TakaroConfig.txt` (copy from `TakaroConfig.example.txt` if it doesn't exist):

```properties
# Required — registration token from your Takaro dashboard
registrationToken=PASTE_TOKEN_HERE

# Required — human-readable server name (doubles as the identity token)
serverName=My DayZ Server

# Optional — local HTTP port the bridge listens on for the mod (default 8088)
# localPort=8088
```

### Mod

On first server boot the mod writes a default config to `profiles/TakaroIntegration/config.json`. Edit it so `TakaroApiUrl` points to the bridge:

```json
{
  "TakaroApiUrl": "http://localhost:8088",
  "RegistrationToken": "",
  "IdentityToken": "",
  "GameServerId": "",
  "EventBatchIntervalMs": 1000,
  "CommandPollIntervalMs": 2000,
  "MaxEventsPerBatch": 50,
  "LogVerbose": false,
  "DryRun": false
}
```

The mod talks only to the bridge — it does not need its own registration token. The bridge handles registration with Takaro and hands the resulting `IdentityToken` + `GameServerId` back to the mod.

### Getting Your Tokens

Before Takaro can connect to your DayZ server, you need a registration token.

1. **Identity Token** is derived from `serverName` in `TakaroConfig.txt`. Pick something unique like `my-dayz-server`.
2. **Registration Token**: Obtain this from your Takaro dashboard:
   - Navigate to Settings → Game Servers
   - Click "Add Game Server"
   - Select "Generic" as the game type
   - Copy the Registration Token

Start the bridge first, then start the DayZ server. The bridge will register with Takaro on first connect and the dashboard will show the server as **online** within a few seconds.

## How Takaro Connects to Your DayZ Server

DayZ's Enforce Script `RestApi` is HTTP-only, but Takaro's gameserver protocol is WebSocket-only. The DayZ-Bridge sidecar bridges the two: it connects to `wss://connect.takaro.io/`, listens on `127.0.0.1:8088` for the mod, forwards in-game events as Takaro `gameEvent` messages, and translates inbound Takaro requests (kicks, bans, teleports, item grants, broadcasts) into HTTP poll responses the mod consumes. For more details about how the generic connector works, see [Connection Architecture](/advanced/connection-architecture).

## Release sync note

The current upstream release checked for this page is `v0.1.14`, which added ammo and magazine item-list fixes. If item sync behaves differently, compare the installed release against the upstream release notes.
