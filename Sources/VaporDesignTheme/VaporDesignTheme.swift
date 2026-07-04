import Foundation

/// Shared Leaf templates for Vapor's Kiln sites (vapor.codes, blog.vapor.codes,
/// docs.vapor.codes, …).
///
/// The templates are bundled as a SwiftPM resource. Pass ``directory`` into a
/// Kiln site's theme as a shared layer so every site renders the same chrome —
/// header, footer, cards, pagination — while still overriding individual
/// templates locally:
///
/// ```swift
/// import VaporDesignTheme
///
/// theme: .custom(directory: "Theme", sharedLayers: [VaporDesignTheme.directory])
/// ```
///
/// Sites tell the shared partials which site they are by setting a `siteId`
/// custom string (`"main"`, `"blog"`, `"docs"`, or `"apiDocs"`); the partials
/// branch link targets on it so "home" links stay internal on the owning site
/// and point at the canonical absolute URL everywhere else.
public enum VaporDesignTheme {
    /// Absolute URL of the bundled shared theme directory. It contains a
    /// `templates/` folder (and may grow `css/`/`js/` later); hand it to Kiln's
    /// `Theme(sharedLayers:)`.
    public static var directory: URL {
        guard let url = Bundle.module.url(forResource: "Theme", withExtension: nil) else {
            fatalError("VaporDesignTheme resources are missing from the bundle.")
        }
        return url
    }
}
