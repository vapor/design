import Plot
import Publish

public struct PackageCard: Component {
    public let title: String
    public let description: String
    public let icon: String
    public let url: String

    public init(title: String, description: String, icon: String, url: String) {
        self.title = title
        self.description = description
        self.icon = icon
        self.url = url
    }

    public var body: Component {
        Div {
            Div {
                Span().class("vapor-icon feature-card-icon icon-\(icon)")
                H3(title).class("card-title")
                Paragraph(description).class("card-text")
                Link(url: url) {
                    Text("Learn More")
                    Span().class("vapor-icon icon-chevron-right")
                }.linkTarget(.blank).class("learn-more-link")
            }
        }.class("card h-100 vapor-feature-card")
    }
}
