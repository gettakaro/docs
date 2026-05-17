---
sidebar_position: 1
---

# Allocs Server Fixes

Allocs Server Fixes is a collection of mod addons for 7 Days to Die that enables advanced functionality, including a custom API that allows Takaro to communicate with your server. **Takaro requires Allocs Server Fixes to function with 7 Days to Die servers.**

## Prerequisites

Allocs Server Fixes depends on the official TFP (The Fun Pimps) mods to function. These mods provide the core web server and mapping functionality that Allocs extends.

Your server must have these TFP mods installed:

- TFP_CommandExtensions
- TFP_MapRendering
- TFP_WebServer

These mods are included with standard 7 Days to Die dedicated server installations. If you're using a server host (like Nitrado, GTX, etc.), they should already be present.

:::warning Missing TFP Mods?
If these mods are not present on your server, contact your server host to verify you have the correct server installation. Self-hosted servers should ensure they're using the official dedicated server files from Steam.
:::

## Installation

### Step 1: Download Allocs Server Fixes

Download the latest version from the official source:

**[https://7dtd.illy.bz/wiki/Server%20fixes](https://7dtd.illy.bz/wiki/Server%20fixes)**

### Step 2: Extract the Files

The download comes as a compressed archive. Extract through the TAR and GZ files until you locate the `Mods` folder containing:

- `Allocs_CommandExtensions/`
- `Allocs_CommonFunc/`
- `Allocs_WebAndMapRendering/`

### Step 3: Install the Mods

Copy the extracted `Mods` folder contents to your 7 Days to Die server installation directory. The final structure should look like:

```
<7DTD Server Directory>/
└── Mods/
    ├── Allocs_CommandExtensions/
    │   ├── ModInfo.xml
    │   └── *.dll
    ├── Allocs_CommonFunc/
    │   ├── ModInfo.xml
    │   └── *.dll
    └── Allocs_WebAndMapRendering/
        ├── ModInfo.xml
        └── *.dll
```

:::warning Common Installation Mistake
Make sure you don't create a nested `Mods/Mods/` folder structure. The mod folders should be directly inside the `Mods` directory, not in a subfolder.
:::

### Step 4: Configure Your Server

Open your `serverconfig.xml` file and verify these settings are enabled:

```xml
<property name="WebDashboardEnabled" value="true"/>
<property name="WebDashboardPort" value="8084"/>
<property name="EnableMapRendering" value="true"/>
```

Note the `WebDashboardPort` value - this is the port you'll use to access the Allocs web interface and API.

### Step 5: Restart Your Server

Restart your 7 Days to Die server for the changes to take effect.

## Verifying Installation

After restarting, verify the installation by browsing to:

```
http://<your-server-ip>:<WebDashboardPort>/legacymap
```

For example: `http://192.168.1.100:8084/legacymap`

If you see a login page, the installation was successful.

You can also use the `version` command in your server console to confirm the mods are loaded. See [Checking Installed Mods](./index.md#checking-installed-mods) for details.

## Permissions

Permissions are configured in the `serveradmin.xml` file located in your savegames folder. You can define which API endpoints are accessible and at what permission level.

7 Days to Die permission levels work from most powerful to least powerful: `0` is full admin access, while higher numbers are more restricted. A web user or web token must have a permission level that is powerful enough for the module it is trying to use.

Add or verify the `<webmodules>` section in `serveradmin.xml`. This example keeps dangerous console execution limited to full admins, allows read-only status/player APIs to normal web users, and restricts sensitive map/claim/inventory data to trusted admins:

```xml
<webmodules>
  <module name="web.map" permission_level="2000" />
  <module name="webapi.executeconsolecommand" permission_level="0" />
  <module name="webapi.getstats" permission_level="2000" />
  <module name="webapi.getplayersonline" permission_level="2000" />
  <module name="webapi.getplayerslocation" permission_level="2000" />
  <module name="webapi.viewallplayers" permission_level="2000" />
  <module name="webapi.getlandclaims" permission_level="3" />
  <module name="webapi.viewallclaims" permission_level="3" />
  <module name="webapi.getplayerinventory" permission_level="3" />
  <module name="webapi.gethostilelocation" permission_level="2000" />
  <module name="webapi.getanimalslocation" permission_level="2000" />
</webmodules>
```

Key permission modules include:

| Module | Description | Suggested permission level |
|--------|-------------|----------------------------|
| `web.map` | Interactive map viewing | `2000` |
| `webapi.executeconsolecommand` | Execute server console commands | `0` |
| `webapi.getstats` | Read server statistics | `2000` |
| `webapi.getplayersonline` | Read online player list | `2000` |
| `webapi.getplayerslocation` | View player positions | `2000` on PVE servers; restrict further on PVP servers |
| `webapi.viewallplayers` | View all known players | `2000` |
| `webapi.getlandclaims` | View land claim locations | `3` or another trusted-admin level |
| `webapi.viewallclaims` | View all land claims | `3` or another trusted-admin level |
| `webapi.getplayerinventory` | View player inventories | `3` or another trusted-admin level |
| `webapi.gethostilelocation` | View zombie locations | `2000` |
| `webapi.getanimalslocation` | View animal locations | `2000` |

After changing `serveradmin.xml`, restart the server or reload the admin configuration before testing the web API again.

:::tip PVP Server Considerations
For PVP servers, carefully restrict access to location-based permissions like `webapi.getlandclaims`, `webapi.viewallclaims`, `webapi.getplayerinventory`, and `webapi.getplayerslocation`. Exposing this information can significantly impact gameplay balance.
:::
