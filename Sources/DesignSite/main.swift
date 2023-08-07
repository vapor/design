import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct DesignSite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
        case mainPageDemo
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://design.vapor.codes")!
    var name = "Vapor's Design Guide"
    var description = "The style guide for Vapor's design."
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try DesignSite().publish(withTheme: .vapor)
