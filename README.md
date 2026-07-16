# Soundlink documentation

Customer-facing docs for [Soundlink](https://getsoundlink.com), built with [Mintlify](https://mintlify.com).

**Live site:** deployed from this repo when changes merge to `main`.

This guide is for **anyone on the team** — product, support, marketing, or engineering — who needs to add or update documentation. You do not need to write code.

---

## What lives here

| Area               | Audience                             | Where it lives                                    |
| ------------------ | ------------------------------------ | ------------------------------------------------- |
| **Learn**          | People using Soundlink in the app    | `learn/` — product concepts (e.g. credit wallet)  |
| **For Developers** | Engineers integrating the Public API | Root `.mdx` files — quickstart, auth, guides      |
| **API Reference**  | Engineers calling endpoints          | `openapi/` — auto-generated from the backend spec |

**Rule of thumb:** If it describes what a user sees or does in the app → **Learn**. If it describes API keys, endpoints, or code → **For Developers**.

Do **not** document internal-only behavior (feature flags, admin tools, backend error codes users never see).

---

## Repo structure

```
api-docs/
├── docs.json          ← sidebar navigation (required for every new page)
├── index.mdx          ← docs home page
├── learn/             ← product / “Learn” articles
│   ├── index.mdx
│   └── wallet/        ← example topic folder
├── images/            ← screenshots (use subfolders per topic)
├── openapi/           ← API spec (synced from backend — ask engineering)
└── *.mdx              ← developer guides at repo root
```

Every page is a **`.mdx` file** (Markdown + optional Mintlify components).

---

## Writing standards

Follow these so docs stay consistent and accurate:

- **Voice:** second person, active (“Click **Settings**”, not “The user should click…”).
- **Headings:** sentence case (`## How to top up`, not `## How To Top Up`).
- **UI labels:** bold — **Settings**, **Credit wallet & payment methods**, **Top up wallet**.
- **Accuracy:** describe only what users can see and do in the product today. Verify in the app before publishing.
- **Scope:** one page = one concept or flow. Link to related pages instead of duplicating.
- **Support:** when in doubt, end with [hello@getsoundlink.com](mailto:hello@getsoundlink.com).

---

## Add a new article

### 1. Create the file

Pick a folder that matches the topic:

| Topic type      | File location                  | URL example            |
| --------------- | ------------------------------ | ---------------------- |
| Product / Learn | `learn/<topic>/my-article.mdx` | `/learn/wallet/top-up` |
| Developer guide | `my-article.mdx` (repo root)   | `/syncing-campaigns`   |

**Filename rules:** lowercase, words separated by hyphens (`campaign-budget-top-up.mdx`).

### 2. Add frontmatter

Every page must start with YAML frontmatter:

```mdx
---
title: Top up
description: Add credits to your workspace credit wallet with a one-time card payment.
---

Your first paragraph goes here…
```

- **title** — shown in the sidebar and page heading.
- **description** — short summary for search and link previews (one sentence).

### 3. Register the page in navigation

Open **`docs.json`** and add your file path (without `.mdx`) to the right group under `navigation → tabs → Documentation → groups`.

**Single page** — add a string to the `pages` array:

```json
"pages": [
  "learn/index",
  "learn/wallet/index",
  "learn/wallet/top-up"
]
```

**New sidebar section (nested group)** — add a group object:

```json
{
  "group": "Credit wallet",
  "pages": ["learn/wallet/index", "learn/wallet/top-up"]
}
```

The path must match the file location. If the page is missing from `docs.json`, it will **404** on the live site.

### 4. Link from related pages

Add links on hub pages (e.g. `learn/index.mdx` or `learn/wallet/index.mdx`) so readers can discover the new article.

---

## Add a new Learn section

Example: a new topic **“Campaign insights”** under Learn.

1. Create folder `learn/insights/`.
2. Add `learn/insights/index.mdx` (overview) and child pages as needed.
3. In `docs.json`, under the **Learn** group, add a nested group:

```json
{
  "group": "Learn",
  "pages": [
    "learn/index",
    {
      "group": "Credit wallet",
      "pages": ["learn/wallet/index", "..."]
    },
    {
      "group": "Campaign insights",
      "pages": ["learn/insights/index", "learn/insights/metrics"]
    }
  ]
}
```

4. Add a **Card** on `learn/index.mdx` pointing to the new section.

---

## Screenshots

Screenshots are optional. When you add them:

1. Save images under `images/<topic>/` (e.g. `images/wallet/top-up-dialog.png`).
2. Use PNG or WebP; keep file sizes reasonable (compress if needed).
3. Insert with a caption:

```mdx
<Frame caption="Top up wallet — choose an amount and select a payment method">
  <img
    src="/images/wallet/top-up-dialog.png"
    alt="Top up dialog with preset amounts, payment method list, and Pay button"
  />
</Frame>
```

Always write a descriptive **alt** text (accessibility). Wallet Learn pages currently ship without screenshots — add updated captures when available.

---

## Useful Mintlify blocks

Copy these into your `.mdx` files as needed.

**Callout — tip**

```mdx
<Note>
  Top-up credits stay in your workspace. They cannot be transferred or withdrawn
  as cash.
</Note>
```

**Callout — warning**

```mdx
<Warning>
  Do not close Stripe Checkout after applying wallet credits unless you intend
  to abandon payment.
</Warning>
```

**Link cards (hub pages)**

```mdx
<CardGroup cols={2}>
  <Card title="Top up" icon="credit-card" href="/learn/wallet/top-up">
    Add credits to your workspace.
  </Card>
</CardGroup>
```

**Table**

```mdx
| Limit   | Value        |
| ------- | ------------ |
| Minimum | **$50**      |
| Maximum | **$100,000** |
```

More components: [Mintlify documentation](https://mintlify.com/docs/content/components).

---

## Preview locally (optional)

If you want to see changes before opening a PR:

```bash
# From the api-docs folder
make dev
```

Then open **http://localhost:3000**. Requires Node.js; if setup fails, skip preview and rely on PR review + Mintlify deploy preview.

---

## Open a pull request

### Checklist

- [ ] New or updated `.mdx` file(s) with `title` and `description`
- [ ] Page path added to **`docs.json`** (if new page or moved page)
- [ ] Links updated on related hub/index pages
- [ ] Screenshots added under `images/` (if applicable)
- [ ] Content verified against the live app
- [ ] No internal-only details (flags, admin flows, unreleased features)

### Steps

1. **Branch** — create a branch from `main`, e.g. `docs/wallet-top-up-limits`.
2. **Edit** — use GitHub web editor, Cursor, or your usual editor.
3. **Commit** — clear message, e.g. `docs: add wallet top-up limits`.
4. **Push** and **open a PR** against `main`.
5. **PR description** — include:
   - **What changed** (1–3 bullets)
   - **Why** (user question, support gap, product launch)
   - **Screenshots** of the app or docs preview if UI changed
6. **Review** — tag product or engineering for accuracy. Merge when approved.

Changes deploy to production automatically after merge to `main`.

---

## What engineering handles

| Task                        | Who                                                                |
| --------------------------- | ------------------------------------------------------------------ |
| Product / Learn articles    | Anyone on the team (this guide)                                    |
| API Reference content       | Engineering — spec lives in `backend/specs/public-api/`            |
| Sync OpenAPI into docs      | `make sync-openapi` (from a machine with backend repo checked out) |
| Mintlify dashboard / domain | Engineering / ops                                                  |

If you need a new **API** endpoint documented, open a request to engineering — do not hand-edit `openapi/soundlink-public-api-v1.yaml`.

---

## Need help?

- **Content or structure:** ask in your team channel or tag docs reviewers on the PR.
- **Mintlify / build issues:** [Mintlify docs](https://mintlify.com/docs) or engineering.
- **Product accuracy:** verify in the app or ask product/support.
