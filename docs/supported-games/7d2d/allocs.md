---
sidebar_position: 1
---

# Allocs Server Fixes

Allocs Server Fixes is a collection of mod addons for 7 Days to Die that enables advanced functionality, including a custom API that allows Takaro to communicate with your server. **Takaro requires Allocs Server Fixes to function with 7 Days to Die servers.**

## Prerequisites

Before installing Allocs Server Fixes, ensure your server has these TFP (The Fun Pimps) mods installed. These typically come pre-installed with the server:

- TFP_CommandExtensions
- TFP_MapRendering
- TFP_WebServer

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

Key permission modules include:

| Module | Description |
|--------|-------------|
| `web.map` | Interactive map viewing |
| `webapi.getlandclaims` | View land claim locations |
| `webapi.gethostilelocation` | View zombie locations |
| `webapi.getanimalslocation` | View animal locations |
| `webapi.getplayerslocation` | View player positions |

Permission levels range from `0` (full admin access) to higher numbers for more restricted access.

:::tip PVP Server Considerations
For PVP servers, carefully restrict access to location-based permissions like `webapi.getlandclaims` and `webapi.getplayerslocation`. Exposing this information can significantly impact gameplay balance.
:::
