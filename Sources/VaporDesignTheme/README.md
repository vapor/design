# VaporDesignTheme

Shared Leaf templates for Vapor's Kiln sites (vapor.codes, blog.vapor.codes,
docs.vapor.codes, …), shipped as a SwiftPM resource and consumed as a Kiln theme
layer:

```swift
import VaporDesignTheme

theme: .custom(directory: "Theme", sharedLayers: [VaporDesignTheme.directory])
```

Templates resolve site-local first, then this shared layer, then Kiln's bundled
default — so a site can still override any partial in its own `Theme/`.

The shared templates use a custom `#designResource(...)` Leaf tag (see "Shared
head" below), so **every consuming site must also register the theme's tags** by
passing `VaporDesignTheme.leafTags` to `Kiln.build`:

```swift
try await Kiln.build(
    site,
    contentDirectory: "Content",
    outputDirectory: "site",
    leafTags: VaporDesignTheme.leafTags
)
```

Without this, rendering fails with an "unknown tag `designResource`" error.

> Leaf has no comment syntax, so any `<!-- -->` comment in a `.leaf` file leaks
> into every rendered page. Keep the templates comment-free; document them here.

## Per-site configuration

Sites tell the shared partials which site they are via a `siteId` custom string,
and supply the label strings the partials read. Built-in Kiln `strings.*` cover
the common labels (community, resources, team, store, showcase, blog, help,
pressKit, home, theme, language, …); the rest are site-defined `customStrings`.

```swift
Language(.english, isDefault: true, customStrings: [
    "siteId": "main",            // "main" | "blog" | "docs" | "apiDocs"

    // head.leaf — the shared <head>. See "Shared head" below.
    "head.defaultOgType": "website",  // og:type for non-home, non-post pages
    "head.homeSuffix": "",            // appended to site.name on the home page (blog: " Blog")
    "head.titleSeparator": " | ",     // between page title and site.name (docs: " · ")
    // "feedURL": "/feed.rss",        // set ONLY on sites with an RSS feed (blog)

    // footer.leaf
    "footer.tagline": "…",
    "footer.joinDiscord": "Join our Discord",
    "footer.supporters": "Supporters",
    "footer.frameworkDocs": "Framework Docs",
    "footer.apiDocs": "API Docs",

    // header.leaf (marketing navbar — main/blog only)
    "nav.brandText": "Vapor",
    "nav.closeMenu": "Close menu",
    "nav.documentation": "Documentation",
    "nav.frameworkDocs": "Framework Docs",
    "nav.frameworkDocs.caption": "Learn how to use Vapor",
    "nav.apiDocs": "API Docs",
    "nav.apiDocs.caption": "Reference documentation for Vapor",
    "nav.selectTheme": "Select theme",
])
```

Also set `site.copyright` (rendered in the footer).

## Partials

| Partial | Notes |
| --- | --- |
| `partials/footer.leaf` | Shared site footer. Link targets branch on `siteId`. |
| `partials/header.leaf` | Marketing navbar (vapor.codes / blog.vapor.codes). The docs site keeps its own sidebar-shell header. The language picker only renders when the site has more than one language. The blog wraps this in `<header class="vapor-banner">` in its own `base.leaf`. |
| `partials/pagination.leaf` | Generic pagination. Render with `#extend("partials/pagination", paginationContext)` where the context has `hasMultiplePages`, `hasPrevious`/`prevURL`, `hasNext`/`nextURL`, `currentPage`, `totalPages`, `links[]` (each `isEllipsis`/`isCurrent`/`page`/`url`), and the **localised** `previousLabel`/`nextLabel`. Used by the website team page and the blog. **Localisation note:** `#extend("…", obj)` *replaces* the template context with `obj`, so `strings.*`/`#localise` are NOT reachable inside — the prev/next labels must be resolved by the caller and passed in `previousLabel`/`nextLabel` (Kiln's blog feature does this from `strings.previousPage`/`nextPage`; the website team page passes its own localised values). |
| `partials/blog-pagination.leaf` | One-line adapter (`#extend("partials/pagination")`) so Kiln's blog feature — which extends `partials/blog-pagination` — reuses the shared pagination. |
| `partials/author-card.leaf` | Person card (avatar, name, handle, bio, socials) rendered with `team-card` styling. Used for blog author listings and the website team page. Context: `name`, `handle`, `pageURL`, `hasImage`/`imageURL`, `hasDescription`/`description`, `hasSocials`/`socials[]` (`url`/`label`/`icon`). |
| `partials/head.leaf` | The **entire** shared `<head>` — charset, OpenGraph/Twitter cards, canonical, title, favicons, CSS/JS links, structured data. A site's `base.leaf` uses it as `<head>#extend("partials/head")</head>` (unscoped, so `#localise`/`customStrings`/`site.*`/`page.*` are all reachable). See "Shared head" below for the config contract. |
| `partials/head-preconnect.leaf` | The two `<link rel="preconnect">` hints to the `design.vapor.codes` CDN. Consumed by `head.leaf` near the **top** of `<head>` so the connection warms before the render-blocking CSS/fonts load. Static — no context needed. |
| `partials/head-brand.leaf` | The shared favicon set, `apple-mobile-web-app-title`, and light/dark `theme-color` metas — identical across every Vapor site. Consumed by `head.leaf`; reads `#(site.name)` from the inherited context. |

## Shared head

`partials/head.leaf` is the whole `<head>`, shared by every site. A site's
`base.leaf` uses it like this:

```leaf
<!DOCTYPE html>
<html lang="#(language.locale)">
<head>
    #extend("partials/head")
</head>
<body>
    …
</body>
</html>
```

All per-site variation is driven by **data**, not by editing the template:

| Divergence | Driven by |
| --- | --- |
| `og:type` | Rule `blogPost ? article : (isHome ? website : head.defaultOgType)`. Set `head.defaultOgType` per site (`website` for the marketing/blog sites, `article` for docs). |
| `<title>` / social title | `#if(page.isHome)` → `site.name` + `head.homeSuffix`; else the page title + `head.titleSeparator` + `site.name`. The page title honours a `page.frontMatter.titleKey` (localised) when present, else `page.title`. Titles longer than 50 chars drop the ` <sep> site.name` suffix (SEO). |
| `twitter:site` / `twitter:creator` | `site.twitterSite` (`KilnSite(twitterSite:)`). Emitted only when set. |
| Extra stylesheets | `KilnSite(extraCSS:)` — each entry is rendered as `<link rel="stylesheet" href="/…">` after the shared `main.css`. |
| RSS feed `<link>` | Emitted only when a dot-free `feedURL` custom string is set (blog only). |
| `og:image` / `article:*` / `markdownURL` / `author` / `noindex` / hreflang alternates | All gated on the relevant context (`page.imageURL`, `blogPost`, `markdownURL`, `site.author`, `noindex`, `count(languages) > 1`). Sites that don't provide them emit nothing — no per-site config needed. |

**Every consuming site must set** `head.defaultOgType`, `head.homeSuffix`, and
`head.titleSeparator` in each language's `customStrings` (a missing `#localise`
key would otherwise render as an empty string, or the raw key). `feedURL` is
optional and set only where a feed exists.

> **Undefined-key safety.** LeafKit treats a missing variable in `#(x)` / `#if(x)`
> as empty/false (no error), so the head can reference the *superset* of every
> site's fields and each site fills only what it has. The one exception is
> `#for(x in y)`, which **throws** if `y` is undefined — so every loop here is
> either over an always-present array (`languages`, `site.extraCSS`) or wrapped in
> an `#if` presence check (`#if(blogPost)`). Keep it that way when editing.

> **CSS/JS live on the CDN.** These assets are built by webpack (`npm run build`)
> into `Content/` and served from `design.vapor.codes`; deploy a new one to the
> CDN before a site references it. `head.leaf` links `main.css`,
> `js/theme-init.js` (the pre-paint colour-scheme script), `main.js`, and — on
> docs/apiDocs sites — `docs.css`. The docs `base.leaf` additionally loads
> `js/search-init.js` (before Kiln's `search.js`) and `docs.js` (the docs-body
> interactions: mobile drawers, scroll-spy, search).
>
> **Loading un-deployed assets locally.** Those URLs are emitted by Kiln's
> `#designResource("<path>")` Leaf tag rather than hard-coded. By default it
> resolves to `https://design.vapor.codes/<path>`; set the `VAPOR_DESIGN_ASSET_URL`
> environment variable (e.g. `http://localhost:8001`, a local design webpack dev
> server) to point every consuming site at that base instead — so you can test
> in-progress design changes without waiting for a CDN deploy. Unset, sites use
> the production CDN.
