# 7 Days To Die

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

Finding your web API port is essential for connecting Takaro to your server. Here are two methods to find your port:

Via logs: Check the output log of your server during startup for a line similar to this: `2023-09-15T01:27:41 61.339 INF Started Webserver on 8082.`

The number at the end is your port value.

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

### API Not Responding

- Confirm the server has fully restarted after installing the mods
- Verify your web token has sufficient permissions (permission level 0 for full access)
- Check the server output log for any API-related errors

## Migrating from CSMM

Coming from CSMM? You can import your existing player data, roles, currency, and shop listings. See the [CSMM Migration Guide](./csmm-migration.md) for instructions.
