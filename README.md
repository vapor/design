# Vapor Design

This repo contains all of the materials used for building out Vapor's design across its many sites, built on top of Bootstrap. It contains the reference designs and files from designers in [Reference](/Reference/) and the build pipeline that generates the shared assets included in Vapor's sites. These are automatically deployed to https://design.vapor.codes — hosted on our CDN — and then included in the different sites.

The repo produces two things:

1. **The CDN assets** — `main.css` (compiled from Sass), `main.js` (Bootstrap + our scripts), fonts, icons and favicons. Every Vapor site (vapor.codes, blog.vapor.codes, docs.vapor.codes) loads these from design.vapor.codes. Built by webpack from [`src`](/src/) and [`static`](/static/).
2. **The design guide** — a single-page style guide at design.vapor.codes showcasing every component (navbar, typography, buttons, code blocks, lists, pagination, cards, footer, …) styled by `main.css`. Built with [Kiln](https://github.com/brokenhandsio/kiln).

The repo also ships a `VaporDesignTheme` Swift library: the shared Leaf partials (header/footer/head/pagination/author-card) that Vapor's Kiln sites pull in as a theme layer.

## Running

You'll need [npm](https://www.npmjs.com) (use [nvm](https://github.com/nvm-sh/nvm) to manage it) and a Swift toolchain.

The build is a two-step pipeline: webpack builds the CDN assets **into `./Content`**, then the Kiln generator copies them — along with the rendered HTML — into `./site`. `kiln.json` wires webpack in as a pre-build step, so:

```bash
npm install
kiln serve      # rebuilds webpack assets + the site on change, serves at :8080
```

Or build once without the Kiln CLI:

```bash
npm install && npm run build && swift run DesignSite
```

The finished site is written to `./site` (deployed to the S3 bucket behind design.vapor.codes). Both `./Content`'s generated files and `./site` are git-ignored; only `Content/index.md` and the `Theme/` templates are source.

## Copyright

All the designs and images in this repository are the copyright of Vapor and QuTheory LLC and not part of Vapor's open source code.
