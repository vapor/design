import Kiln
import VaporDesignTheme

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

let site = KilnSite(
    name: "Vapor's Design Guide",
    url: "https://design.vapor.codes",
    description: "The style guide for Vapor's design system.",
    theme: .custom(
        directory: "Theme",
        sharedLayers: [VaporDesignTheme.directory],
        palette: .autoLightDark(primary: .black, accent: .blue)
    ),
    languages: [designLanguage],
    llmsText: false
) {
    Page("Design Guide", "index.md")
}

try await Kiln.build(
    site,
    contentDirectory: "Content",
    outputDirectory: "site",
    leafTags: VaporDesignTheme.leafTags
)
