# Takaro Documentation Repository

## Overview

This is the official documentation site for **Takaro** - a game server management platform that unifies communities across multiple games (Rust, 7 Days to Die, Minecraft). Built with Docusaurus 3.5.2.

**Live site:** https://docs.takaro.io

## Tech Stack

- **Framework:** Docusaurus 3.5.2
- **Language:** TypeScript, MDX
- **Styling:** Custom CSS (`src/css/custom.css`)
- **Search:** Algolia
- **Analytics:** Plausible
- **Deployment:** Docker + Nginx, GitHub Container Registry

## Project Structure

```
docs/                     # Documentation content (MDX/Markdown)
├── introduction.md       # Landing page
├── players.md            # Player management
├── economy.md            # Economy system
├── bans.md               # Ban management
├── roles-and-permissions.md
├── FAQ.md
├── how-to-guides/        # Step-by-step tutorials
├── supported-games/      # Game-specific docs (Rust, 7D2D, Minecraft)
├── modules/              # Module system documentation
├── development/          # Developer docs for Takaro itself
└── advanced/             # Advanced features (API, self-hosting, custom modules)

src/
├── components/           # Custom React components
└── css/custom.css        # Site styling

static/img/               # Images referenced in docs
assets/                   # Diagrams (Excalidraw files)
```

## Development Commands

```bash
npm install          # Install dependencies
npm run start        # Dev server at http://localhost:13005
npm run build        # Production build to dist/
npm run serve        # Serve production build locally
npm run clear        # Clear Docusaurus cache
npm run typecheck    # TypeScript validation
```

## Git Workflow

### Branch Naming

```
docs/<topic>      # New documentation
fix/<issue>       # Corrections, typos, broken links
update/<topic>    # Updates to existing docs
refactor/<scope>  # Structural changes
```

### Commit Messages

Use conventional commits:

```
docs(scope): add webhook integration guide
fix(how-to): correct Rust RCON port number
update(advanced): refresh API examples
```

Scopes: `introduction`, `players`, `economy`, `bans`, `roles`, `how-to`, `supported-games`, `modules`, `development`, `advanced`, `config`, `ci`

## Documentation Standards

### File Naming

- Use kebab-case: `connect-rust-server.md`
- Be descriptive: `discord-role-sync.md` not `drs.md`

### Page Structure

```markdown
---
sidebar_position: 1
---

# Page Title

Brief introduction.

## Prerequisites (if needed)

## Main Content

## Next Steps (if applicable)
```

### Writing Style

- Active voice: "Click the button" not "The button should be clicked"
- Include code examples that actually work
- Add screenshots for UI guides (store in `/static/img/`)
- Always add alt text to images

### Images

```markdown
![Descriptive alt text](/img/meaningful-filename.png)
```

## Sidebar Configuration

Sidebar auto-generates from directory structure. Control order with `sidebar_position` frontmatter or `_category_.json` files:

```json
{
  "label": "Category Name",
  "position": 2,
  "collapsed": true
}
```

## Known Documentation Gaps

Priority areas needing documentation:

1. **Minecraft Setup** - `docs/supported-games/minecraft.md` (placeholder exists)
2. **Troubleshooting Guide** - Common issues and solutions
3. **Webhook/Event System** - Event notifications, webhook setup
4. **Complete API Reference** - Full endpoint documentation
5. **CSMM Migration Guide** - Detailed migration from CSMM

## Testing Changes

Always preview locally before committing:

```bash
npm run start        # Check rendering
npm run build        # Verify build succeeds
```

## Docker

```bash
docker-compose up    # Run at http://localhost:8080
```

Build args available: `TAKARO_VERSION`, `TAKARO_COMMIT`, `TAKARO_BUILD_DATE`

## External Resources

- **Main Takaro repo:** https://github.com/gettakaro/takaro
- **Modules reference:** https://modules.takaro.io
- **Discord:** Community support channel
