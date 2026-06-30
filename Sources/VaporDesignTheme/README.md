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
| `partials/pagination.leaf` | Generic pagination (port of the Publish `Pagination`). Render with `#extend("partials/pagination", paginationContext)` where the context has `hasMultiplePages`, `hasPrevious`/`prevURL`, `hasNext`/`nextURL`, `currentPage`, `totalPages`, `links[]` (each `isEllipsis`/`isCurrent`/`page`/`url`), and the **localised** `previousLabel`/`nextLabel`. Used by the website team page and the blog. **Localisation note:** `#extend("…", obj)` *replaces* the template context with `obj`, so `strings.*`/`#localise` are NOT reachable inside — the prev/next labels must be resolved by the caller and passed in `previousLabel`/`nextLabel` (Kiln's blog feature does this from `strings.previousPage`/`nextPage`; the website team page passes its own localised values). |
| `partials/blog-pagination.leaf` | One-line adapter (`#extend("partials/pagination")`) so Kiln's blog feature — which extends `partials/blog-pagination` — reuses the shared pagination. |
| `partials/author-card.leaf` | Person card (avatar, name, handle, bio, socials) rendered with `team-card` styling. Used for blog author listings and the website team page. Context: `name`, `handle`, `pageURL`, `hasImage`/`imageURL`, `hasDescription`/`description`, `hasSocials`/`socials[]` (`url`/`label`/`icon`). |

`footer.leaf`, `header.leaf`, `pagination.leaf` and `author-card.leaf` are faithful
Leaf ports of the Publish components in `Sources/VaporDesign/Components/`
(`SiteFooter`, `SiteNavigation`, `Pagination`, blog author card).
