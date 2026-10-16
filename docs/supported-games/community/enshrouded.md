import GameHero from '@site/src/components/GameHero';

<GameHero
  title="Enshrouded"
  description="Connect Enshrouded dedicated servers to Takaro through the community connector DLL and outbound generic connector."
  image="/img/games/enshrouded.jpg"
/>

Takaro connects to your Enshrouded dedicated server through the community-maintained Takaro Enshrouded Connector, a single `dbghelp.dll` that runs inside the server and implements the Takaro Generic Connector Protocol. Only the server needs it; players join as usual.

The connector connects outbound to Takaro over WebSocket and provides player events, chat, item delivery, teleports, kick and ban, plus character levels for your modules.

## Installation

1. Download `takaro-enshrouded-plugin.zip` from the latest `enshrouded-vX.Y.Z` release on the [gettakaro/connectors releases](https://github.com/gettakaro/connectors/releases) page.
2. Stop your Enshrouded server and copy `dbghelp.dll` from the zip next to `enshrouded_server.exe`.
3. In Takaro, go to **Game servers**, click **Create new game server** and choose **Generic** to see your registration token. The server appears in Takaro by itself when it connects.
4. Start the server. It creates `takaro/plugin.json` next to `enshrouded_server.exe`; paste your registration token into `registrationToken`, put your server's name into `identityToken` and save. The connector connects within a few seconds, and the server appears in Takaro under that name.

## Notes

- The connector is tested on specific game builds, including Enshrouded 1.0. After a game update it reads the new build's values from the game itself, so most updates need no new connector download.
- On Linux under Wine/Proton, set `WINEDLLOVERRIDES=dbghelp=n,b` so the server loads the connector.
- Messages from Takaro appear in game chat as a notice, styled like the game's own join messages.

For setup details, Docker instructions and the full list of what works, see the [connector README](https://github.com/gettakaro/connectors/tree/main/games/enshrouded). For a high-level overview of how Takaro connects to game servers, see [Connection Architecture](/advanced/connection-architecture).
