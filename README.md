# Vapor Design

This repo contains all of the materials used for building out Vapor's design across its many sites, built on top of Bootstrap. It contains the reference designs and files from designers in [Reference](/Reference/) and the build pipeline that generates the shared assets included in Vapor's sites. These are automatically deployed to https://design.vapor.codes — hosted on our CDN — and then included in the different sites.

The repo produces two things:

1. **The CDN assets** — `main.css` (compiled from Sass), `main.js` (Bootstrap + our scripts), fonts, icons and favicons. Every Vapor site (vapor.codes, blog.vapor.codes, docs.vapor.codes) loads these from design.vapor.codes. Built by webpack from [`src`](/src/) and [`static`](/static/).
2. **The design guide** — a single-page style guide at design.vapor.codes showcasing every component (navbar, typography, buttons, code blocks, lists, pagination, cards, footer, …) styled by `main.css`. Built with [Kiln](https://github.com/brokenhandsio/kiln).

The repo also ships a `VaporDesignTheme` Swift library: the shared Leaf partials (header/footer/head/pagination/author-card) that Vapor's Kiln sites pull in as a theme layer.

## Running

Local development uses the [Kiln CLI](https://github.com/brokenhandsio/kiln) (a Swift binary — install it once, see the Kiln README) plus [npm](https://www.npmjs.com) (use [nvm](https://github.com/nvm-sh/nvm) to manage it).

First install the npm dependencies. The Kiln CLI runs the webpack **build** for you (via the `kiln.json` pre-build step) but it does **not** run `npm install` — so do that yourself the first time, and whenever dependencies change:

```bash
npm install
```

### Local dev

```bash
kiln serve
```

`kiln serve` runs the `kiln.json` pre-build (`npm run build`) to compile the CDN assets into `./Content`, generates the site into `./site`, serves it at http://localhost:8080, and watches both `src/` (Sass/JS) and the `Theme/` templates — re-running webpack and regenerating the site on every change.

### Build a deployable site

```bash
kiln build
```

The same pipeline, one-shot: webpack builds the CDN assets into `./Content`, then Kiln copies them — with the rendered HTML — into `./site`, ready to deploy to the S3 bucket behind design.vapor.codes.

Both `./Content`'s generated files and `./site` are git-ignored; only `Content/index.md` and the `Theme/` templates are source. (CI, which has no Kiln CLI, runs the two steps manually: `npm run build && swift run DesignSite`.)

## Copyright

All the designs and images in this repository are the copyright of Vapor and QuTheory LLC and not part of Vapor's open source code.
