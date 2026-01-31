---
image: /img/games/7d2d.jpg
---

# 7 Days To Die

![7 Days to Die](/img/games/7d2d.jpg)

## Install Allocs Fixes

Allocs Server Fixes is required for Takaro to connect to your 7 Days to Die server. See the [Allocs Server Fixes installation guide](./allocs.md) for complete setup instructions.

## Checking Installed Mods

To verify which mods are installed on your server, open your server console (via Telnet, web panel, or in-game F1 console) and type:

```
version
```

This will display version information for all installed mods, including Allocs Server Fixes if present.

## Setting Up Web API Credentials

Before Takaro can connect to your 7D2D server, you need to set up web API credentials. These credentials allow Takaro to authenticate and interact with your 7D2D server.

Connect to your server console via Telnet, web panel, or use the in-game F1 console.

```sh
# Check if you have any web tokens set up
webtokens list
# Create a new web token
webtokens add <name> <token> 0
```

Note: These credentials are sensitive, and you should treat them as a
password. It is advised to use a combination of numbers, letters, lowercase,
uppercase, as well as symbols.

## Finding Your Web API Port

Finding your web API port is essential for connecting Takaro to your server. Here are two methods to locate it:

### Method 1: Check Server Startup Logs

Look for a line like this in your server's output log during startup:

```
Started Webserver on 8082
```

The number at the end (e.g., `8082`) is your web API port.

### Method 2: Check serverconfig.xml

Look for these settings in your `serverconfig.xml` file:

```xml
<property name="WebDashboardEnabled" value="true"/>
<property name="WebDashboardPort" value="8080"/>
```

The `WebDashboardPort` value is your web API port. The default is usually `8080` or `8082`.

:::tip Hosted Servers
If you're running on a hosted server (like Nitrado, GTX, etc.), the port is often shown in their control panel under "Web Interface" or "RCON/API" settings.
:::

### Port Conflicts on Hosted Servers

Many hosting providers (especially those using Pterodactyl) use port `8080` for their control panel, which conflicts with the default `WebDashboardPort`. If you can't access your web dashboard:

1. Check your server logs for errors like `port already in use`
2. Look at your allocated ports in your host's control panel
3. Change `WebDashboardPort` in `serverconfig.xml` to an available allocated port (e.g., if you have ports 26903-26905 allocated, try `26904`)
4. Restart your server and test access at `http://<your-ip>:<new-port>/`

If no ports are available, contact your hosting provider to allocate an additional port for the web dashboard.

## How Takaro Connects to Your Server

### Authentication Mechanism

When Takaro connects to your 7D2D server, it uses the web API credentials (token) you set up earlier for authentication.
This token is passed in the API requests to authenticate and authorize Takaro to perform various operations on your server using the HTTP API.

### Server-Sent Events (SSE)

Takaro uses Server-Sent Events (SSE) to receive real-time updates from the 7D2D server.
This allows Takaro to be notified of changes and events occurring on the server without polling for information.

## Troubleshooting

### Mods Not Loading

- Verify the folder structure is correct (no nested `Mods/Mods/` directories)
- Ensure each mod folder contains both `ModInfo.xml` and the DLL file
- Check server logs for any mod loading errors

### Cannot Access Web Interface

- Verify `WebDashboardEnabled` is set to `true` in `serverconfig.xml`
- Check that the port specified in `WebDashboardPort` is open in your firewall
- Ensure no other service is using the same port
- On hosted servers, the default port `8080` may conflict with the control panel - see [Port Conflicts on Hosted Servers](#port-conflicts-on-hosted-servers)

### API Not Responding

- Confirm the server has fully restarted after installing the mods
- Verify your web token has sufficient permissions (permission level 0 for full access)
- Check the server output log for any API-related errors

## Migrating from CSMM

Coming from CSMM? You can import your existing player data, roles, currency, and shop listings. See the [CSMM Migration Guide](./csmm-migration.md) for instructions.
