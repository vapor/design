import Kiln

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
        palette: .autoLightDark(primary: .black, accent: .blue)
    ),
    // The style guide's own pages aren't useful as AI/markdown output.
    llmsText: false
) {
    Page("Design Guide", "index.md")
}

try await Kiln.build(site, contentDirectory: "Content", outputDirectory: "site")
