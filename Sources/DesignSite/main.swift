import Kiln
import VaporDesignTheme

// Shared-chrome strings the header/footer partials expect. The style guide is
// English-only, so these live inline here rather than in per-language files.
// `siteId` is left unset so the nav links point at the live sites
// (www.vapor.codes, blog.vapor.codes, …) rather than design-guide-local routes.
let designStrings: [String: String] = [
    "nav.brandText": "Vapor",
    "nav.closeMenu": "Close menu",
    "nav.documentation": "Documentation",
    "nav.frameworkDocs": "Framework Docs",
    "nav.frameworkDocs.caption": "Learn how to use Vapor",
    "nav.apiDocs": "API Docs",
    "nav.apiDocs.caption": "Reference documentation for Vapor",
    "nav.selectTheme": "Select theme",
]

let designLanguage = Language(.english, isDefault: true, customStrings: designStrings)

// The Vapor design guide (design.vapor.codes), built with Kiln.
//
// This site is a living style guide: a single page that showcases every shared
// component (navbar, typography, buttons, code blocks, lists, pagination, cards,
// footer, …) styled by the design system's `main.css`. It also hosts the CDN
// assets every Vapor site loads: `main.css` / `main.js`, fonts, icons and the
// favicons. Those assets are built by webpack (`npm run build`) into ./Content,
// from where Kiln copies them into ./site — wired up via `kiln.json`'s preBuild
// step so `kiln serve` / `kiln build` rebuild them first.
let site = KilnSite(
    name: "Vapor's Design Guide",
    url: "https://design.vapor.codes",
    description: "The style guide for Vapor's design system.",
    theme: .custom(
        directory: "Theme",
        // Consume the shared header/footer partials so the showcased navbar is
        // literally the one the other sites use (no drift).
        sharedLayers: [VaporDesignTheme.directory],
        palette: .autoLightDark(primary: .black, accent: .blue)
    ),
    languages: [designLanguage],
    // The style guide's own pages aren't useful as AI/markdown output.
    llmsText: false
) {
    Page("Design Guide", "index.md")
}

try await Kiln.build(site, contentDirectory: "Content", outputDirectory: "site")
