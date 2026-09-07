---
sidebar_position: 8
---

# Connect your AI assistant

Takaro exposes an **MCP endpoint**: a single URL that an AI assistant — Claude Code, Claude.ai, ChatGPT, Cursor — can connect to and then use to work with your game servers, players, modules and roles on your behalf.

The assistant acts **as you**. It signs in with your own Takaro account through the normal login page, and every call it makes carries exactly the roles and permissions you already have. It cannot see or do anything you could not do yourself in the dashboard, and every change it makes shows up in your event log attributed to your user.

## What you need

- A Takaro account.
- An assistant ("harness") from the supported list below. Most harnesses need nothing but the endpoint URL; a few need a client id as well.

## The endpoint

| Deployment    | URL                         |
| ------------- | --------------------------- |
| Takaro-hosted | `https://api.takaro.io/mcp` |
| Self-hosted   | `<your BASE_URL>/mcp`       |

You never have to look up a login server. The endpoint publishes a discovery document that tells the assistant where to authenticate, and every compliant harness reads it automatically. Check that it is reachable:

```bash
curl https://api.takaro.io/.well-known/oauth-protected-resource/mcp
```

The response names the endpoint and the authorization server your assistant will be sent to:

```json
{
  "resource": "https://api.takaro.io/mcp",
  "authorization_servers": ["https://<your login host>/realms/takaro"],
  "resource_name": "Takaro API"
}
```

## Claude Code

Add the server by URL. There is no client id, no secret, and no registration step:

```bash
claude mcp add --transport http takaro https://api.takaro.io/mcp
```

The first time Claude Code uses it, a browser opens on the Takaro login page. Sign in, and **a consent screen appears** asking whether to let the assistant act on your Takaro account. Approve it.

Back in Claude Code, check the connection by asking it to list your Takaro domains. It should name every domain you belong to.

## Claude.ai and ChatGPT

Both take the same URL-only path.

- **Claude.ai** — add `https://api.takaro.io/mcp` as a custom connector, then complete the same login and consent.
- **ChatGPT / Codex** — add it as an MCP server by URL.

Neither needs a client id.

## Harnesses without automatic registration

Some harnesses cannot register themselves the way the ones above do. For those, Takaro pre-registers a client in every environment, and you point the harness at its fixed client id:

| Harness           | `client_id`         | Redirect URIs                                                                        |
| ----------------- | ------------------- | ------------------------------------------------------------------------------------ |
| Cursor            | `takaro-mcp-cursor` | `https://www.cursor.com/agents/mcp/oauth/callback`, `http://localhost:8787/callback` |
| VS Code / Copilot | `takaro-mcp-vscode` | `https://vscode.dev/redirect`, `http://127.0.0.1:33418`                              |

Both are public clients using PKCE, both require consent, and both are configured so that no extra scope has to be requested. Their definitions live in the Takaro repository, in [`containers/keycloak/config/takaro-realm.yaml`](https://github.com/gettakaro/takaro/blob/development/containers/keycloak/config/takaro-realm.yaml).

:::caution
These two clients are **not yet verified end to end**. Neither vendor documents whether it can be pointed at a fixed client id rather than registering its own. If you get one of them working — or find that you cannot — please tell us in an issue on the Takaro repository.
:::

Claude Code can also use a fixed client id if you ever need it to, with `claude mcp add --client-id <id> --callback-port <port> …`.

## Not supported yet

**Windsurf** and **Zed** have no client. Neither publishes a fixed callback URL anywhere authoritative, and Takaro will not guess one: a redirect URI that is not exactly right is a security hole rather than a convenience.

More generally, a harness that registers itself by URL can only do so if its own host is on Takaro's allowlist. `claude.ai`, `chatgpt.com` and loopback addresses are allowed today. A new harness on a new host needs that host added to the Takaro deployment's configuration first — there is deliberately no "any host" setting.

## What your assistant can and cannot do

- **It acts as you.** Same roles, same permissions. See [roles and permissions](../roles-and-permissions.md).
- **It works in one domain at a time.** A domain is one tenant: its game servers, players, modules and roles are separate from every other domain's.
- **Staff-only operations are invisible to it.** Anything guarded by Takaro's admin authentication — creating domains, for example — is excluded from what the assistant can see or call, mechanically, not by convention.
- **Everything is audited.** Changes land in your event log with your user as the acting user, exactly as if you had made them in the dashboard. Your normal rate limits apply.

It has four tools:

| Tool                 | What it does                                                                              |
| -------------------- | ----------------------------------------------------------------------------------------- |
| `search_api`         | Finds API operations from a plain-language description, and returns their ids             |
| `describe_operation` | Returns the exact request and response shape of one operation, including validation rules |
| `call_api`           | Runs one operation as you, and returns the response                                       |
| `list_domains`       | Lists the domains you belong to, with their names and ids                                 |

A well-behaved assistant searches, describes, then calls. If it guesses an operation id instead, it gets a clear error telling it to search first.

## Choosing a domain

- **You belong to one domain.** Nothing to do. The assistant never mentions domains and never asks.
- **You belong to several.** A call that does not name a domain is **refused before it runs**, with a message listing each domain by name and id and telling the assistant to ask you which one to use. Tell it, and it repeats the call against that domain. This is deliberate: a helpful guess against the wrong tenant is worse than a question.
- **You belong to none.** Calls are refused, because there is nothing to act on.

Ask your assistant to list your domains if you are not sure what it can see.

## The destructive-call brake

Takaro limits how fast an assistant can delete things.

- **Destructive means a delete.** Creating or updating something is never braked — only operations that remove data.
- By default, **5 destructive calls in 60 seconds**. The sixth is refused with a message telling the assistant to stop and ask you what should be deleted, and that it may try again after the window.
- The window starts at the first destructive call and is not extended by later ones.
- The limit is counted **per user, across all your domains**, and it counts attempts — a delete that Takaro then rejects for another reason still spends one.
- Reading keeps working while the brake is engaged. It stops runaway deletion; it does not lock your assistant out.
- The brake applies **only to the MCP endpoint**. The REST API is unchanged.

Self-hosting? The two settings are `MCP_DESTRUCTIVE_CALL_THRESHOLD` (default `5`) and `MCP_DESTRUCTIVE_CALL_WINDOW_SECONDS` (default `60`).

## Large responses

Two rules keep an answer inside a model's context window:

- A paginated operation called without a page size is given a small one automatically, so "list the players" does not return thousands of rows.
- A response larger than the byte cap (`MCP_MAX_RESPONSE_BYTES`, default 65536) is cut off, and a `--- TRUNCATED ---` note is appended saying how large the response really was and how to fetch the rest — a smaller page size, the next page, or a narrower filter.

If your assistant reports that data was truncated, it is not an error. Ask it to narrow the query.

## Troubleshooting

**The assistant gets a 401.** The token is missing, expired, or was issued for something other than the Takaro API. Disconnect and reconnect the server so the login runs again.

**No consent screen appeared, and the connection failed.** The harness's host is probably not on the allowlist, so Takaro would not let it register itself by URL. Use a pre-registered client id if one exists for your harness, or ask for the host to be added.

**"Unknown operation id".** The assistant invented an id, or the operation is staff-only. Ask it to use `search_api` first.

**The call was refused because you belong to more than one domain.** Tell it which domain to work in; the refusal message lists them.

**A delete was refused with a mention of a limit.** That is the destructive-call brake. Confirm what should be deleted, and it can continue after the window passes.

## Next steps

- [The Takaro API](./api.md) — the same operations, called directly.
- [Roles and permissions](../roles-and-permissions.md) — what your assistant inherits from your account.
