---
sidebar_position: 7
---

# Experiments

The Experiments page lists features that Takaro has not finished yet. You find it under **Settings → Experiments**, and you can switch each feature on or off for your whole Domain.

## Alpha and Beta

Every feature on the page is either Alpha or Beta.

- **Alpha** features are early and may change or break. Takaro turns them on for your Domain, so they appear already switched on. An Alpha feature only shows up on your page once Takaro has turned it on for you.
- **Beta** features are nearly finished and open to every Domain. They stay off until you switch them on.

When a feature is finished, it leaves the page and is on for everyone.

## Switch a feature on or off

Anyone in your Domain can view the page. To switch a feature, you need the Manage Settings permission. See [Roles and permissions](./roles-and-permissions.md).

A switch applies to your whole Domain: the dashboard, API keys, modules, the Storefront and the Player Portal. Players never see the Experiments page.

- **Off** hides the feature and keeps everything you made with it. Switch it on again and it comes back.
- An API call or module action that uses a feature that is off is refused with an error that names the feature.
- Takaro records each switch in your Domain's event log. Other open dashboards of your Domain update within a few seconds.

## When a feature disappears

Takaro can pause a feature for every Domain, or take a feature away from one Domain. The feature then leaves the page and switches off. Your work is kept, and the feature comes back as it was when Takaro resumes it.

## Give feedback

Use the feedback button at the top of the dashboard to tell Takaro what you think.

## Simulator

Beta. Run a simulated game server with simulated players to try modules, commands and the shop without a real server.

You need the Manage Game Servers permission to use the Simulator. When you switch it off, your simulated server and its simulated players stop. They resume when you switch the Simulator back on.

## Wipes

Alpha. Plan and schedule server wipes, run them with a preview of what resets, and see past wipes on your statistics.

Wipes appears only when Takaro has turned it on for your Domain. When you switch it off:

- Wipe schedules do not run. Takaro does not catch up on the runs it missed. Each schedule moves on to its next date.
- Your Storefront stops showing wipe information, and your server-list page drops it the next time Takaro refreshes that page.
- Past wipes stay in your event log.
