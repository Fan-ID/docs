# Soundlink Public API — documentation (Mintlify)

Developer docs for `https://api.getsoundlink.com`, built with [Mintlify](https://mintlify.com).

## What is auto-generated vs manual

| Content                                            | Source                                                                     |
| -------------------------------------------------- | -------------------------------------------------------------------------- |
| **API Reference** (endpoints, schemas, playground) | `openapi/soundlink-public-api-v1.yaml` — Mintlify generates pages on build |
| **Guides** (intro, quickstart, auth, errors)       | `*.mdx` in this repo — edited by hand                                      |

OpenAPI **source of truth** lives in the backend repo:

`backend/specs/public-api/soundlink-public-api-v1.yaml`

After changing the spec in backend, run:

```bash
make sync-openapi
```

## Local preview

Requires Node 20+ and the Mintlify CLI:

```bash
npm i -g mint
make sync-openapi   # optional if yaml already copied
mint dev
```

Open http://localhost:3000

## Deploy (Mintlify hosting)

1. Go to [mintlify.com/start](https://mintlify.com/start) and connect this GitHub repo (`api-docs`).
2. Set the docs root to the repository root (where `docs.json` lives).
3. Add custom domain, e.g. `docs.getsoundlink.com`, or proxy `getsoundlink.com/docs` per [Mintlify subpath guide](https://www.mintlify.com/docs/deploy/docs-subpath).

## Repo layout

```
api-docs/
  docs.json          # Mintlify config + navigation
  index.mdx          # Introduction
  quickstart.mdx
  authentication.mdx
  errors.mdx
  openapi/           # Copy of Public API OpenAPI spec
  Makefile           # sync-openapi, dev
```

## Branding (optional)

Add `logo/light.svg`, `logo/dark.svg`, and `favicon.svg`, then wire them in `docs.json` when ready.
