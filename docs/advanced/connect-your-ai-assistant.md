---
sidebar_position: 8
---

# Connect your AI assistant

Takaro exposes an **MCP endpoint**: a single URL your AI assistant connects to. Once connected, it can work with your game servers, players, modules, and roles on your behalf. Claude Code, Claude.ai, and ChatGPT connect with nothing but that URL.

The assistant acts **as you**. It signs in with your own Takaro account through the normal login page, and every call it makes carries exactly the roles and permissions you already have. It cannot see or do anything you could not do yourself in the dashboard, and every change it makes appears in your event log attributed to your user.

## What you need

- A Takaro account.
- Membership of at least one Takaro domain. An assistant connected to an account with no domain can sign in, but has nothing to act on.
- One of the assistants below.

## Which assistant do you have?

| Assistant             | Status                                    | What you supply     | Where            |
| --------------------- | ----------------------------------------- | ------------------- | ---------------- |
| Claude Code           | Verified                                  | The URL             | [Claude Code](#claude-code) |
| Claude.ai             | Expected to work, not confirmed by Takaro | The URL             | [Claude.ai](#claudeai) |
| ChatGPT and Codex     | Expected to work, not confirmed by Takaro | The URL             | [ChatGPT and Codex](#chatgpt-and-codex) |
| Cursor                | Unverified                                | The URL and a client id | [Assistants that need a client id](#assistants-that-need-a-client-id) |
| VS Code / Copilot     | Unverified                                | The URL and a client id | [Assistants that need a client id](#assistants-that-need-a-client-id) |
| Windsurf, Zed         | Not supported                             | —                   | [Not supported yet](#not-supported-yet) |

"Verified" means somebody has driven the whole flow — sign-in, consent, and real calls — end to end. Everything below that line is honest about what has not been tried yet.

## The endpoint

| Deployment    | URL                         |
| ------------- | --------------------------- |
| Takaro-hosted | `https://api.takaro.io/mcp` |
| Self-hosted   | `<your BASE_URL>/mcp`       |

You never have to look up a login server. The endpoint publishes a discovery document that tells the assistant where to authenticate, and every compliant assistant reads it automatically.

## Claude Code

Add the server by URL. There is no client id, no secret, and no registration step:

```bash
claude mcp add --transport http takaro https://api.takaro.io/mcp
```

The first time Claude Code uses it, a browser opens on the Takaro login page. Sign in, and **a consent screen appears** asking whether to let the assistant act on your Takaro account. Approve it.

Check the connection by asking Claude Code:

> list my Takaro domains

It should name every domain you belong to. To disconnect and start over:

```bash
claude mcp remove takaro
```

## Claude.ai

Open **Settings → Connectors**, add a custom connector, and give it `https://api.takaro.io/mcp`. The same login and consent screens follow. Check it the same way — ask it to list your Takaro domains.

Custom connectors are not available on every Claude.ai plan. If you cannot find the option, use Claude Code instead.

## ChatGPT and Codex

Both add MCP servers by URL, from their own settings. Give them `https://api.takaro.io/mcp`, complete the login and consent, then ask the assistant to list your Takaro domains.

Where that setting lives moves between ChatGPT releases and plans, so follow your assistant's own documentation for adding a remote MCP server. Nothing Takaro-specific is needed beyond the URL.

## Assistants that need a client id

Claude Code, Claude.ai and ChatGPT register themselves with Takaro automatically, using their vendor's published identity. Cursor and VS Code do not. For those, Takaro pre-registers a client in every environment, and you point the assistant at its fixed client id:

| Assistant         | `client_id`         |
| ----------------- | ------------------- |
| Cursor            | `takaro-mcp-cursor` |
| VS Code / Copilot | `takaro-mcp-vscode` |

Add `https://api.takaro.io/mcp` as an MCP server in the assistant, then look for a client-id setting on that server entry and put the id above in it. Everything else — consent, permissions, scopes — is already configured on Takaro's side.

:::caution Unverified
Neither vendor documents whether it lets you supply a client id at all, and neither has been driven through this flow end to end. **If you cannot find a client-id setting, that assistant is not supported yet** — it will try to register itself, which Takaro refuses. Either way, please [open an issue](https://github.com/gettakaro/takaro/issues/new) telling us what you found; it is exactly what we are missing.
:::

Self-hosting, or curious about the details? Both clients are defined in [`containers/keycloak/config/takaro-realm.yaml`](https://github.com/gettakaro/takaro/blob/development/containers/keycloak/config/takaro-realm.yaml), including the exact redirect URIs they accept.

## Not supported yet

**Windsurf** and **Zed** have no client. Neither publishes a fixed callback URL anywhere authoritative, and Takaro will not guess one: a redirect URI that is not exactly right is a security hole rather than a convenience.

More generally, an assistant that registers itself by URL can only do so if its own host is on Takaro's allowlist. `claude.ai`, `chatgpt.com` and loopback addresses are allowed today. On Takaro-hosted, [open an issue](https://github.com/gettakaro/takaro/issues/new) to ask for a host to be added. On a self-hosted deployment you add it yourself — see [Self-hosted deployments](#self-hosted-deployments).

## What your assistant can and cannot do

Your assistant acts as you: same roles, same permissions, as described in [roles and permissions](../roles-and-permissions.md). It works in one domain at a time — a domain is one tenant, and its game servers, players, modules, and roles are separate from every other domain's. Staff-only operations, such as creating domains, are excluded from what it can see or call at all. Every change lands in your event log with your user as the acting user, exactly as if you had made it in the dashboard, and your normal rate limits apply.

It has four tools:

| Tool                 | What it does                                                                              |
| -------------------- | ----------------------------------------------------------------------------------------- |
| `search_api`         | Finds API operations from a plain-language description, and returns their ids             |
| `describe_operation` | Returns the exact request and response shape of one operation, including validation rules |
| `call_api`           | Runs one operation as you, and returns the response                                       |
| `list_domains`       | Lists the domains you belong to, with their names and ids                                 |

A well-behaved assistant searches, describes, then calls. If it guesses an operation id instead, it gets a clear error telling it to search first.

## Choosing a domain

If you belong to one domain, there is nothing to do — the assistant never mentions domains and never asks.

If you belong to several, a call that does not name a domain is **refused before it runs**, with a message listing each domain by name and id and telling the assistant to ask you which one to use. Tell it, and it repeats the call against that domain. This is deliberate: guessing wrong and acting on the wrong domain is worse than asking.

If you belong to none, every call is refused, because there is nothing to act on.

Ask your assistant to list your domains if you are not sure what it can see.

## The destructive-call brake

Takaro limits how fast an assistant can delete things. By default, the sixth delete within 60 seconds is refused, with a message telling the assistant to stop, ask you what should be deleted, and try again after the window. The window starts at the first delete and is not extended by later ones.

Deletes are counted per user across all your domains, and attempts count — a delete Takaro then rejects for another reason still spends one. Creating and updating are never braked, only deleting (and any operation Takaro explicitly marks as destructive). Reading keeps working while the brake is engaged: it stops runaway deletion, it does not lock your assistant out. The brake applies only to the MCP endpoint, never to the REST API.

## Large responses

Two rules keep an answer inside a model's context window:

- A paginated operation called without a page size is given a small one automatically, so "list the players" does not return thousands of rows.
- A response larger than 64 KB is cut off, and a `--- TRUNCATED ---` note is appended saying how large the response really was and how to fetch the rest — a smaller page size, the next page, or a narrower filter.

If your assistant reports that data was truncated, that is not an error. Ask it to narrow the query.

## Revoking access

Removing the MCP server from your assistant stops that assistant using it, but it does not withdraw the permission you granted on the consent screen. To do that, open the account console of the login server your browser was sent to during setup — its address is the one you saw in the browser while signing in — and remove Takaro's entry under **Applications**. Signing out of every session there ends any access token already issued.

Do both if you have lost the device the assistant was running on.

## Troubleshooting

### The assistant says it cannot reach Takaro, or reports a 401

The token is missing, expired, or was issued for something other than the Takaro API. Remove the MCP server from your assistant and add it again so the login runs afresh — in Claude Code, `claude mcp remove takaro` followed by the `claude mcp add` command above.

### The browser opened but the login page never loaded

Self-hosted deployments only. The login server has to be reachable **from the machine running the browser**, over HTTPS, on a public hostname. An internal-only address dead-ends here even though the API itself works.

### No consent screen appeared, and the connection failed

The assistant's host is probably not on Takaro's allowlist, so Takaro would not let it register itself by URL. Use a client id if one exists for your assistant, or ask for the host to be added.

### The assistant says "Unknown operation id"

The full message is: _Unknown operation id "…". It does not exist or is not available through this endpoint. Use search_api to find a valid operation id._ Either the assistant invented an id, or the operation is staff-only. Ask it to search first.

### The call was refused because you belong to more than one domain

Tell the assistant which domain to work in; the refusal message lists them by name.

### A delete was refused with a mention of a limit

That is the destructive-call brake. Confirm what should be deleted, and the assistant can continue once the window has passed.

### Checking the endpoint is reachable

```bash
curl https://api.takaro.io/.well-known/oauth-protected-resource/mcp
```

A healthy deployment answers with a small JSON document naming the endpoint and the login server your assistant will be sent to. Anything else — a connection error, an HTML error page — means the endpoint itself is the problem, not your assistant.

## Self-hosted deployments

- The endpoint is `<your BASE_URL>/mcp`, and the login server must be reachable over HTTPS from your users' browsers.
- An assistant may only register itself by URL if its host is listed in `keycloak.realm.mcp.permittedClientIdDomains`. There is no wildcard: `*` matches nothing, and an empty list rejects everything. Every host in the assistant's redirect URIs has to be listed too.
- The brake is `MCP_DESTRUCTIVE_CALL_THRESHOLD` (default `5`) within `MCP_DESTRUCTIVE_CALL_WINDOW_SECONDS` (default `60`).
- The response cap is `MCP_MAX_RESPONSE_BYTES` (default `65536`).

## Next steps

- [The Takaro API](./api.md) — the same operations, called directly.
- [Roles and permissions](../roles-and-permissions.md) — what your assistant inherits from your account.
