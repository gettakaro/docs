---
sidebar_position: 4
---

# API

For a hands-on experience and quick start with the Takaro API, visit the [interactive API documentation](https://api.takaro.io/api.html). You can explore endpoints, make test requests, and view responses in real-time.

## Authentication

To use the API programmatically, authenticate by calling the login endpoint with your credentials. This returns a session token you can use for subsequent requests.

### Logging in

Send a `POST` request to `/login` with your email and password:

```sh
curl -X POST https://api.takaro.io/login \
  -H "Content-Type: application/json" \
  -d '{"username": "your-email@example.com", "password": "your-password"}'
```

The response contains your session token:

```json
{
  "meta": {},
  "data": {
    "token": "your-session-token"
  }
}
```

If you don't have login credentials (your email and password), ask your server administrator to create them for you.

### Using your token

Include the token as a Bearer token in the `Authorization` header on all subsequent requests:

```sh
curl -X POST https://api.takaro.io/gameserver/search \
  -H "Authorization: Bearer your-session-token" \
  -H "Content-Type: application/json" \
  -H "x-takaro-domain: your-domain-id" \
  -d '{}'
```

The token is valid for the duration of your session. If you receive a `401 Unauthorized` response, log in again to get a fresh token.

:::info Future: API Keys
We are working on API key support for long-lived programmatic access. If this is something you need, we'd love to hear from you — reach out on [Discord](https://aka.takaro.io/discord) or [check our roadmap](https://roadmap.takaro.io).
:::

## Domain Context

Takaro is a multi-tenant platform. Each **domain** is an isolated environment with its own game servers, players, modules, and settings. When you make API calls, you need to tell the API which domain you're operating in.

### Setting domain context

There are two ways to specify your domain:

**HTTP header (recommended for API integrations):**

Add the `x-takaro-domain` header to your requests, as shown in [Using your token](#using-your-token) above.

**Cookie (used by the web dashboard):**

The Takaro dashboard uses a `takaro-domain` cookie to track your selected domain. The dashboard sets this cookie automatically when you switch domains in the UI via the `POST /selected-domain/:domainId` endpoint. You typically don't need to manage this cookie manually.

If you don't specify a domain, the API defaults to your first active domain.

### Finding your domain ID

After logging in, call `GET /me` to see your available domains:

```sh
curl https://api.takaro.io/me \
  -H "Authorization: Bearer your-session-token"
```

The response includes your domains:

```json
{
  "meta": {},
  "data": {
    "user": { "..." : "..." },
    "domains": [
      { "id": "your-domain-id", "name": "My Game Community" }
    ],
    "domain": "your-domain-id"
  }
}
```

Use the `id` value as your `x-takaro-domain` header.

### Complete example

Putting it all together — log in, find your domain, and list your game servers:

```sh
# 1. Log in
TOKEN=$(curl -s -X POST https://api.takaro.io/login \
  -H "Content-Type: application/json" \
  -d '{"username": "your-email@example.com", "password": "your-password"}' | jq -r '.data.token')

# 2. Get your domain ID
DOMAIN=$(curl -s https://api.takaro.io/me \
  -H "Authorization: Bearer $TOKEN" | jq -r '.data.domain')

# 3. List game servers
curl -X POST https://api.takaro.io/gameserver/search \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "x-takaro-domain: $DOMAIN" \
  -d '{}'
```

## Querying Data

Takaro API provides powerful querying capabilities through its various POST /search endpoints. You can use these endpoints to retrieve data based on specific criteria. The querying features include filters for exact matches, searches for partial matches, and pagination for handling large data sets.

### Filters

Filters allow you to specify exact match criteria for the data you are querying. When you use filters, the API will return only the records that exactly match the specified criteria.

```json
{
  "filters": {
    "name": ["John Doe"],
    "email": ["john.doe@example.com"]
  }
}
```

In the above example, the API will return records where the name is exactly "John Doe" and the email is exactly "john.doe@example.com".

### Searches

Searches, on the other hand, allow for partial matches. This is useful when you are looking for records that contain a specific substring.

```json
{
  "search": {
    "name": ["John"]
  }
}
```

In the above example, the API will return all records where the name contains the substring "John".

### Pagination

When querying large data sets, it's often useful to retrieve the data in smaller chunks or pages. You can use the page and limit parameters to achieve this.

```json
{
  "page": 2,
  "limit": 10
}
```

In the above example, the API will return the second page of results, with a limit of 10 records per page.

### Extend

The extend parameter allows you to include related entities in the response. This reduces the need for multiple API calls and improves performance when you need associated data.

```json
{
  "extend": ["roles", "gameServers"]
}
```

When using extend, the related data will be included in the response object under the property name specified in the extend array. This makes it easy to access all necessary information in a single request.

#### Nested Extends

Some endpoints support nested extends using dot notation:

```json
{
  "extend": ["listing.items.item"]
}
```

This will include the listing, its items, and the full item details for each item in the shop order response.

### Putting it all together

You can combine filters, searches, pagination, and extend in a single query. Here is an example that combines all features:

```json
{
  "filters": {
    "email": ["john@example.com"]
  },
  "search": {
    "name": ["John"]
  },
  "page": 1,
  "limit": 5,
  "extend": ["roles", "gameServers"]
}
```

This query will return the first page of records where the email field exactly matches "john@example.com", and the name field contains the substring "John", with a maximum of 5 records in the response, including the related roles and gameServers data for each record.

## Error Codes and Handling

The Takaro API returns error information within the response data. In case an error occurs, you should inspect the `meta.error` property in the response data for details about the error.

If there is an error in the API response, it might look like this:

```json
{
  "meta": {
    "error": {
      "code": "ValidationError",
      "details": {}
    }
  },
  "data": null
}
```

In this example, the meta.error property will contain a description of the error.

## SDKs and Libraries

To interact with the Takaro API programmatically, you can use the `@takaro/apiclient` library. Install it via npm:

```sh
npm install @takaro/apiclient
```

Then use it in your project:

```javascript
import { Client } from '@takaro/apiclient';

const client = new Client({
  url: 'https://api.takaro.io',
  auth: {
    username: 'your-email@example.com',
    password: 'your-password',
  },
});

// Log in and get your token
await client.login();

// Set your domain context
client.setDomain('your-domain-id');

// Make authenticated requests
const servers = await client.gameserver.gameServerControllerSearch();
```

For full API coverage, see the [interactive API documentation](https://api.takaro.io/api.html).

