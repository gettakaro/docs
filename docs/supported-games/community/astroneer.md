import GameHero from '@site/src/components/GameHero';

<GameHero
  title="Astroneer"
  description="Connect Astroneer dedicated servers to Takaro through the community bridge and outbound generic connector."
  image="/img/games/astroneer.webp"
/>

Takaro connects to your Astroneer dedicated server through the community-maintained Takaro Astroneer Bridge. The bridge runs next to your server, talks to Astroneer over RCON, and connects outbound to Takaro.

For a product overview, see the [Astroneer server manager page](https://takaro.io/games/astroneer/).

:::note Version and module availability
Bridge, docs, and modules can be released separately. Use the upstream guide for setup, the GitHub releases page for bridge packages, and the Takaro module viewer for module availability.
:::

## Prerequisites

- An Astroneer dedicated server with file access
- Node.js 18 or newer
- A Takaro registration token for a Generic game server
- Access to restart the Astroneer server

## Install Node.js

On Windows, open PowerShell as Administrator and install Node.js:

```powershell
winget install OpenJS.NodeJS.LTS
```

Restart the machine after installing Node.js so `node` and `npm` are available in new terminals.

## Download the bridge

Download the bridge from the [Takaro Astroneer Bridge releases page](https://github.com/mad-001/takaro-astroneer-bridge/releases/latest) or from the [upstream installation guide](https://mad-001.github.io/takaro-astroneer-bridge/). Extract it into a folder outside the Astroneer server directory.

If the extracted package includes source files, open PowerShell or Command Prompt in the bridge folder and install dependencies:

```bash
npm install
```

## Enable Astroneer RCON

Edit the Astroneer server settings file:

```text
\astroneer\Astro\Saved\Config\WindowsServer\AstroServerSettings.ini
```

Add or update these values:

```ini
ConsolePort=5000
ConsolePassword=your-password-here
```

Save the file and restart the Astroneer server.

## Configure Takaro

Edit `TakaroConfig.txt` in the bridge folder:

```ini
IDENTITY_TOKEN=my-astroneer-server
REGISTRATION_TOKEN=your-takaro-registration-token
TAKARO_API_URL=https://api.takaro.io
HTTP_PORT=3535
RCON_HOST=127.0.0.1
RCON_PORT=5000
RCON_PASSWORD=your-password-here
```

Use the same `RCON_PASSWORD` value as `ConsolePassword` in `AstroServerSettings.ini`.

To get a Takaro registration token, open the Takaro dashboard, add a game server, select **Generic** as the game type, and copy the registration token.

## Start the bridge

Start the bridge after the Astroneer server is running:

```text
start.bat
```

The bridge should connect to Takaro and to Astroneer RCON. Keep the bridge running while the Astroneer server is online.

## Verify the connection

Check the bridge window or `takaro-bridge.log`. Takaro should show the Astroneer server online after the WebSocket and RCON connections succeed.

For the upstream guide, see the [Takaro Astroneer Bridge documentation](https://mad-001.github.io/takaro-astroneer-bridge/).
