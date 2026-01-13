---
sidebar_position: 2
---

# Migrating from CSMM

If you're coming from CSMM (Catalysm's Server Manager and Monitor), you can import your existing data into Takaro.

## Export from CSMM

1. Go to your CSMM server settings
2. Scroll to **Experiments** section
3. Click **Export** to download your JSON data

## Import to Takaro

1. In Takaro, go to **Game Servers**
2. Click **Import from CSMM**
3. Upload your CSMM export JSON
4. Configure import options:

| Option | Description |
|--------|-------------|
| **Import roles** | Include roles. If unchecked, players get default role |
| **Import players** | Include player data |
| **Transfer currency** | Assign CSMM currency to imported players |
| **Import shop listings** | Import shop items from CSMM |

5. Click **Import gameserver**

## Limitations

- Custom hooks, commands, and cronjobs are **not compatible** - these need to be recreated in Takaro
- No modules enabled by default - enable manually after import
- Best-effort migration, not 1:1 mapping

**Recommendation:** Only use the import if you have significant CSMM data (players, currency, shop items). Otherwise, start fresh.

## Need Help?

If you need assistance recreating your custom commands, hooks, or other configurations in Takaro, join our Discord and create a support ticket. Our community moderators are happy to help!

**[Join Takaro Discord](https://discord.gg/5aXJ8r8znJ)**
