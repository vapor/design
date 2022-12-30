import Plot

public struct SiteFooter: Component {
    public init() {}
    
    public var body: Component {
        Footer {
            Paragraph {
                Text("Copyright © Vapor")
            }
            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
        }
    }
}
